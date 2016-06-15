//
//  DataItemViewModel.swift
//  MVVM-C
//
//  Created by Daniel Carlos on 6/15/16.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation

protocol DataItemViewModel {
    var name: String {get}
    var role: String {get}
    
    init?(withDataItem: DataItem?)
    
}