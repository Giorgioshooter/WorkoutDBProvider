//
//  File.swift
//  
//
//  Created by Georgios Galatoulas on 01/04/2023.
//

import Foundation
@testable import WorkoutDBProvider

func getTestExerciseEntity() -> ExerciseEntity {
    return ExerciseEntity(
        id: "1", name: "name", note: "note", workoutId: "1" , weightsIncluded: true
    )
}
