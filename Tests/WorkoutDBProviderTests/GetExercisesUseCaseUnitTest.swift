//
//  GetExercisesUseCase.swift
//  myworkouttrackerTests
//
//  Created by Georgios Galatoulas on 08/04/2018.
//  Copyright © 2018 Georgios Galatoulas. All rights reserved.
//

import Foundation
import XCTest
@testable import WorkoutDBProvider

class GetExercisesUseCaseUnitTest: XCTestCase {
    
    var getExercisesUseCase: GetExercisesUseCase!
    
    override func setUp() {
        super.setUp()
        let entitiesRepo = EntityRepoMemory()
        do {
            try entitiesRepo.updateExercise(exerciseEntity: getTestExerciseEntity())
        } catch {
            
        }  
        getExercisesUseCase = GetExercisesUseCase(entitiesRepo: entitiesRepo)
    }

    func test_getExercise_with_workout_id_returns_a_list_of_exercise() throws{
        // When
        let exercises = try getExercisesUseCase.getExercise(workoutId: "1")
        XCTAssertEqual(exercises.count, 1, "Exercise list should not be empty.")
    }
}
