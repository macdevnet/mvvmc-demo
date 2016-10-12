//
//  MVVMCListViewModel.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation

class MVVMCListViewModel: ListViewModel {
    weak var viewDelegate: ListViewModelViewDelegate?
    weak var coordinatorDelegate: ListViewModelCoordinatorDelegate?

    fileprivate var items: [DataItem]? {
        didSet {
            viewDelegate?.itemsDidChangeFor(viewModel: self)
        }
    }

    var model: ListModel? {
        didSet {
            items = nil;
            model?.items({ (items) in
                self.items = items
            })
        }
    }
    
    var title: String {
        return "List"
    }
    
    var numberOfItems: Int {
        return items?.count ?? 0
    }
    
    func itemAt(index: Int) -> DataItem? {
        if let items = items, items.count > index {
            return items[index]
        }
        return nil
    }
    
    func useItemAt(index: Int) {
        if let items = items, let coordinatorDelegate = coordinatorDelegate, index < items.count {
            coordinatorDelegate.listDidSelectDataFor(viewModel: self, data: items[index])
        }
    }
}
