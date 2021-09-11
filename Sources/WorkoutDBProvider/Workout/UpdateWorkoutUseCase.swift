//
//  updateWorkoutUseCase.swift
//  myworkouttracker
//
//  Created by Georgios Galatoulas on 29/04/2018.
//  Copyright © 2018 Georgios Galatoulas. All rights reserved.
//

import Foundation

public class UpdateWorkoutUseCase {

    var entitiesRepo: EntitiesRepo;

    init(entitiesRepo: EntitiesRepo){
        self.entitiesRepo = entitiesRepo;
    }

    public func updateWorkout(workout:WorkoutEntity) throws  {
        try entitiesRepo.updateWorkout(workoutEntity: workout);
    }
    
    public func addWorkout(workout:WorkoutEntity) throws {
        try entitiesRepo.addWorkout(workoutEntity: workout)
    }

}
