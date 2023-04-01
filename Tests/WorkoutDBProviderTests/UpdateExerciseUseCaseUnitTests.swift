//
//  UpdateExerciseUseCaseUnitTests.swift
//  myworkouttrackerTests
//
//  Created by Georgios Galatoulas on 18/10/2020.
//  Copyright © 2020 Georgios Galatoulas. All rights reserved.
//


import Foundation
import XCTest
@testable import WorkoutDBProvider

class UpdateExerciseUseCaseUnitTests: XCTestCase {
    
    var updateExerciseUseCase: UpdateExerciseUseCase!
    let entitiesRepo = EntityRepoMemory()

    override func setUp() {
        super.setUp()
        updateExerciseUseCase = UpdateExerciseUseCase(entitiesRepo: entitiesRepo)
    }
    
    
    func test_updateExercise_adds_an_exercise() throws {
        // Given.
        let exercise =  getTestExerciseEntity()
        // When.
        try updateExerciseUseCase.update(exercise: exercise)
        
        // Then.
        let actualExercise = try entitiesRepo.fetchExerciseById(id: "1")
        XCTAssertEqual(actualExercise, exercise)
    }
    
    func test_updateExercise_updates_a_given_exercise() throws {
        // Given.
        let exercise =  ExerciseEntity(
            id: "1", name: "name", note: "note", workoutId: "1", weightsIncluded: true
        )
        try updateExerciseUseCase.update(exercise: exercise)
        let exercise2 =  ExerciseEntity(
            id: "1", name: "name2", note: "note2", workoutId: "1", weightsIncluded: true
        )
        
        // When.
        try updateExerciseUseCase.update(exercise: exercise2)
        
        // Then.
        let actualExercise = try entitiesRepo.fetchExerciseById(id: "1")
        
        XCTAssertEqual(actualExercise, exercise2)
    }
}
