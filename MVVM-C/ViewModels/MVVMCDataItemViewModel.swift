//
//  MVVMCDataItemViewModel.swift
//  MVVM-C
//
//  Created by Daniel Carlos on 6/15/16.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation

struct MVVMCDataItemViewModel : DataItemViewModel{
 
    var name : String
    var role : String
    
    init?(withDataItem dataItem: DataItem?){
        guard let item = dataItem else {
            return nil
        }
        self.name = item.name
        self.role = item.role
    }
    
}