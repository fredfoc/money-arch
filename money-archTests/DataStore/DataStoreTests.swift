//
//  DataStoreTests.swift
//  money-archTests
//
//  Created by Maxime CHAPELET on 19/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import XCTest

typealias TestDataStore = DefaultDataStore<RootState>
struct DummyAction:Action{}
class DataStoreTests: XCTestCase {
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
    
    func getState() -> TestDataStore.State {
        return dataStore.getState()
    }
    
    func testEmptyTransactionList() throws {
        let state = getState()
        XCTAssertEqual(state.transactionsList.total, 0)
        XCTAssertEqual(state.transactionsList.transactions.count, 0)
    }
    
    func testTransactionInsertion() throws {
        let insertion = InsertTransactionAction()
        dataStore.dispatch(insertion)
        let state = getState()
        XCTAssertEqual(state.transactionsList.total, 1)
        XCTAssertEqual(state.transactionsList.transactions.count, 1)
    }
    
    func test100TransactionsInsertion() throws {
        let insertionsCount = 100
        for _ in 0..<insertionsCount {
            let insertion = InsertTransactionAction()
            dataStore.dispatch(insertion)
        }
        let state = getState()
        XCTAssertEqual(state.transactionsList.total, insertionsCount)
        XCTAssertEqual(state.transactionsList.transactions.count, insertionsCount)
    }
    
    func testDataStoreSubscription() throws {
        let expectation = XCTestExpectation(description: "Receive state update")
        let subscription = dataStore.subscribe { (newState) in
            expectation.fulfill()
        }
        let action = DummyAction()
        dataStore.dispatch(action)
        wait(for: [expectation], timeout: 1.0)
        dataStore.unsubscribe(subscription)
    }
    
    func testDataStoreUnsubscription() throws {
        let expectation = XCTestExpectation(description: "Receive state update")
        expectation.isInverted = true
        let subscription = dataStore.subscribe { (newState) in
            expectation.fulfill()
        }
        dataStore.unsubscribe(subscription)
        let action = DummyAction()
        dataStore.dispatch(action)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testTransactionDeletion() throws {
        let insertion = InsertTransactionAction()
        dataStore.dispatch(insertion)
        let insertionState = getState()
        guard let firstTransaction = insertionState.transactionsList.transactions.first else {
            throw Error.UnexpectedNil
        }
        let deletion = DeleteTransactionAction(uniqueIdentifier: firstTransaction.uniqueIdentifier)
        dataStore.dispatch(deletion)
        let deletionState = getState()
        XCTAssertEqual(deletionState.transactionsList.total, 0)
        XCTAssertEqual(deletionState.transactionsList.transactions.count, 0)
    }
    
    func testThunkDispatch() {
        let expectation = XCTestExpectation(description: "Receive thunk update")
        let thunk = Thunk<RootState> { (dispatch, getState) in
            let action = DummyAction()
            dispatch(action)
        }
        let subscription = dataStore.subscribe { (state) in
            expectation.fulfill()
        }
        dataStore.dispatch(thunk)
        wait(for: [expectation], timeout: 1.0)
        dataStore.unsubscribe(subscription)
    }
}
