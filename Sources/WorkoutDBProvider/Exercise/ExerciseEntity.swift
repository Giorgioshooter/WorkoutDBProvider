//
// Created by Georgios Galatoulas on 23/03/2018.
// Copyright (c) 2018 Georgios Galatoulas. All rights reserved.
//

import Foundation

public struct ExerciseEntity: Hashable, Identifiable {
    public let id: String
    public let name: String
    public let note: String
    public let workoutId: String
    public let weightsIncluded: Bool
    
    public init(id: String,name: String,note: String,workoutId: String, weightsIncluded: Bool) {
        self.id = id
        self.name = name
        self.note = note
        self.workoutId = workoutId
        self.weightsIncluded = weightsIncluded;
    }
}
