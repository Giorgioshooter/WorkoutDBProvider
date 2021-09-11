//
// Created by Georgios Galatoulas on 23/03/2018.
// Copyright (c) 2018 Georgios Galatoulas. All rights reserved.
//

import Foundation

public class GetWorkoutUseCase {

    var entitiesRepo: EntitiesRepo

    init(entitiesRepo: EntitiesRepo) {
        self.entitiesRepo = entitiesRepo
    }

    public func getWorkouts() throws -> [WorkoutEntity] {
        return try entitiesRepo.fetchWorkouts()
    }
}
