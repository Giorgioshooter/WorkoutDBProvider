//
// Created by Georgios Galatoulas on 23/03/2018.
// Copyright (c) 2018 Georgios Galatoulas. All rights reserved.
//

import Foundation

protocol EntitiesRepo {

    func fetchWorkouts() throws -> [WorkoutEntity]

    func fetchExercises() throws -> [ExerciseEntity]

    func fetchExercises(workoutId: String) throws -> [ExerciseEntity]

    func fetchWorkoutById(id: String) throws -> WorkoutEntity

    func fetchExerciseById(id: String) throws -> ExerciseEntity

    func addWorkout(workoutEntity: WorkoutEntity) throws

    func addExercise(exerciseEntity: ExerciseEntity) throws

    func addSet(setEntity: SetEntity) throws

    func fetchSets(with exerciseId: String) throws -> [SetEntity]

    func updateWorkout(workoutEntity: WorkoutEntity) throws

    func updateExercise(exerciseEntity: ExerciseEntity) throws

    func removeWorkout(id: String)

    func removeExercise(id: String)

    func removeSet(id: String)
}
