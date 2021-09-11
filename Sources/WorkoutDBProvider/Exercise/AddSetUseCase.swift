//
// Created by Georgios Galatoulas on 29/03/2020.
// Copyright (c) 2020 Georgios Galatoulas. All rights reserved.
//

import Foundation

public class AddSetUseCase: UseCase {

    public func addSet(setEntity: SetEntity) throws {
        try? self.entitiesRepo.addSet(setEntity: setEntity)
    }

}
