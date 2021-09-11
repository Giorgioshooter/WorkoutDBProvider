//
// Created by Georgios Galatoulas on 13/04/2020.
// Copyright (c) 2020 Georgios Galatoulas. All rights reserved.
//

import Foundation

public class RemoveSetUseCase: UseCase {
    public func removeSet(id: String) {
        entitiesRepo.removeSet(id: id)
    }
}
