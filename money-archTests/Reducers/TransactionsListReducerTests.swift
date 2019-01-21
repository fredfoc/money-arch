//
//  TransactionsListReducerTests.swift
//  money-archTests
//
//  Created by Maxime CHAPELET on 21/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import XCTest

class TransactionsListReducerTests: XCTestCase {
    enum Error : Swift.Error {
        case UnexpectedNil
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTransactionInsertion() {
        let rootState = RootStateImpl()
        let state = transactionsListReducer(rootState.transactionsList, InsertTransactionAction())
        XCTAssertEqual(state.total, 1)
        XCTAssertEqual(state.transactions.count, 1)
    }
    
    func testTransactionDeletion() throws {
        let rootState = RootStateImpl()
        var state = transactionsListReducer(rootState.transactionsList, InsertTransactionAction())
        guard let firstTransaction = state.transactions.first else {
            throw Error.UnexpectedNil
        }
        state = transactionsListReducer(state, DeleteTransactionAction(uniqueIdentifier: firstTransaction.uniqueIdentifier))
        XCTAssertEqual(state.total, 0)
        XCTAssertEqual(state.transactions.count, 0)
    }

}
