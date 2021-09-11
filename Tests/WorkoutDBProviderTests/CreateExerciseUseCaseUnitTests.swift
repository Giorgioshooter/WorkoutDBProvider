//
//  CreateExerciseUseCaseUnitTests.swift
//  myworkouttrackerTests
//
//  Created by Georgios Galatoulas on 18/10/2020.
//  Copyright © 2020 Georgios Galatoulas. All rights reserved.
//

import Foundation
import XCTest
@testable import WorkoutDBProvider
class CreateExerciseUseCaseUnitTests: XCTestCase {
    
    var createExerciseUseCase: CreateExerciseUseCase!
    let entitiesRepo = EntityRepoMemory()
    
    override func setUp() {
        createExerciseUseCase = CreateExerciseUseCase(entitiesRepo: entitiesRepo)
    }

    func test_create_an_exercise() throws {
        // When
        try createExerciseUseCase.create(with: "Name", workoutId: "1")

        // Then.
        let exercises = try entitiesRepo.fetchExercises()
        
        XCTAssertEqual(exercises.count, 1, "Should be at least one")
        XCTAssertEqual(exercises[0].name, "Name")
        XCTAssertEqual(exercises[0].workoutId, "1")
    }
    
}
