//
//  DetailCoordinator.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit


protocol DetailCoordinatorDelegate: class
{
    func detailCoordinatorDidFinish(detailCoordinator: DetailCoordinator)
}

class DetailCoordinator: Coordinator
{
    weak var delegate: DetailCoordinatorDelegate?
    let dataItem: DataItem
    var window: UIWindow
    
    init(window: UIWindow, dataItem: DataItem)
    {
        self.window = window
        self.dataItem = dataItem
    }
    
    func start()
    {
        let storyboard = UIStoryboard(name: "MVVM-C", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "Detail") as? MVVMCDetailViewController {
            let viewModel =  MVVMCDetailViewModel()
            viewModel.model = MVVMCDetailModel(detailItem: dataItem)
            viewModel.coordinatorDelegate = self
            vc.viewModel = viewModel
            window.rootViewController = vc
        }
    }
}

extension DetailCoordinator: DetailViewModelCoordinatorDelegate
{
    
 func detailViewModelDidEnd(_ viewModel: DetailViewModel)
 {
    delegate?.detailCoordinatorDidFinish(detailCoordinator: self)
 }
    
}
