//
// Created by Georgios Galatoulas on 12/05/2018.
// Copyright (c) 2018 Georgios Galatoulas. All rights reserved.
//

import Foundation
public class UpdateExerciseUseCase : UseCase{

    public func update(exercise: ExerciseEntity) throws {
        try entitiesRepo.updateExercise(exerciseEntity: exercise)
    }
}
