//
//  GetSetsUseCaseUnitTests.swift
//  myworkouttrackerTests
//
//  Created by Georgios Galatoulas on 18/10/2020.
//  Copyright © 2020 Georgios Galatoulas. All rights reserved.
//

import Foundation
import XCTest
@testable import WorkoutDBProvider

class GetSetsUseCaseUnitTests: XCTestCase {
    var getSetsUseCase: GetSetsUseCase!
    let entitiesRepo = EntityRepoMemory()
    
    override func setUp() {
        do {
            try entitiesRepo.updateExercise(exerciseEntity: ExerciseEntity(
                id: "1", name: "name", note: "note", workoutId: "1"
            ))
            let set = SetEntity(
                id: "",
                weight: 100,
                repetitions: 10,
                isWorkingSet: true,
                exerciseId: "1",
                metricUnit: "Kg",
                creationDate: Date()
            )
            try entitiesRepo.addSet(setEntity: set)
        } catch {
            
        }
        getSetsUseCase = GetSetsUseCase(entitiesRepo: entitiesRepo)
    }
    
    func test_getSets_returns_set() throws {
        // When
        let sets = try getSetsUseCase.getSets(exerciseId: "1")
        // Then
        XCTAssertEqual(sets[0].weight, 100, "Weight is not correct")
        XCTAssertEqual(sets[0].repetitions, 10, "Reps are not correct")
        XCTAssertEqual(sets[0].isWorkingSet, true, "isWorkingSet is not correct")
        XCTAssertEqual(sets[0].exerciseId, "1", "exerciseId is not correct")
        XCTAssertEqual(sets[0].metricUnit, "Kg", "metricUnit is not correct")
    }
}
