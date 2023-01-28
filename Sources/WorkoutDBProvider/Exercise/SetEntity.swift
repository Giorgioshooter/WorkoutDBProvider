//
//  SetEntity.swift
//  myworkouttracker
//
//  Created by Georgios Galatoulas on 10/11/2019.
//  Copyright © 2019 Georgios Galatoulas. All rights reserved.
//

import Foundation

/**
 * @param id
 * @param weight
 * @param repetitions
 * @param isWorkingSet
 * @param exerciseId
 * @param metricUnit
 */
public struct SetEntity:Hashable, Identifiable {
    public let id: String
    public let weight: Double
    public let repetitions: Int16
    public let isWorkingSet: Bool
    public let exerciseId: String
    public let metricUnit: String
    public let creationDate: Date
    
    public init(id: String,
                weight: Double,
                repetitions: Int16,
                isWorkingSet: Bool,
                exerciseId: String,
                metricUnit: String,
                creationDate: Date) {
        self.id = id
        self.weight = weight
        self.repetitions = repetitions
        self.isWorkingSet = isWorkingSet
        self.exerciseId = exerciseId
        self.metricUnit = metricUnit
        self.creationDate = creationDate
    }
}
