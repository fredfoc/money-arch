//
//  TransactionsListState.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 19/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation

protocol TransactionsListState {
    var offset:Int {get}
    var total:Int {get}
    var transactions:[TransactionState] {get}
}

protocol MutableTransactionsListState : TransactionsListState {
    var offset:Int {get set}
    var total:Int {get set}
    var transactions:[TransactionState] {get set}
}

struct TransactionsListStateImpl {
    internal var offset: Int
    internal var total:Int
    internal var transactions:[TransactionState]
}

extension TransactionsListStateImpl : MutableTransactionsListState {
    
}
