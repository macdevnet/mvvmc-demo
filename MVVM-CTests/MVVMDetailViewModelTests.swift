//
//  MVVMDetailViewModelTests.swift
//  MVVM-C
//
//  Created by Scotty on 24/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import XCTest

class MVVMDetailViewModelTests: XCTestCase {

    var currentExpectation: XCTestExpectation?
    var expectedItem: DataItem?
    
    override func setUp() {
        super.setUp()
        currentExpectation = nil
        expectedItem = nil
    }
    
    override func tearDown() {
        super.tearDown()
        // Nothing
    }
    
    func testInitialDefaults() {
        let vm = MVVMCDetailViewModel()
        XCTAssertNil(vm.detail)
        XCTAssertNil(vm.viewDelegate)
        XCTAssertNil(vm.model)
        XCTAssertNil(vm.coordinatorDelegate)
    }
    
    func testDetail() {
        let vm = MVVMCDetailViewModel()
        let item = MVVMCDataItem(name: "Test Name", role: "Test Role")
        let model = TestableMVVMCDetailModel(detailItem: item)
        vm.model = model
        
        XCTAssertNotNil(vm.detail)
        
        guard let detail = vm.detail else {
            XCTFail("Detail doesn't exist")
            return
        }
        
        XCTAssertEqual("Test Name", detail.name)
        XCTAssertEqual("Test Role", detail.role)
    }
    
    func testDetailDidChange() {
        let vm = MVVMCDetailViewModel()
        expectedItem = MVVMCDataItem(name: "Test Name", role: "Test Role")
        let model = TestableMVVMCDetailModel(detailItem: expectedItem!)
        vm.viewDelegate = self
        currentExpectation =  expectation(description: "testDetailDidChange")
        vm.model = model
        
        waitForExpectations(timeout: 1) { error in
            vm.viewDelegate = nil
        }
    }
    
    func testCoordinatorDelegate() {
        let vm = MVVMCDetailViewModel()
        vm.coordinatorDelegate = self
        currentExpectation =  expectation(description: "testDetailDidChange")
        vm.done()
        waitForExpectations(timeout: 1) { error in
            vm.viewDelegate = nil
        }
   }
}

extension MVVMDetailViewModelTests: DetailViewModelViewDelegate {
    func detailDidChangeFor(viewModel: DetailViewModel) {
        XCTAssertNotNil(viewModel.detail)
        XCTAssertEqual(expectedItem?.name, viewModel.detail?.name)
        XCTAssertEqual(expectedItem?.role, viewModel.detail?.role)
        currentExpectation?.fulfill()
    }
}

extension MVVMDetailViewModelTests: DetailViewModelCoordinatorDelegate {
    func detailDidEndFor(viewModel: DetailViewModel) {
        currentExpectation?.fulfill()
    }
}
