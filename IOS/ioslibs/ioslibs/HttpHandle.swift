//
//  HttpHandle.swift
//  BillMaster2
//
//  Created by 星 鲁 on 2017/3/22.
//  Copyright © 2017年 xxing. All rights reserved.
//

import UIKit

let sHttpHandle = HttpHandle()

class HttpHandle: NSObject {
    
    // MARK:- get请求
    func getWithPath(path: String,paras: Dictionary<String,Any>?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
        
        var i = 0
        var address = path
        if let paras = paras {
            
            for (key,value) in paras {
                
                if i == 0 {
                    
                    address += "?\(key)=\(value)"
                }else {
                    
                    address += "&\(key)=\(value)"
                }
                
                i += 1
            }
        }
        
        let url = URL(string: address.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, respond, error) in
            
            if let data = data {
                
                //if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                
                //success(result)
                //}
                success(data)
            }else {
                
                failure(error!)
            }
        }
        dataTask.resume()
    }
    
    // MARK:- post请求
    func postWithPath(path: String,paras: Dictionary<String,Any>?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
        
        var i = 0
        var address: String = ""
        
        if let paras = paras {
            
            for (key,value) in paras {
                
                if i == 0 {
                    
                    address += "\(key)=\(value)"
                }else {
                    
                    address += "&\(key)=\(value)"
                }
                
                i += 1
            }
        }
        let url = URL(string: path)
        var request = URLRequest.init(url: url!)
        request.httpMethod = "POST"
        //print(address)
        request.httpBody = address.data(using: .utf8)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, respond, error) in
            
            if let data = data {
                
                //if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                
                //success(result)
                //}
                
                success(data)
                
            }else {
                failure(error!)
            }
        }
        dataTask.resume()
    }

}
