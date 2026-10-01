//
//  SQLiteEntityRepo.swift
//

import Foundation
import SQLite3

private let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

/// `EntitiesRepo` backed by the SQLite library that ships with iOS/macOS (no extra dependency).
/// Pass `":memory:"` as the path for a throwaway in-memory database.
class SQLiteEntityRepo: EntitiesRepo {

    private var db: OpaquePointer?

    init(path: String = SQLiteEntityRepo.defaultPath()) throws {
        guard sqlite3_open(path, &db) == SQLITE_OK else {
            sqlite3_close(db)
            throw EntitiesRepoError.errorOnDatabaseOpen
        }
        try execute("PRAGMA foreign_keys = ON;")
        try createTables()
    }

    deinit {
        sqlite3_close(db)
    }

    static func defaultPath() -> String {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return directory.appendingPathComponent("workouts.sqlite").path
    }

    // MARK: - Schema

    private func createTables() throws {
        try execute("""
            CREATE TABLE IF NOT EXISTS workout (
                id TEXT PRIMARY KEY NOT NULL,
                name TEXT NOT NULL,
                date REAL NOT NULL
            );
            CREATE TABLE IF NOT EXISTS exercise (
                id TEXT PRIMARY KEY NOT NULL,
                name TEXT NOT NULL,
                note TEXT NOT NULL,
                weights_included INTEGER NOT NULL,
                workout_id TEXT NOT NULL REFERENCES workout(id) ON DELETE CASCADE
            );
            CREATE TABLE IF NOT EXISTS exercise_set (
                id TEXT PRIMARY KEY NOT NULL,
                weight REAL NOT NULL,
                repetitions INTEGER NOT NULL,
                is_working_set INTEGER NOT NULL,
                unit TEXT NOT NULL,
                creation_date REAL NOT NULL,
                exercise_id TEXT NOT NULL REFERENCES exercise(id) ON DELETE CASCADE
            );
            CREATE INDEX IF NOT EXISTS idx_exercise_workout ON exercise(workout_id);
            CREATE INDEX IF NOT EXISTS idx_set_exercise ON exercise_set(exercise_id);
            """)
    }

    // MARK: - Workouts

    func fetchWorkouts() throws -> [WorkoutEntity] {
        try query("SELECT id, name, date FROM workout;", [], map: workout(from:))
    }

    func fetchWorkoutById(id: String) throws -> WorkoutEntity {
        guard let workout = try query("SELECT id, name, date FROM workout WHERE id = ?;",
                                      [.text(id)], map: workout(from:)).first else {
            throw EntitiesRepoError.noWorkoutFound
        }
        return workout
    }

    func addWorkout(workoutEntity: WorkoutEntity) throws {
        do {
            try run("INSERT INTO workout (id, name, date) VALUES (?, ?, ?);",
                    [.text(UUID().uuidString),
                     .text(workoutEntity.workoutDescription),
                     .real(workoutEntity.workoutDate.timeIntervalSince1970)])
        } catch {
            throw EntitiesRepoError.errorOnWorkoutAddition
        }
    }

    func updateWorkout(workoutEntity: WorkoutEntity) throws {
        do {
            try run("""
                INSERT INTO workout (id, name, date) VALUES (?, ?, ?)
                ON CONFLICT(id) DO UPDATE SET name = excluded.name, date = excluded.date;
                """,
                    [.text(workoutEntity.id.isEmpty ? UUID().uuidString : workoutEntity.id),
                     .text(workoutEntity.workoutDescription),
                     .real(workoutEntity.workoutDate.timeIntervalSince1970)])
        } catch {
            throw EntitiesRepoError.errorOnWorkoutUpdate
        }
    }

    func removeWorkout(id: String) {
        // Exercises and sets are removed by ON DELETE CASCADE.
        try? run("DELETE FROM workout WHERE id = ?;", [.text(id)])
    }

    // MARK: - Exercises

    private let exerciseColumns = "id, name, note, weights_included, workout_id"

    func fetchExercises() throws -> [ExerciseEntity] {
        try query("SELECT \(exerciseColumns) FROM exercise;", [], map: exercise(from:))
    }

    func fetchExercises(workoutId: String) throws -> [ExerciseEntity] {
        try query("SELECT \(exerciseColumns) FROM exercise WHERE workout_id = ?;",
                  [.text(workoutId)], map: exercise(from:))
    }

    func fetchExerciseById(id: String) throws -> ExerciseEntity {
        guard let exercise = try query("SELECT \(exerciseColumns) FROM exercise WHERE id = ?;",
                                       [.text(id)], map: exercise(from:)).first else {
            throw EntitiesRepoError.noExerciseFount
        }
        return exercise
    }

    func addExercise(exerciseEntity: ExerciseEntity) throws {
        guard try exists(table: "workout", id: exerciseEntity.workoutId) else {
            throw EntitiesRepoError.noWorkoutFound
        }
        do {
            try run("""
                INSERT INTO exercise (id, name, note, weights_included, workout_id)
                VALUES (?, ?, ?, ?, ?);
                """,
                    [.text(UUID().uuidString),
                     .text(exerciseEntity.name),
                     .text(exerciseEntity.note),
                     .int(exerciseEntity.weightsIncluded ? 1 : 0),
                     .text(exerciseEntity.workoutId)])
        } catch {
            throw EntitiesRepoError.errorOnExerciseAddition
        }
    }

