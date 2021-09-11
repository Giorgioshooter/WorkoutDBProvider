//
//  GetExercisesUseCaseUnitTest.swift
//  myworkouttracker
//
//  Created by Georgios Galatoulas on 08/04/2018.
//  Copyright © 2018 Georgios Galatoulas. All rights reserved.
//

import Foundation

public class GetExercisesUseCase: UseCase {
    public func getExercise(workoutId: String) throws -> [ExerciseEntity] {
        return try entitiesRepo.fetchExercises(workoutId: workoutId);
    }
}
