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
    var uniqueIdentifier:UUID {get}
}

protocol MutableTransactionState : TransactionState {
    
}

struct TransactionStateImpl : Equatable, MutableTransactionState {
    static func == (lhs: TransactionStateImpl, rhs: TransactionStateImpl) -> Bool {
        return lhs.uniqueIdentifier == rhs.uniqueIdentifier
    }
    
    internal var creationDate: Date
    internal var uniqueIdentifier: UUID
    init() {
        creationDate = Date()
        uniqueIdentifier = UUID()
    }
}
