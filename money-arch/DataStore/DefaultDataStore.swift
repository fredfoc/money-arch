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
    private let reducer:(State?,Action)->State
    private let mutex = DispatchQueue.init(label: "com.umxprime.dataStoreMutex")
    private var state:State
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
        mutex.sync {
            subscriptions[identifier] = event
        }
        return subscription
    }
    
    func unsubscribe(_ subscription: DataStoreSubscription<DefaultDataStore>) {
        let identifier = ObjectIdentifier(subscription)
        mutex.sync {
            subscriptions[identifier] = nil
        }
    }
   
    func dispatch(_ action: Action) {
        let subscriptions = mutex.sync {
            self.subscriptions
        }
        switch action {
        case let thunk as Thunk<State>:
            thunk.callbacks(self.dispatch, self.getState)
        default:
            let newState = reducer(getState(), action)
            mutex.sync {
                self.state = newState
            }
            subscriptions.forEach { (key, event) in
                event(newState)
            }
        }
        
    }
    
    func getState() -> State {
        return mutex.sync { self.state }
    }
}
