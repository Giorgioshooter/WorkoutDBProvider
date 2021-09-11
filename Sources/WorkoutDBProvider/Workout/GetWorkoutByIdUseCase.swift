//
//  GetWorkoutByIdUseCase.swift
//  myworkouttracker
//
//  Created by Georgios Galatoulas on 29/04/2018.
//  Copyright © 2018 Georgios Galatoulas. All rights reserved.
//

import Foundation

public class GetWorkoutByIdUseCase {
    
    var entitiesRepo: EntitiesRepo;
    
    init(entitiesRepo: EntitiesRepo){
        self.entitiesRepo = entitiesRepo;
    }
    
    public func getWorkout(id:String) throws -> WorkoutEntity {
        return try self.entitiesRepo.fetchWorkoutById(id:id);
    }
}
