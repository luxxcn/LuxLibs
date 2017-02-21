//
//  StringHandle.swift
//  BillMaster2
//
//  Created by 星 鲁 on 2017/2/15.
//  Copyright © 2017年 xxing. All rights reserved.
//

import Foundation

let sStringHandle = StringHandle()

class StringHandle : NSObject {
    
    // 将字符串通过split分割成array
    func split(string: String, by split: String) -> Array<String> {
        
        var array = Array<String>()
        var content = string
        while let offset = content.range(of: split) {
            
            array.append(content.substring(to: offset.lowerBound))
            content = content.substring(from: offset.upperBound)
        }
        
        array.append(content)
        
        return array
    }
}
