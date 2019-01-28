//
//  OutlineInteractor.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 28/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation

class OutlineInteractor<Store:DataStore> {
    let presenter:OutlinePresenting
    let dataStore:Store
    let persistentStore:PersistentStore
    init (presenter:OutlinePresenting,
          dataStore:Store,
          persistentStore:PersistentStore) {
        self.presenter = presenter
        self.dataStore = dataStore
        self.persistentStore = persistentStore
    }
}

extension OutlineInteractor : OutlineInteracting {
    func fetch(_ request: Scenes.Outline.Fetch.Request) {
        let thunk = Thunk<RootState> { [weak self] (dispatch, getState) in
            guard let weakSelf = self else {return}
            weakSelf.persistentStore.listAccounts({ (accounts) in
                let response = Scenes.Outline.Fetch.Response()
                weakSelf.presenter.present(response)
            })
        }
        dataStore.dispatch(thunk)
    }
}
