//
//  MVVMCDataItem.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation

struct MVVMCDataItem: DataItem
{
    let name: String
    let role: String
    
    init(name: String, role: String)
    {
        self.name = name
        self.role = role
    }
}
