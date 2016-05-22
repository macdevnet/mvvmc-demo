//
//  AppCoordinator.swift
//  MVVM-C
//
//  Created by Scotty on 19/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator
{
    var window: UIWindow
    var coordinators = [String:Coordinator]()
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func start()
    {
        if isLoggedIn {
            showList()
        } else {
            showAuthentication()
        }
    }
}



extension AppCoordinator: AuthenticationCoordinatorDelegate
{
    var isLoggedIn: Bool {
        return false;
    }
    
    func showAuthentication()
    {
        let authenticationCoordinator = AuthenticationCoordinator(window: window)
        coordinators["authentication"] = authenticationCoordinator
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
    }
    
    func authenticationCoordinatorDidFinish(authenticationCoordinator authenticationCoordinator: AuthenticationCoordinator)
    {
        coordinators["authentication"] = nil
        showList()
    }
}


extension AppCoordinator: ListCoordinatorDelegate
{
    func showList()
    {
        let listCoordinator = ListCoordinator(window: window)
        coordinators["list"] = listCoordinator
        listCoordinator.delegate = self
        listCoordinator.start()
    }
    
    func listCoordinatorDidFinish(listCoordinator listCoordinator: ListCoordinator)
    {
        coordinators["LIST"] = nil
    }
}

