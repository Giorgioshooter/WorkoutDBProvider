//
// Created by Georgios Galatoulas on 23/03/2018.
// Copyright (c) 2018 Georgios Galatoulas. All rights reserved.
//

import Foundation

public struct WorkoutEntity: Hashable, Identifiable {
    
    public let id: String
    public let workoutDescription: String
    public let workoutDate: Date
    
    public init(id:String, workoutDescription:String, workoutDate:Date) {
        self.id = id
        self.workoutDescription = workoutDescription
        self.workoutDate = workoutDate
    }
    
    public static func == (lhs: WorkoutEntity, rhs: WorkoutEntity) -> Bool {
        return lhs.id == rhs.id
            && lhs.workoutDescription == rhs.workoutDescription
            && lhs.workoutDate == rhs.workoutDate
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(workoutDescription)
        hasher.combine(workoutDate)
    }
}
