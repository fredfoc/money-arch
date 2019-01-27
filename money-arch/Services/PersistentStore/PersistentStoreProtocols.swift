//
//  PersistentStoreProtocols.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 26/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation

protocol PersistentStore {
    func insertAccount(name:String, _ completion:@escaping (PersistentStoreAccount)->Void)
}

protocol PersistentStoreAccount {
    var guid:UUID {get}
    var name:String {get}
}
