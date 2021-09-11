//
//  GetExerciseByIdUseCaseUnitTests.swift
//  myworkouttrackerTests
//
//  Created by Georgios Galatoulas on 18/10/2020.
//  Copyright © 2020 Georgios Galatoulas. All rights reserved.
//

import Foundation
import XCTest
@testable import WorkoutDBProvider

class GetExerciseByIdUseCaseUnitTests: XCTestCase {
    
    var getExerciseByIdUseCase: GetExerciseByIdUseCase!
    let entitiesRepo = EntityRepoMemory()
    
    override func setUp() {
        do {
            try entitiesRepo.updateExercise(exerciseEntity: ExerciseEntity(
                id: "1", name: "name", note: "note", workoutId: "1"
            ))
        } catch {
            
        }
        getExerciseByIdUseCase = GetExerciseByIdUseCase(entitiesRepo: entitiesRepo);
    }
    
    func test_getExerciseById_returns_an_exercise() throws {
        // When.
        let expectedExercise = try getExerciseByIdUseCase.getExercise(exerciseId: "1")
        
        // Then.
        XCTAssertEqual(expectedExercise.name, "name", "Name is wrong")
        XCTAssertEqual(expectedExercise.note, "note", "Note is wrong")
        XCTAssertEqual(expectedExercise.workoutId, "1", "workout id is wrong")
    }
}
