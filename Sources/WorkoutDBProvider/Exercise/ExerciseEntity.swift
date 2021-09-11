//
// Created by Georgios Galatoulas on 23/03/2018.
// Copyright (c) 2018 Georgios Galatoulas. All rights reserved.
//

import Foundation

public struct ExerciseEntity: Hashable {
    public let id: String
    public let name: String
    public let note: String
    public let workoutId: String
    
    public init(id: String,name: String,note: String,workoutId: String) {
        self.id = id
        self.name = name
        self.note = note
        self.workoutId = workoutId
    }
}
