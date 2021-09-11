//
//  File.swift
//  myworkouttracker
//
//  Created by Georgios Galatoulas on 11/04/2020.
//  Copyright © 2020 Georgios Galatoulas. All rights reserved.
//

import Foundation


public class UseCase {
    var entitiesRepo: EntitiesRepo;

    init(entitiesRepo: EntitiesRepo) {
        self.entitiesRepo = entitiesRepo;
    }
}
