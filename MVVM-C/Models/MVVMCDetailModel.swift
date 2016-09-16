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
    
    fileprivate var item: DataItem?
    
    init(detailItem: DataItem)
    {
        self.item = detailItem
    }
    
    func detail(_ completionHandler: @escaping (_ item: DataItem?) -> Void)
    {
        // Simulate Aysnchronous data access
        DispatchQueue.global().async {
            completionHandler(self.item)
        }
    }
}
