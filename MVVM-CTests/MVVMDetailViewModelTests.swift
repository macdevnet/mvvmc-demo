//
//  MVVMDetailViewModelTests.swift
//  MVVM-C
//
//  Created by Scotty on 24/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import XCTest

class MVVMDetailViewModelTests: XCTestCase
{

    var currentExpectaion: XCTestExpectation?
    var expectedItem: DataItem?
    
    
    func testInitialDefaults() {
        let vm = MVVMCDetailViewModel()
        XCTAssertNil(vm.detail)
        XCTAssertNil(vm.viewDelegate)
        XCTAssertNil(vm.model)
        XCTAssertNil(vm.coordinatorDelegate)
    }
    
    func testDetail()
    {
        let vm = MVVMCDetailViewModel()
        let item = MVVMCDataItem(name: "Test Name", role: "Test Role")
        let model = MVVMCDetailModel(detailItem: item)
        vm.model = model
        XCTAssertNotNil(vm.detail)
        
        guard let detail = vm.detail else { return }
        
        XCTAssertEqual("Test Name", detail.name)
        XCTAssertEqual("Test Role", detail.role)
    }
    
    
    func testDetailDidChange() {
        
        let vm = MVVMCDetailViewModel()
        expectedItem = MVVMCDataItem(name: "Test Name", role: "Test Role")
        let model = MVVMCDetailModel(detailItem: expectedItem!)
        vm.viewDelegate = self
        currentExpectaion =  expectation(description: "testDetailDidChange")
        vm.model = model
        
        waitForExpectations(timeout: 1) { error in
            vm.viewDelegate = nil
        }
    }
    
    func testCoordinatorDelegate()
    {
        let vm = MVVMCDetailViewModel()
        vm.coordinatorDelegate = self
        currentExpectaion =  expectation(description: "testDetailDidChange")
        vm.done()
        waitForExpectations(timeout: 1) { error in
            vm.viewDelegate = nil
        }
   }
}

extension MVVMDetailViewModelTests: DetailViewModelViewDelegate
{
    func detailDidChange(viewModel: DetailViewModel) {
        XCTAssertNotNil(viewModel.detail)
        XCTAssertEqual(expectedItem?.name, viewModel.detail?.name)
        XCTAssertEqual(expectedItem?.role, viewModel.detail?.role)
        currentExpectaion?.fulfill()
    }
}

extension MVVMDetailViewModelTests: DetailViewModelCoordinatorDelegate
{
    func detailViewModelDidEnd(_ viewModel: DetailViewModel) {
        currentExpectaion?.fulfill()
    }
}
