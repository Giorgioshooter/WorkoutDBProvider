//
//  RemoveWorkoutUseCase.swift
//  myworkouttracker
//
//  Created by Georgios Galatoulas on 03/11/2019.
//  Copyright © 2019 Georgios Galatoulas. All rights reserved.
//

import Foundation
public class RemoveWorkoutUseCase {
    
    var entitiesRepo: EntitiesRepo;
    
    init(entitiesRepo: EntitiesRepo){
        self.entitiesRepo = entitiesRepo;
    }
    
    public func removeWorkout(id:String) {
        entitiesRepo.removeWorkout(id: id)
    }
}
