//
//  MVVMCDetailViewController.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import UIKit

class MVVMCDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    
    var viewModel: DetailViewModel? {
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
        super.viewDidLoad()
        isLoaded = true;
        refreshDisplay()
    }

    private func refreshDisplay()
    {
        guard isLoaded else { return }
        if let viewModel = viewModel {
            nameLabel.text = viewModel.detail?.name
            roleLabel.text = viewModel.detail?.role
        } else {
            nameLabel.text = ""
            roleLabel.text = ""
        }
    }
    
    
    @IBAction func doneButtonPressed(sender: AnyObject)
    {
        viewModel?.done();
    }
    
}

extension MVVMCDetailViewController: DetailViewModelViewDelegate
{
    func detailDidChange(viewModel viewModel: DetailViewModel)
    {
        refreshDisplay()
    }
}
