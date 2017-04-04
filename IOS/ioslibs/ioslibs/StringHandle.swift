//
//  StringHandle.swift
//  BillMaster2
//
//  Created by 星 鲁 on 2017/2/15.
//  Copyright © 2017年 xxing. All rights reserved.
//

import Foundation

let sStringHandle = StringHandle()

extension String  {
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate(capacity: digestLen)
        
        return String(format: hash as String)
    }
}

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
