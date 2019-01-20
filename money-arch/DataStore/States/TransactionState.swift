//
//  TransactionState.swift
//  money-arch
//
//  Created by Maxime CHAPELET on 20/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import Foundation

protocol TransactionState {
    var creationDate:Date {get}
}

protocol MutableTransactionState : TransactionState {
    var creationDate:Date {get set}
}

struct TransactionStateImpl : MutableTransactionState {
    internal var creationDate: Date
}
