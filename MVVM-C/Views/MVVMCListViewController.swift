//
//  MVVMCListViewController.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit

class MVVMCListViewController: UITableViewController {
    
    var viewModel: ListViewModel? {
        willSet {
            viewModel?.viewDelegate = nil
        }
        didSet {
            viewModel?.viewDelegate = self
            refreshDisplay()
        }
    }
    
    var isLoaded: Bool = false
    
    func refreshDisplay() {
        if let viewModel = viewModel , isLoaded {
            title = viewModel.title
        } else {
            title = ""
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        
        isLoaded = true
        refreshDisplay();
    }
    
}

extension MVVMCListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            return viewModel.numberOfItems
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! MVVMCItemTableViewCell
        cell.item = viewModel?.itemAt(index: (indexPath as NSIndexPath).row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.useItemAt(index: (indexPath as NSIndexPath).row)
    }
}

extension MVVMCListViewController: ListViewModelViewDelegate {
    func itemsDidChangeFor(viewModel: ListViewModel) {
        tableView.reloadData()
    }
}
