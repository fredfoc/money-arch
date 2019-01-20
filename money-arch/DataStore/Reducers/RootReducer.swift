//
//  RootReducer.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 19/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation

let rootReducer = { (state:RootState?, action:Action) -> RootState in
    var mutableState:MutableRootState = state as? MutableRootState ?? RootStateImpl()
    let transactionsList = transactionsListReducer(mutableState.transactionsList, action)
    mutableState.transactionsList = transactionsList
    return mutableState
}
