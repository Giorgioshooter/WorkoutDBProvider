//
//  GetSetsUseCase.swift
//  myworkouttracker
//
//  Created by Georgios Galatoulas on 04/04/2020.
//  Copyright © 2020 Georgios Galatoulas. All rights reserved.
//

import Foundation

public class GetSetsUseCase: UseCase {

    public func addSet(setEntity: SetEntity) throws {
        try? self.entitiesRepo.addSet(setEntity: setEntity)
    }

    public func getSets(exerciseId:String) throws -> [SetEntity]  {
        try entitiesRepo.fetchSets(with: exerciseId)
    }
}
