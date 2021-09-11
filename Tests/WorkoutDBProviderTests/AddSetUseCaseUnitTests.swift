//
//  AddSetUseCaseUnitTests.swift
//  myworkouttrackerTests
//
//  Created by Georgios Galatoulas on 18/10/2020.
//  Copyright © 2020 Georgios Galatoulas. All rights reserved.
//

import Foundation
import XCTest
@testable import WorkoutDBProvider

class AddSetUseCaseUnitTests: XCTestCase {
    
    var addSetUseCase:AddSetUseCase!
    let entitiesRepo = EntityRepoMemory()

    override func setUp() {
        super.setUp()
        
        do {
            try entitiesRepo.updateExercise(exerciseEntity: ExerciseEntity(
                id: "1", name: "name", note: "note", workoutId: "1"
            ))
        } catch {
            
        }
        addSetUseCase = AddSetUseCase(entitiesRepo: entitiesRepo);
    }

    func test_AddSet_with_workout_id_returns_a_list_of_exercise() throws{
        // Given
        let set = SetEntity(
            id: "",
            weight: 100,
            repetitions: 10,
            isWorkingSet: true,
            exerciseId: "1",
            metricUnit: "Kg",
            creationDate: Date()
        )
        // When
        try addSetUseCase.addSet(setEntity: set)
        
        // Then
        let sets = try entitiesRepo.fetchSets(with: "1")
        XCTAssertEqual(sets[0].weight, set.weight, "Weight is not the same")
        XCTAssertEqual(sets[0].repetitions, set.repetitions, "reps are not the same")
        XCTAssertEqual(sets[0].isWorkingSet, set.isWorkingSet, "working Set is not the same")
        XCTAssertEqual(sets[0].exerciseId, set.exerciseId, "exerciseId")
        XCTAssertEqual(sets[0].metricUnit, set.metricUnit, "Metric Unit is not the same")
    }
}
