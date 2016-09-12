//
//  AuthenticateViewModel.swift
//  MVVM-C
//
//  Created by Scotty on 20/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//


import Foundation


protocol AuthenticateViewModelViewDelegate: class
{
    func canSubmitStatusDidChange(_ viewModel: AuthenticateViewModel, status: Bool)
    func errorMessageDidChange(_ viewModel: AuthenticateViewModel, message: String)
}


protocol AuthenticateViewModelCoordinatorDelegate: class
{
    func authenticateViewModelDidLogin(viewModel: AuthenticateViewModel)
}


protocol AuthenticateViewModel
{
    var model: AuthenticateModel? { get set }
    var viewDelegate: AuthenticateViewModelViewDelegate? { get set }
    var coordinatorDelegate: AuthenticateViewModelCoordinatorDelegate? { get set}
    
    // Email and Password
    var email: String {get set}
    var password: String {get set}
    
    // Submit
    var canSubmit: Bool { get }
    func submit()
    
    // Errors
    var errorMessage: String { get }
}

