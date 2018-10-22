//
//  MVVMCAuthenticateViewModelTests.swift
//  MVVM-C
//
//  Created by Scotty on 23/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import XCTest

class MVVMCAuthenticateViewModelTests: XCTestCase
{
    
    var currentExpectaion: XCTestExpectation?
    var expectedCanSubmit: Bool = false
    var expectedErrorMessage: String = ""
    
    
    func testInitialDefaults() {
        let vm = MVVMCAuthenticateViewModel()
        XCTAssertEqual("", vm.email)
        XCTAssertEqual("", vm.password)
        XCTAssertFalse(vm.canSubmit)
        XCTAssertEqual("", vm.errorMessage)
        XCTAssertNil(vm.viewDelegate)
        XCTAssertNil(vm.model)
        XCTAssertNil(vm.coordinatorDelegate)
    }
    
    func testEmail()
    {
        let vm = MVVMCAuthenticateViewModel()
        vm.email = "scotty@example.com"
        XCTAssertEqual("scotty@example.com", vm.email)
    }
    
    func testPassword()
    {
        let vm = MVVMCAuthenticateViewModel()
        vm.password = "password"
        XCTAssertEqual("password", vm.password)
    }

    func testCanSubmit() {
        let vm = MVVMCAuthenticateViewModel()
        XCTAssertFalse(vm.canSubmit)
        
        vm.email = "scotty@example.com"
        vm.password = ""
        XCTAssertFalse(vm.canSubmit)
        
        vm.email = ""
        vm.password = "password"
        XCTAssertFalse(vm.canSubmit)
        
        vm.email = "scotty@example.com"
        vm.password = "password"
        XCTAssert(vm.canSubmit)
    }
    
    func testErrorMessageDidChange() {
        
        let vm = MVVMCAuthenticateViewModel()
        vm.viewDelegate = self
        
        currentExpectaion =  expectation(description: "estErrorMessageDidChange")
        expectedErrorMessage = "Incomplete or Invalid Data";
        
        // Call submit with no model set on the viewModel should produce an error message
        vm.submit()
     
        waitForExpectations(timeout: 1) { error in
            vm.viewDelegate = nil
        }
    }
    
    func testCoordinatorDelegate()
    {
        let vm = MVVMCAuthenticateViewModel()
        vm.model = MVVMCAuthenticateModel()
        
        vm.coordinatorDelegate = self
        currentExpectaion =  expectation(description: "testCoordinatorDelegate")
        
        vm.email = "scotty@example.com"
        vm.password = "password"
 
        vm.submit()
        
        waitForExpectations(timeout: 1) { error in
            vm.coordinatorDelegate = nil
        }
    }
}

extension MVVMCAuthenticateViewModelTests: AuthenticateViewModelViewDelegate
{
    func canSubmitStatusDidChange(_ viewModel: AuthenticateViewModel, status: Bool)
    {
        XCTAssertEqual(expectedCanSubmit, status)
        XCTAssertEqual(expectedCanSubmit, viewModel.canSubmit)
        currentExpectaion?.fulfill()
    }
    
    func errorMessageDidChange(_ viewModel: AuthenticateViewModel, message: String)
    {
        XCTAssertEqual(expectedErrorMessage, message)
        XCTAssertEqual(expectedErrorMessage, viewModel.errorMessage)
        currentExpectaion?.fulfill()
    }
}

extension MVVMCAuthenticateViewModelTests: AuthenticateViewModelCoordinatorDelegate
{
    func authenticateViewModelDidLogin(viewModel: AuthenticateViewModel) {
        currentExpectaion?.fulfill()
    }
}
