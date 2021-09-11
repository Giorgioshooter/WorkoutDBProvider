//
//  EntitiesRepoError.swift
//  myworkouttracker
//
//  Created by Georgios Galatoulas on 08/04/2018.
//  Copyright © 2018 Georgios Galatoulas. All rights reserved.
//

import Foundation


enum EntitiesRepoError: Error {
    case noWorkoutsFound,
    noExercisesFound,
    noWorkoutFound,
    noExerciseFount,
    errorOnExerciseUpdate,
    errorOnWorkoutUpdate,
    errorOnExerciseAddition,
    errorOnWorkoutAddition,
    errorOnExerciseRemove,
    errorOnWorkoutRemove,
    errorOnAddSet
}
