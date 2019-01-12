//
//  MVVMCListViewModelTests.swift
//  MVVM-C
//
//  Created by Scotty on 24/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import XCTest

class MVVMCListViewModelTests: XCTestCase
{
    
    var currentExpectaion: XCTestExpectation?
    
    func testDefaults()
    {
        let vm = MVVMCListViewModel()
        XCTAssertEqual(0,vm.numberOfItems)
        XCTAssertEqual("List", vm.title)
        XCTAssertNil(vm.viewDelegate)
        XCTAssertNil(vm.model)
        XCTAssertNil(vm.coordinatorDelegate)
    }
    
    func testNumberOfItems() {
        let vm = MVVMCListViewModel()
        
        // We can test with the actual app model as it produces hard coded data
        // In normal testing we would create a ListModel implementation with fix test data to use,
        vm.model = MVVMCListModel()
        XCTAssertEqual(7,vm.numberOfItems)
    }
    
    func testItemAtIndex() {
        
        let vm = MVVMCListViewModel()
        
        // We can test with the actual app model as it produces hard coded data
        // In normal testing we would create a ListModel implementation with fix test data to use,
        vm.model = MVVMCListModel()
        
        
        // Test a value from the start , end and middle of list
        
        var dataItem = vm.itemAtIndex(0)
        XCTAssertNotNil(dataItem)
        
        guard let item = dataItem else { return }
        
        XCTAssertEqual("James T Kirk", item.name)
        XCTAssertEqual("Captain", item.role)
        
        
        dataItem = vm.itemAtIndex(6)
        XCTAssertNotNil(dataItem)
        
        guard let item2 = dataItem else { return }
        
        XCTAssertEqual("Pavel Chekov", item2.name)
        XCTAssertEqual("Ensign", item2.role)
        
        
        dataItem = vm.itemAtIndex(3)
        XCTAssertNotNil(dataItem)
        
        guard let item3 = dataItem else { return }
        
        XCTAssertEqual("Montgomery Scott", item3.name)
        XCTAssertEqual("Lieutenant Commander", item3.role)
        
    }
    
    func testItemAtIndexWithInvalidIndex() {
        
        let vm = MVVMCListViewModel()
        
        // We can test with the actual app model as it produces hard coded data
        // In normal testing we would create a ListModel implementation with fixed test data to use,
        vm.model = MVVMCListModel()
        
        // Test a value from beyond the end of the list
        let dataItem = vm.itemAtIndex(vm.numberOfItems + 1)
        XCTAssertNil(dataItem)
    }
    
    func testUseItemAtIndex()
    {
        
        let vm = MVVMCListViewModel()
        
        // We can test with the actual app model as it produces hard coded data
        // In normal testing we would create a ListModel implementation with fixed test data to use,
        vm.model = MVVMCListModel()
        vm.coordinatorDelegate = self
        currentExpectaion =  expectation(description: "testUseItemAtIndex")
        vm.useItemAtIndex(6)
        
        waitForExpectations(timeout: 1) { error in
            vm.coordinatorDelegate = nil
        }
    }
}


extension MVVMCListViewModelTests: ListViewModelCoordinatorDelegate
{
    func listViewModelDidSelectData(_ viewModel: ListViewModel, data: DataItem) {
        XCTAssertEqual("Pavel Chekov", data.name)
        XCTAssertEqual("Ensign", data.role)
        currentExpectaion?.fulfill()
    }
}
