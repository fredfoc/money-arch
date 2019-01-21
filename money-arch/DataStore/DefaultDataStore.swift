//
//  DefaultDataStore.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 19/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation

struct InitAction:Action {}

final class DefaultDataStore<State:Any> {
    let reducer:(State?,Action)->State
    var state:State
    init(_ reducer:@escaping (State?, Action)->State) {
        self.reducer = reducer
        self.state = reducer(nil, InitAction())
    }
    var subscriptions = [ObjectIdentifier:(State)->Void]()
    
}
extension DefaultDataStore : DataStore {
    func subscribe(_ event: @escaping (State) -> Void) -> DataStoreSubscription<DefaultDataStore<State>> {
        let subscription = DataStoreSubscription(dataStore: self)
        let identifier = ObjectIdentifier(subscription)
        subscriptions[identifier] = event
        return subscription
    }
    
    func unsubscribe(_ subscription: DataStoreSubscription<DefaultDataStore>) {
        let identifier = ObjectIdentifier(subscription)
        subscriptions.removeValue(forKey: identifier)
    }
   
    func dispatch(_ action: Action) {
        self.state = reducer(state, action)
        subscriptions.forEach { (key, event) in
            event(self.state)
        }
    }
    
    func getState() -> State {
        return self.state
    }
}
