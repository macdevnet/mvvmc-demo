//
//  MVVMCListModel.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation

class MVVMCListModel: ListModel
{
    fileprivate var items = [DataItem]()
    
    init() {
        createDataItems()
    }
    
    fileprivate func createDataItems()
    {
        items.append(MVVMCDataItem(name: "James T Kirk", role: "Captain"))
        items.append(MVVMCDataItem(name: "Spock", role: "Commander"))
        items.append(MVVMCDataItem(name: "Leonard McCoy", role: "Lieutenant Commander"))
        items.append(MVVMCDataItem(name: "Montgomery Scott", role: "Lieutenant Commander"))
        items.append(MVVMCDataItem(name: "Uhura", role: "Lieutenant"))
        items.append(MVVMCDataItem(name: "Hikaru Sulu", role: "Lieutenant"))
        items.append(MVVMCDataItem(name: "Pavel Chekov", role: "Ensign"))
    }
    
    func items(_ completionHandler: @escaping (_ items: [DataItem]) -> Void)
    {
        // Simulate Aysnchronous data access
        DispatchQueue.global().async {
            completionHandler(self.items)
        }
    }
}
   
