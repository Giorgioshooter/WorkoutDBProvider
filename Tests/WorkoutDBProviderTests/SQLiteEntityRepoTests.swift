import XCTest
@testable import WorkoutDBProvider

final class SQLiteEntityRepoTests: XCTestCase {

    private func makeRepo() throws -> SQLiteEntityRepo {
        try SQLiteEntityRepo(path: ":memory:")
    }

    private func seed(_ repo: SQLiteEntityRepo) throws -> (WorkoutEntity, ExerciseEntity) {
        try repo.addWorkout(workoutEntity: WorkoutEntity(id: "", workoutDescription: "Push", workoutDate: Date(timeIntervalSince1970: 1000)))
        let workout = try repo.fetchWorkouts()[0]
        try repo.addExercise(exerciseEntity: ExerciseEntity(id: "", name: "Bench", note: "n", workoutId: workout.id, weightsIncluded: true))
        return (workout, try repo.fetchExercises()[0])
    }

    func testWorkoutRoundTripAndUpdate() throws {
        let repo = try makeRepo()
        let (workout, _) = try seed(repo)
        XCTAssertEqual(workout.workoutDescription, "Push")
        XCTAssertEqual(workout.workoutDate, Date(timeIntervalSince1970: 1000))
        try repo.updateWorkout(workoutEntity: WorkoutEntity(id: workout.id, workoutDescription: "Pull", workoutDate: workout.workoutDate))
        XCTAssertEqual(try repo.fetchWorkoutById(id: workout.id).workoutDescription, "Pull")
        XCTAssertEqual(try repo.fetchWorkouts().count, 1)
    }

    func testUpdatingWorkoutKeepsChildren() throws {
        let repo = try makeRepo()
        let (workout, _) = try seed(repo)
        try repo.updateWorkout(workoutEntity: WorkoutEntity(id: workout.id, workoutDescription: "X", workoutDate: Date()))
        XCTAssertEqual(try repo.fetchExercises(workoutId: workout.id).count, 1)
    }

    func testSetsAndCascadeDelete() throws {
        let repo = try makeRepo()
        let (workout, exercise) = try seed(repo)
        let date = Date(timeIntervalSince1970: 5)
        try repo.addSet(setEntity: SetEntity(id: "", weight: 60.5, repetitions: 8, isWorkingSet: true, exerciseId: exercise.id, metricUnit: "Kg", creationDate: date))
        let sets = try repo.fetchSets(with: exercise.id)
        XCTAssertEqual(sets.count, 1)
        XCTAssertEqual(sets[0].weight, 60.5)
        XCTAssertEqual(sets[0].creationDate, date)
        repo.removeWorkout(id: workout.id)
        XCTAssertTrue(try repo.fetchExercises().isEmpty)
        XCTAssertThrowsError(try repo.fetchSets(with: exercise.id))
    }

    func testMissingParentsThrow() throws {
        let repo = try makeRepo()
        XCTAssertThrowsError(try repo.addExercise(exerciseEntity: ExerciseEntity(id: "", name: "a", note: "", workoutId: "nope", weightsIncluded: true)))
        XCTAssertThrowsError(try repo.fetchWorkoutById(id: "nope"))
        XCTAssertThrowsError(try repo.fetchExerciseById(id: "nope"))
    }
}
