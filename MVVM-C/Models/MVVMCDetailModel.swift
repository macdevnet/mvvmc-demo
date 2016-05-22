//
//  MVVMCDetailModel.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation

class MVVMCDetailModel: DetailModel
{
    
    private var item: DataItem?
    
    init(detailItem: DataItem)
    {
        self.item = detailItem
    }
    
    func detail(completionHandler: (item: DataItem?) -> Void)
    {
        completionHandler(item: item)
    }
}