    func updateExercise(exerciseEntity: ExerciseEntity) throws {
        do {
            try run("""
                INSERT INTO exercise (id, name, note, weights_included, workout_id)
                VALUES (?, ?, ?, ?, ?)
                ON CONFLICT(id) DO UPDATE SET
                    name = excluded.name,
                    note = excluded.note,
                    weights_included = excluded.weights_included,
                    workout_id = excluded.workout_id;
                """,
                    [.text(exerciseEntity.id.isEmpty ? UUID().uuidString : exerciseEntity.id),
                     .text(exerciseEntity.name),
                     .text(exerciseEntity.note),
                     .int(exerciseEntity.weightsIncluded ? 1 : 0),
                     .text(exerciseEntity.workoutId)])
        } catch {
            throw EntitiesRepoError.errorOnExerciseUpdate
        }
    }

    func removeExercise(id: String) {
        try? run("DELETE FROM exercise WHERE id = ?;", [.text(id)])
    }

    // MARK: - Sets

    func fetchSets(with exerciseId: String) throws -> [SetEntity] {
        guard try exists(table: "exercise", id: exerciseId) else {
            throw EntitiesRepoError.noExerciseFount
        }
        return try query("""
            SELECT id, weight, repetitions, is_working_set, exercise_id, unit, creation_date
            FROM exercise_set WHERE exercise_id = ? ORDER BY creation_date;
            """, [.text(exerciseId)], map: set(from:))
    }

    func addSet(setEntity: SetEntity) throws {
        guard try exists(table: "exercise", id: setEntity.exerciseId) else {
            throw EntitiesRepoError.noExerciseFount
        }
        do {
            try run("""
                INSERT INTO exercise_set
                    (id, weight, repetitions, is_working_set, unit, creation_date, exercise_id)
                VALUES (?, ?, ?, ?, ?, ?, ?);
                """,
                    [.text(UUID().uuidString),
                     .real(setEntity.weight),
                     .int(Int64(setEntity.repetitions)),
                     .int(setEntity.isWorkingSet ? 1 : 0),
                     .text(setEntity.metricUnit),
                     .real(setEntity.creationDate.timeIntervalSince1970),
                     .text(setEntity.exerciseId)])
        } catch {
            throw EntitiesRepoError.errorOnAddSet
        }
    }

    func removeSet(id: String) {
        try? run("DELETE FROM exercise_set WHERE id = ?;", [.text(id)])
    }

    // MARK: - Row mapping

    private func workout(from s: OpaquePointer) -> WorkoutEntity {
        WorkoutEntity(id: text(s, 0),
                      workoutDescription: text(s, 1),
                      workoutDate: Date(timeIntervalSince1970: sqlite3_column_double(s, 2)))
    }

    private func exercise(from s: OpaquePointer) -> ExerciseEntity {
        ExerciseEntity(id: text(s, 0),
                       name: text(s, 1),
                       note: text(s, 2),
                       workoutId: text(s, 4),
                       weightsIncluded: sqlite3_column_int(s, 3) != 0)
    }

    private func set(from s: OpaquePointer) -> SetEntity {
        SetEntity(id: text(s, 0),
                  weight: sqlite3_column_double(s, 1),
                  repetitions: Int16(truncatingIfNeeded: sqlite3_column_int(s, 2)),
                  isWorkingSet: sqlite3_column_int(s, 3) != 0,
                  exerciseId: text(s, 4),
                  metricUnit: text(s, 5),
                  creationDate: Date(timeIntervalSince1970: sqlite3_column_double(s, 6)))
    }

    private func text(_ statement: OpaquePointer, _ column: Int32) -> String {
        guard let cString = sqlite3_column_text(statement, column) else { return "" }
        return String(cString: cString)
    }

    // MARK: - SQLite helpers

    private enum Value {
        case text(String)
        case real(Double)
        case int(Int64)
    }

    private func execute(_ sql: String) throws {
        guard sqlite3_exec(db, sql, nil, nil, nil) == SQLITE_OK else {
            throw EntitiesRepoError.errorOnDatabaseOpen
        }
    }

    private func prepare(_ sql: String, _ values: [Value]) throws -> OpaquePointer {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK, let statement = statement else {
            sqlite3_finalize(statement)
            throw EntitiesRepoError.databaseError(message())
        }
        for (index, value) in values.enumerated() {
            let position = Int32(index + 1)
            switch value {
            case .text(let string): sqlite3_bind_text(statement, position, string, -1, SQLITE_TRANSIENT)
            case .real(let double): sqlite3_bind_double(statement, position, double)
            case .int(let int): sqlite3_bind_int64(statement, position, int)
            }
        }
        return statement
    }

    private func run(_ sql: String, _ values: [Value]) throws {
        let statement = try prepare(sql, values)
        defer { sqlite3_finalize(statement) }
        guard sqlite3_step(statement) == SQLITE_DONE else {
            throw EntitiesRepoError.databaseError(message())
        }
    }

    private func query<T>(_ sql: String, _ values: [Value], map: (OpaquePointer) -> T) throws -> [T] {
        let statement = try prepare(sql, values)
        defer { sqlite3_finalize(statement) }
        var results: [T] = []
        while true {
            switch sqlite3_step(statement) {
            case SQLITE_ROW: results.append(map(statement))
            case SQLITE_DONE: return results
            default: throw EntitiesRepoError.databaseError(message())
            }
        }
    }

    private func exists(table: String, id: String) throws -> Bool {
        try !query("SELECT 1 FROM \(table) WHERE id = ?;", [.text(id)], map: { _ in true }).isEmpty
    }

    private func message() -> String {
        db.flatMap { String(cString: sqlite3_errmsg($0)) } ?? "unknown"
    }
}
