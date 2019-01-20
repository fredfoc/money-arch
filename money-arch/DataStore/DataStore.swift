//
//  DataStore.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 19/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation

class DataStoreSubscription<Store:DataStore> {
    unowned var dataStore:Store
    init(dataStore:Store) {
        self.dataStore = dataStore
    }
    deinit {
        dataStore.unsubscribe(self)
    }
}

protocol DataStore : class {
    associatedtype State
    func getState() -> State
    func dispatch(_ action:Action)
    func subscribe(_ event:@escaping (_ state:State)->Void) -> DataStoreSubscription<Self>
    func unsubscribe(_ subscription:DataStoreSubscription<Self>)
}
