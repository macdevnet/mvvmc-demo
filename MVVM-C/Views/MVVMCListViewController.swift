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
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)

        isLoaded = true
        refreshDisplay()
    }
}

extension MVVMCListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.map { $0.numberOfItems } ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! MVVMCItemTableViewCell
        cell.item = viewModel?.itemAtIndex(indexPath.row)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.useItemAtIndex(indexPath.row)
    }
}

extension MVVMCListViewController: ListViewModelViewDelegate {
    func itemsDidChange(viewModel: ListViewModel) {
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
    }
}
