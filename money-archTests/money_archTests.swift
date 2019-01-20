//
//  money_archTests.swift
//  money-archTests
//
//  Created by Maxime CHAPELET on 19/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import XCTest

typealias TestDataStore = DefaultDataStore<RootState>

class money_archTests: XCTestCase {
    enum Error : Swift.Error {
        case UnexpectedNil
    }
    
    var dataStore:TestDataStore!
    
    override func setUp() {
        super.setUp()
        dataStore = DefaultDataStore(rootReducer)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataStoreNotNil() {
        XCTAssertNotNil(dataStore)
    }
    
    func getState() throws -> TestDataStore.State {
        return dataStore.getState()
    }
    
    func testEmptyTransactionList() throws {
        let state = try getState()
        XCTAssertEqual(state.transactionsList.offset, 0)
        XCTAssertEqual(state.transactionsList.total, 0)
        XCTAssertEqual(state.transactionsList.transactions.count, 0)
    }
    
    func testTransactionInsertion() throws {
        let insertion = InsertTransactionAction()
        dataStore.dispatch(insertion)
        let state = try getState()
        XCTAssertEqual(state.transactionsList.offset, 0)
        XCTAssertEqual(state.transactionsList.total, 1)
        XCTAssertEqual(state.transactionsList.transactions.count, 1)
    }
    
    func test100TransactionsInsertion() throws {
        let insertionsCount = 100
        for _ in 0..<insertionsCount {
            let insertion = InsertTransactionAction()
            dataStore.dispatch(insertion)
        }
        let state = try getState()
        XCTAssertEqual(state.transactionsList.offset, 0)
        XCTAssertEqual(state.transactionsList.total, insertionsCount)
        XCTAssertEqual(state.transactionsList.transactions.count, insertionsCount)
    }
    
    func testDataStoreSubscription() throws {
        let expectation = XCTestExpectation(description: "Receive state update")
        let _ = dataStore.subscribe { (state) in
            XCTAssertEqual(state.transactionsList.offset, 0)
            XCTAssertEqual(state.transactionsList.total, 1)
            XCTAssertEqual(state.transactionsList.transactions.count, 1)
            expectation.fulfill()
        }
        let insertion = InsertTransactionAction()
        dataStore.dispatch(insertion)
        wait(for: [expectation], timeout: 1.0)
    }
}
