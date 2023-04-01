//
//  RemoveExerciseUseCaseUnitTests.swift
//  myworkouttrackerTests
//
//  Created by Georgios Galatoulas on 18/10/2020.
//  Copyright © 2020 Georgios Galatoulas. All rights reserved.
//

import Foundation
import XCTest
@testable import WorkoutDBProvider

class RemoveExerciseUseCaseUnitTests: XCTestCase {
    let entitiesRepo = EntityRepoMemory()
    var removeExerciseUseCase:RemoveExerciseUseCase!
    
    override func setUp() {
        do {
            try entitiesRepo.updateExercise(exerciseEntity: getTestExerciseEntity())
        } catch {
            XCTFail("Could not init Entities")
        }
        
        removeExerciseUseCase = RemoveExerciseUseCase(entitiesRepo: entitiesRepo)
    }
    
    func test_remove_exercise()  throws {
        // When
        try removeExerciseUseCase.removeExercise(id: "1")
        
        // Then
        let exercises = try entitiesRepo.fetchExercises()
        
        XCTAssertEqual(exercises.count, 0, "There should not be any exeircise")
    }
    
}
