//
//  ListViewModel.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation

protocol ListViewModelViewDelegate: class
{
    func itemsDidChange(viewModel: ListViewModel)
}

protocol ListViewModelCoordinatorDelegate: class
{
    func listViewModelDidSelectData(_ viewModel: ListViewModel, data: DataItem)
}

protocol ListViewModel
{
    var model: ListModel? { get set }
    var viewDelegate: ListViewModelViewDelegate? { get set }
    var coordinatorDelegate: ListViewModelCoordinatorDelegate? { get set}
    
    var title: String { get }
    
    var numberOfItems: Int { get }
    func itemAtIndex(_ index: Int) -> DataItem?
    func useItemAtIndex(_ index: Int)
}
