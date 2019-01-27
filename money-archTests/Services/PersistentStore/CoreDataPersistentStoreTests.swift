//
//  CoreDataPersistentStoreTests.swift
//  money-archTests
//
//  Created by Maxime CHAPELET on 26/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import XCTest

class CoreDataPersistentStoreTests: XCTestCase {

    var persistentStore:PersistentStore!
    
    override func setUp() {
        super.setUp()
        let persistentContainer = Services.PersistentStore.ContainerFactory.persistentInMemoryContainer()
        persistentStore = Services.PersistentStore.Service(persistentContainer: persistentContainer)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAccountInsertion() {
        let expectation = XCTestExpectation(description: "Complete with account object")
        persistentStore.insertAccount(name:"Test") { account in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testAccountListEmptiness() {
        let expectation = XCTestExpectation(description: "Complete with empty list")
        persistentStore.listAccounts { (accounts) in
            XCTAssertEqual(accounts.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testAccountListContainingOneEntry() {
        let expectation = XCTestExpectation(description: "Complete with one account")
        persistentStore.insertAccount(name:"Test") { [unowned self] account in
            self.persistentStore.listAccounts { (accounts) in
                XCTAssertEqual(accounts.count, 1)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testAccountRename() {
        let expectation = XCTestExpectation(description: "Complete with renamed account")
        persistentStore.insertAccount(name:"Test") { [unowned self] account in
            var editedAccount:MutablePersistentStoreAccount = account.mutable()
            editedAccount.name = "RenamedTest"
            self.persistentStore.updateAccount(editedAccount) { account in
                self.persistentStore.listAccounts { (accounts) in
                    guard let first = accounts.first else {
                        return
                    }
                    XCTAssertEqual(first.name, "RenamedTest")
                    expectation.fulfill()
                }
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
