//
//  MVVMCListViewModelTests.swift
//  MVVM-C
//
//  Created by Scotty on 24/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import XCTest

class MVVMCListViewModelTests: XCTestCase {
    
    var currentExpectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        currentExpectation = nil
    }
    
    override func tearDown() {
        super.tearDown()
        // Nothing
    }
    
    func testDefaults() {
        let vm = MVVMCListViewModel()
        XCTAssertEqual(0,vm.numberOfItems)
        XCTAssertEqual("List", vm.title)
        XCTAssertNil(vm.viewDelegate)
        XCTAssertNil(vm.model)
        XCTAssertNil(vm.coordinatorDelegate)
    }
    
    func testNumberOfItems() {
        let vm = MVVMCListViewModel()
        vm.model = TestableMVVMCListModel()
        XCTAssertEqual(7, vm.numberOfItems)
    }
    
    func testItemAtIndex() {
        let vm = MVVMCListViewModel()
        vm.model = TestableMVVMCListModel()
        
        // Test a value from the start, end, and middle of list
        
        var dataItem = vm.itemAt(index: 0)
        XCTAssertNotNil(dataItem)
        
        guard let item = dataItem else {
            XCTFail("Item not found from the start of the list")
            return
        }
        
        XCTAssertEqual("James T Kirk", item.name)
        XCTAssertEqual("Captain", item.role)
        
        
        dataItem = vm.itemAt(index: 6)
        XCTAssertNotNil(dataItem)
        
        guard let item2 = dataItem else {
            XCTFail("Item not found from the end of the list")
            return
        }
        
        XCTAssertEqual("Pavel Chekov", item2.name)
        XCTAssertEqual("Ensign", item2.role)
        
        
        dataItem = vm.itemAt(index: 3)
        XCTAssertNotNil(dataItem)
        
        guard let item3 = dataItem else {
            XCTFail("Item not found from the middle of the list")
            return
        }
        
        XCTAssertEqual("Montgomery Scott", item3.name)
        XCTAssertEqual("Lieutenant Commander", item3.role)
        
    }
    
    func testItemAtIndexWithInvalidIndex() {
        let vm = MVVMCListViewModel()
        vm.model = TestableMVVMCListModel()
        
        // Test a value from beyond the end of the list
        let dataItem = vm.itemAt(index: vm.numberOfItems + 1)
        XCTAssertNil(dataItem)
    }
    
    func testUseItemAtIndex() {
        let vm = MVVMCListViewModel()        
        vm.model = TestableMVVMCListModel()
        vm.coordinatorDelegate = self
        currentExpectation =  expectation(description: "testUseItemAtIndex")
        vm.useItemAt(index: 6)
        
        waitForExpectations(timeout: 1) { error in
            vm.coordinatorDelegate = nil
        }
    }
}


extension MVVMCListViewModelTests: ListViewModelCoordinatorDelegate {
    func listDidSelectDataFor(viewModel: ListViewModel, data: DataItem) {
        XCTAssertEqual("Pavel Chekov", data.name)
        XCTAssertEqual("Ensign", data.role)
        currentExpectation?.fulfill()
    }
}
