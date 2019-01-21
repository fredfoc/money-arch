//
//  TransactionsListReducer.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 20/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation

let transactionsListReducer = { (state:TransactionsListState, action:Action) -> TransactionsListState in
    var state = state
    switch action {
    case let action as InsertTransactionAction:
        if var mutableState = state as? MutableTransactionsListState {
            var list = state.transactions
            let transaction = TransactionStateImpl()
            list.append(transaction)
            mutableState.transactions = list
            mutableState.total = list.count
            state = mutableState
        }
    case let action as DeleteTransactionAction:
        if var mutableState = state as? MutableTransactionsListState {
            var list:[TransactionState] = state.transactions
            if let result = list.index(where: { (transaction:TransactionState) -> Bool in
                return transaction.uniqueIdentifier == action.uniqueIdentifier
            }) {
                list.remove(at: result)
            }
            mutableState.transactions = list
            mutableState.total = list.count
            state = mutableState
        }
    default:
        break
    }
    return state
}

