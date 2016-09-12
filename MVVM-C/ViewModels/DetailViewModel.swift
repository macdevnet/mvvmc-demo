//
//  DetailViewModel.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation

protocol DetailViewModelViewDelegate: class
{
    func detailDidChange(viewModel: DetailViewModel)
}


protocol DetailViewModelCoordinatorDelegate: class
{
    func detailViewModelDidEnd(_ viewModel: DetailViewModel)
}

protocol DetailViewModel
{
    var model: DetailModel? { get set }
    var viewDelegate: DetailViewModelViewDelegate? { get set }
    var coordinatorDelegate: DetailViewModelCoordinatorDelegate? { get set}
    var detail: DataItem? { get }
    func done()
}
