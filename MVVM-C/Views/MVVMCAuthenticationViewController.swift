//
//  AuthenticationViewController.swift
//  MVVM-C
//
//  Created by Scotty on 19/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit

class MVVMCAuthenticationViewController: UIViewController
{
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
  
    var viewModel: AuthenticateViewModel? {
        willSet {
            viewModel?.viewDelegate = nil
        }
        didSet {
            viewModel?.viewDelegate = self
            refreshDisplay()
        }
    }
    
    private var isLoaded: Bool = false
    
    override func viewDidLoad()
    {
        title = "Login"
        isLoaded = true;
        
        emailField.addTarget(self, action: #selector(emailFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        passwordField.addTarget(self, action: #selector(passwordFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)

        refreshDisplay()
    }
    
    private func refreshDisplay()
    {
        guard isLoaded else { return }
        
        if let viewModel = viewModel {
            emailField.text = viewModel.email
            passwordField.text = viewModel.password
            errorMessageLabel.text = viewModel.errorMessage
            loginButton.enabled = viewModel.canSubmit
        } else {
            emailField.text = ""
            passwordField.text = ""
            errorMessageLabel.text = ""
            loginButton.enabled = false
        }
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject)
    {
        viewModel?.submit()
    }
    
    func emailFieldDidChange(textField: UITextField)
    {
        if let text = textField.text {
            viewModel?.email = text
        }
    }
    
    func passwordFieldDidChange(textField: UITextField)
    {
        if let text = textField.text {
            viewModel?.password = text
        }
    }
}


/// AuthenticateViewModelViewDelegate Implementation
extension MVVMCAuthenticationViewController: AuthenticateViewModelViewDelegate
{
    func canSubmitStatusDidChange(viewModel: AuthenticateViewModel, status: Bool)
    {
        loginButton.enabled = status
    }
    
    
    func errorMessageDidChange(viewModel: AuthenticateViewModel, message: String)
    {
        errorMessageLabel.text = message
    }
}
