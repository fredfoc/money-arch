//
//  Services.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 26/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation

enum Services {}

class ServicesFactory {
    static var persistentStore:PersistentStore = {
        let container = Services.PersistentStore.ContainerFactory.persistentSQLContainer()
        return Services.PersistentStore.Service(persistentContainer: container)
    }()
}
