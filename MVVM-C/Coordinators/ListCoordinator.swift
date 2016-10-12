//
//  ListCoordinator.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit

protocol ListCoordinatorDelegate: class {
    func listCoordinatorDidFinish(listCoordinator: ListCoordinator)
}

class ListCoordinator: Coordinator {
    
    weak var delegate: ListCoordinatorDelegate?
    var detailCoordinator: DetailCoordinator?
    var window: UIWindow
    var listViewController: MVVMCListViewController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "MVVM-C", bundle: nil)
        listViewController = storyboard.instantiateViewController(withIdentifier: "List") as? MVVMCListViewController
        
        guard let listViewController = listViewController else { return }
        
        let viewModel =  MVVMCListViewModel()
        viewModel.model = MVVMCListModel()
        viewModel.coordinatorDelegate = self
        listViewController.viewModel = viewModel
        window.rootViewController = listViewController
    }
}

extension ListCoordinator: ListViewModelCoordinatorDelegate {
    func listDidSelectDataFor(viewModel: ListViewModel, data: DataItem) {
        detailCoordinator = DetailCoordinator(window: window, dataItem: data)
        detailCoordinator?.delegate = self
        detailCoordinator?.start()
    }
}

extension ListCoordinator: DetailCoordinatorDelegate {
    func detailCoordinatorDidFinish(detailCoordinator: DetailCoordinator) {
        self.detailCoordinator = nil
        window.rootViewController = listViewController
    }
}

