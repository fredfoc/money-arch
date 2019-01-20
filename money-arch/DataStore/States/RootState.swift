//
//  RootState.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 19/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation

protocol RootState {
    var transactionsList:TransactionsListState {get}
}

protocol MutableRootState : RootState {
    var transactionsList:TransactionsListState {get set}
}

struct RootStateImpl {
    var transactionsList:TransactionsListState
    init() {
        transactionsList = TransactionsListStateImpl(offset: 0,
                                                     total: 0,
                                                     transactions: [])
    }
}

extension RootStateImpl : MutableRootState {
    
}
