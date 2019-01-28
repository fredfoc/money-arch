//
//  OutlineInteractorTests.swift
//  money-archTests
//
//  Created by Maxime CHAPELET on 28/01/2019.
//  Copyright © 2019 Maxime CHAPELET. All rights reserved.
//

import XCTest

class OutlineInteractorToPresenterTest:OutlinePresenting {
    var presentFetchResponseCallback:((Scenes.Outline.Fetch.Response)->Void)?
    func present(_ response: Scenes.Outline.Fetch.Response) {
        presentFetchResponseCallback?(response)
    }
}

class OutlineInteractorTests: XCTestCase {

    var interactor:OutlineInteracting!
    let presenter = OutlineInteractorToPresenterTest()
    override func setUp() {
        super.setUp()
        let dataStore = DefaultDataStore(rootReducer)
        let container = Services.PersistentStore.ContainerFactory.persistentInMemoryContainer()
        let persistentStore = Services.PersistentStore.Service(persistentContainer: container)
        interactor = OutlineInteractor(presenter:presenter,
                                       dataStore:dataStore,
                                       persistentStore: persistentStore)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetch() {
        let expectation = XCTestExpectation(description: "Fetch done")
        let request = Scenes.Outline.Fetch.Request()
        presenter.presentFetchResponseCallback = { (response) in
            expectation.fulfill()
        }
        interactor.fetch(request)
        wait(for: [expectation], timeout: 1.0)
    }

}
