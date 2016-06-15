//
//  MVVMCListViewModel.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation

class MVVMCListViewModel: ListViewModel
{
    
    weak var viewDelegate: ListViewModelViewDelegate?
    weak var coordinatorDelegate: ListViewModelCoordinatorDelegate?

    private var items: [DataItem]? {
        didSet {
            viewDelegate?.itemsDidChange(viewModel: self)
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
        if let items = items {
            return items.count
        }
        return 0
    }
    
    func itemAtIndex(index: Int) -> DataItemViewModel?
    {
        if let items = items where items.count > index {
            let dataItem = items[index]
            return MVVMCDataItemViewModel(withDataItem: dataItem)
        }
        return nil
    }
    
    func useItemAtIndex(index: Int)
    {
        if let items = items, coordinatorDelegate = coordinatorDelegate  where index < items.count {
            coordinatorDelegate.listViewModelDidSelectData(self, data: items[index])
        }
    }
}
