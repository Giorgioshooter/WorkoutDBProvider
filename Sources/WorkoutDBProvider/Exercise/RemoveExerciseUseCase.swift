//
//  RemoveExerciseUseCase.swift
//  myworkouttracker
//
//  Created by Georgios Galatoulas on 11/04/2020.
//  Copyright © 2020 Georgios Galatoulas. All rights reserved.
//

import Foundation

public class RemoveExerciseUseCase:UseCase {
    
    public func removeExercise(id: String) throws {
        return entitiesRepo.removeExercise(id: id)
    }
}
