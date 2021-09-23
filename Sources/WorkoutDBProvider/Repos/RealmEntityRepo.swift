//
//  RealmEntityRepo.swift
//  myworkouttracker
//
//  Created by Georgios Galatoulas on 15/03/2020.
//  Copyright © 2020 Georgios Galatoulas. All rights reserved.
//

import Foundation
import RealmSwift

class RealmEntityRepo: EntitiesRepo {

    let realm: Realm

    init() {
        realm = try! Realm()
    }

    func addSet(setEntity: SetEntity) throws {
        let set = Set()
        set.id = UUID.init().uuidString
        set.repetitions = setEntity.repetitions
        set.isWorkingSet = setEntity.isWorkingSet
        set.weight = setEntity.weight
        set.unit = setEntity.metricUnit

        guard let exercise = realm.object(ofType: Exercise.self, forPrimaryKey: setEntity.exerciseId) else {
            throw EntitiesRepoError.noExerciseFount
        }

        set.exercise = exercise

        do {
            try realm.write {
                realm.add(set)
            }
        } catch {
            throw EntitiesRepoError.errorOnAddSet
        }
    }

    func fetchSets(with exerciseId: String) throws -> [SetEntity] {
        guard let exercise = realm.object(ofType: Exercise.self, forPrimaryKey: exerciseId) else {
            throw EntitiesRepoError.noExerciseFount
        }
        let sets = realm.objects(Set.self).filter("exercise == %@", exercise)
        return convertSets(sets)
    }

    func addWorkout(workoutEntity: WorkoutEntity) throws {
        let workout = Workout()
        workout.id = UUID.init().uuidString
        workout.name = workoutEntity.workoutDescription
        workout.date = workoutEntity.workoutDate
        do {
            try realm.write {
                realm.add(workout)
            }
        } catch {
            throw EntitiesRepoError.errorOnWorkoutAddition
        }
    }

    func addExercise(exerciseEntity: ExerciseEntity) throws {
        let exercise = Exercise()
        exercise.id = UUID.init().uuidString
        exercise.name = exerciseEntity.name
        exercise.note = exerciseEntity.note

        guard let workout = realm.object(ofType: Workout.self, forPrimaryKey: exerciseEntity.workoutId) else {
            throw EntitiesRepoError.noWorkoutFound
        }

        exercise.workout = workout

        do {
            try realm.write {
                realm.add(exercise)
            }
        } catch {
            throw EntitiesRepoError.errorOnExerciseAddition
        }
    }


    func fetchWorkouts() throws -> [WorkoutEntity] {
        let workouts = realm.objects(Workout.self)
        return workouts.map { (workout) -> WorkoutEntity in
            WorkoutEntity(id: workout.id,
                    workoutDescription: workout.name,
                    workoutDate: workout.date)
        }
    }

    func fetchExercises() throws -> [ExerciseEntity] {
        let exercises = realm.objects(Exercise.self)
        return convertExercises(exercises)
    }

    fileprivate func convertExercises(_ exercises: Results<Exercise>) -> [ExerciseEntity] {
        exercises.map { (exercise) -> ExerciseEntity in
            ExerciseEntity(
                    id: exercise.id,
                    name: exercise.name,
                    note: exercise.note,
                    workoutId: exercise.workout!.id // Must have a work out
            )
        }
    }

    fileprivate func convertSets(_ sets: Results<Set>) -> [SetEntity] {
        sets.map { (set) -> SetEntity in
            SetEntity(id: set.id,
                    weight: set.weight,
                    repetitions: set.repetitions,
                    isWorkingSet: set.isWorkingSet,
                    exerciseId: set.exercise!.id,
                    metricUnit: set.unit,
                    creationDate: set.creationDate
            )
        }
    }

    func fetchExercises(workoutId: String) throws -> [ExerciseEntity] {
        if let workout = realm.object(ofType: Workout.self, forPrimaryKey: workoutId) {
            let exercises = realm.objects(Exercise.self).filter("workout == %@", workout)
            return convertExercises(exercises)
        } else {
            return []
        }
    }

    func fetchWorkoutById(id: String) throws -> WorkoutEntity {
        guard let workout = realm.object(ofType: Workout.self, forPrimaryKey: id) else {
            throw EntitiesRepoError.noWorkoutFound
        }
        return WorkoutEntity(id: workout.id,
                workoutDescription: workout.name,
                workoutDate: workout.date
        )
    }

    func fetchExerciseById(id: String) throws -> ExerciseEntity {
        guard let exercise = realm.object(ofType: Exercise.self, forPrimaryKey: id) else {
            throw EntitiesRepoError.noExerciseFount
        }
        return ExerciseEntity(id: exercise.id,
                name: exercise.name,
                note: exercise.note,
                workoutId: exercise.workout!.id)
    }

    func updateWorkout(workoutEntity: WorkoutEntity) throws {
        let workout = Workout()
        workout.id = workoutEntity.id
        workout.name = workoutEntity.workoutDescription
        workout.date = workoutEntity.workoutDate
        do {
            try realm.write {
                realm.add(workout, update: .modified)
            }
        } catch {
            throw EntitiesRepoError.errorOnWorkoutUpdate
        }
    }

    func updateExercise(exerciseEntity: ExerciseEntity) throws {
        let exercise = Exercise()
        exercise.id = exerciseEntity.id
        exercise.name = exerciseEntity.name
        exercise.note = exerciseEntity.note
        if let workout = realm.object(ofType: Workout.self, forPrimaryKey: exerciseEntity.workoutId) {
            exercise.workout = workout
        }
        do {
            try realm.write {
                realm.add(exercise, update: .modified)
            }
        } catch {
            throw EntitiesRepoError.errorOnExerciseUpdate
        }
    }

    func removeWorkout(id: String) {
        if let workout = realm.object(ofType: Workout.self, forPrimaryKey: id) {

            let exercises = realm.objects(Exercise.self).filter("workout == %@", workout)

            for exercise in exercises {
                let sets = realm.objects(Set.self).filter("exercise == %@", exercise)
                try! realm.write {
                    realm.delete(sets)
                }
            }

            try! realm.write {
                realm.delete(exercises)
                realm.delete(workout)
            }
        }
    }

    func removeExercise(id: String) {
        if let exercise = realm.object(ofType: Exercise.self, forPrimaryKey: id) {
            let sets = realm.objects(Set.self).filter("exercise == %@", exercise)
            try! realm.write {
                realm.delete(sets)
                realm.delete(exercise)
            }
        }
    }

    func removeSet(id: String) {
        if let set = realm.object(ofType: Set.self, forPrimaryKey: id) {
            try! realm.write {
                realm.delete(set)
            }
        }
    }
}


class Exercise: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var note = ""
    @objc dynamic var workout: Workout?

    override class func primaryKey() -> String? {
        "id"
    }
}

class Workout: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var date = Date()

    override class func primaryKey() -> String? {
        "id"
    }
}

class Set: Object {
    @objc dynamic var id = ""
    @objc dynamic var weight: Double = 0.0
    @objc dynamic var repetitions: Int16 = 0
    @objc dynamic var isWorkingSet: Bool = false
    @objc dynamic var unit: String = "Kg"
    @objc dynamic var exercise: Exercise?
    @objc dynamic var creationDate: Date = Date()

    override class func primaryKey() -> String? {
        "id"
    }
}
