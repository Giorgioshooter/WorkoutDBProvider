//
// Created by Georgios Galatoulas on 24/03/2018.
// Copyright (c) 2018 Georgios Galatoulas. All rights reserved.
//

import Foundation

public class ServiceLocator {
    
    public let addSetUseCase: AddSetUseCase!
    public let createExerciseUseCase: CreateExerciseUseCase!
    public let getExercisesUseCase: GetExercisesUseCase!
    public let getExerciseByIdUseCase: GetExerciseByIdUseCase!
    public let getWorkoutUseCase: GetWorkoutUseCase!
    public let getWorkoutByIdUseCase: GetWorkoutByIdUseCase!
    public let getSetsUseCase: GetSetsUseCase!
    public let updateExerciseUseCase: UpdateExerciseUseCase!
    public let updateWorkoutUseCase: UpdateWorkoutUseCase!
    public let removeWorkoutUseCase: RemoveWorkoutUseCase!
    public let removeExerciseUseCase: RemoveExerciseUseCase!
    public let removeSetUseCase: RemoveSetUseCase!
    
    init(entitiesRepo: EntitiesRepo) {
        getExercisesUseCase = GetExercisesUseCase(entitiesRepo: entitiesRepo)
        getWorkoutByIdUseCase = GetWorkoutByIdUseCase(entitiesRepo: entitiesRepo)
        getWorkoutUseCase = GetWorkoutUseCase(entitiesRepo: entitiesRepo)
        updateWorkoutUseCase = UpdateWorkoutUseCase(entitiesRepo: entitiesRepo)
        updateExerciseUseCase = UpdateExerciseUseCase(entitiesRepo: entitiesRepo)
        createExerciseUseCase = CreateExerciseUseCase(entitiesRepo: entitiesRepo)
        getExerciseByIdUseCase = GetExerciseByIdUseCase(entitiesRepo: entitiesRepo)
        addSetUseCase = AddSetUseCase(entitiesRepo: entitiesRepo)
        getSetsUseCase = GetSetsUseCase(entitiesRepo: entitiesRepo)
        removeWorkoutUseCase = RemoveWorkoutUseCase(entitiesRepo: entitiesRepo)
        removeExerciseUseCase = RemoveExerciseUseCase(entitiesRepo: entitiesRepo)
        
        removeSetUseCase = RemoveSetUseCase(entitiesRepo: entitiesRepo)
    }
}
