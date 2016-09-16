//
//  ListModel.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation


protocol ListModel
{
    func items(_ completionHandler: @escaping (_ items: [DataItem]) -> Void)
}
