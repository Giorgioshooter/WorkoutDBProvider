//
// Created by Georgios Galatoulas on 24/03/2018.
// Copyright (c) 2018 Georgios Galatoulas. All rights reserved.
//

import Foundation

class EntityRepoMemory: EntitiesRepo {

    var sets: [String: SetEntity] = [:]
    var exercises: [String: ExerciseEntity] = [:]
    var workouts: [String: WorkoutEntity] = [:]

    func addWorkout(workoutEntity: WorkoutEntity) throws {
        let newWorkoutEntity = WorkoutEntity(
                id: UUID.init().uuidString,
                workoutDescription: workoutEntity.workoutDescription,
                workoutDate: workoutEntity.workoutDate);
        workouts[newWorkoutEntity.id] = newWorkoutEntity
    }

    func addSet(setEntity: SetEntity) throws {
        let newSetEntity = SetEntity(id: UUID.init().uuidString,
                                     weight: setEntity.weight,
                                     repetitions: setEntity.repetitions,
                                     isWorkingSet: setEntity.isWorkingSet,
                                     exerciseId: setEntity.exerciseId,
                                     metricUnit: setEntity.metricUnit,
                                     creationDate: setEntity.creationDate
        )
        sets[newSetEntity.id] = newSetEntity
    }

    func removeSet(id: String) {
        sets[id] = nil
    }

    func addExercise(exerciseEntity: ExerciseEntity) throws {
        let newExerciseEntity = ExerciseEntity(id: UUID.init().uuidString,
                name: exerciseEntity.name,
                note: exerciseEntity.note,
                workoutId:
                exerciseEntity.workoutId
        )
        exercises[newExerciseEntity.id] = newExerciseEntity
    }

    func fetchWorkoutById(id: String) throws -> WorkoutEntity {
        guard let workout = workouts[id] else {
            throw EntitiesRepoError.noWorkoutFound
        }
        return workout
    }

    func fetchExerciseById(id: String) throws -> ExerciseEntity {
        guard let exercise = exercises[id] else {
            throw EntitiesRepoError.noExerciseFount
        }
        return exercise
    }

    func fetchWorkouts() throws -> [WorkoutEntity] {
        [WorkoutEntity](workouts.values)
    }

    func fetchExercises() throws -> [ExerciseEntity] {
        [ExerciseEntity](exercises.values)
    }

    func updateWorkout(workoutEntity: WorkoutEntity) throws {
        if (workoutEntity.id != "") {
            workouts[workoutEntity.id] = workoutEntity
        } else {
            let newWorkoutEntity = WorkoutEntity(
                    id: UUID.init().uuidString,
                    workoutDescription: workoutEntity.workoutDescription,
                    workoutDate: workoutEntity.workoutDate);
            workouts[newWorkoutEntity.id] = newWorkoutEntity
        }
    }

    func updateExercise(exerciseEntity: ExerciseEntity) throws {
        if (exerciseEntity.id != "") {
            exercises[exerciseEntity.id] = exerciseEntity
        } else {
            let newExerciseEntity = ExerciseEntity(id: UUID.init().uuidString,
                    name: exerciseEntity.name,
                    note: exerciseEntity.note,
                    workoutId:
                    exerciseEntity.workoutId
            )
            exercises[newExerciseEntity.id] = newExerciseEntity
        }
    }

    func fetchExercises(workoutId: String) throws -> [ExerciseEntity] {
        [ExerciseEntity](exercises.values).filter { (exercise) -> Bool in
            exercise.workoutId == workoutId
        }
    }

    func removeWorkout(id: String) {
        workouts[id] = nil
    }

    func removeExercise(id: String) {
        exercises[id] = nil
    }
    
     func fetchSets(with exerciseId: String) throws -> [SetEntity] {
        [SetEntity](sets.values).filter { (set) -> Bool in
            set.exerciseId == exerciseId
        }
    }
}
