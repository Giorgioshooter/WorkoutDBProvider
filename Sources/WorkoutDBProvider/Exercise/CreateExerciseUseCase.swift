//
//  CreateExerciseUseCase.swift
//  myworkouttracker
//
//  Created by Georgios Galatoulas on 28/03/2020.
//  Copyright © 2020 Georgios Galatoulas. All rights reserved.
//

public class CreateExerciseUseCase: UseCase {

    public func create(with name: String, workoutId: String, weightsIncluded:Bool = true) throws {
        let exercise = ExerciseEntity(
                id: "",
                name: name,
                note: "",
                workoutId: workoutId,
                weightsIncluded: weightsIncluded
        )
        try entitiesRepo.addExercise(exerciseEntity: exercise)
    }
}
