//
// Created by Georgios Galatoulas on 19/05/2018.
// Copyright (c) 2018 Georgios Galatoulas. All rights reserved.
//

import Foundation

public class GetExerciseByIdUseCase: UseCase {
    public func getExercise(exerciseId:String) throws -> ExerciseEntity {
        return try self.entitiesRepo.fetchExerciseById(id: exerciseId);
    }
}
