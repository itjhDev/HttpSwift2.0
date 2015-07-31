//  HttpSwift.swift
//  HttpSwift2.0
//
//  Created by SongLijun on 15/7/30.
//  Copyright © 2015年 SongLijun. All rights reserved.
//

import Foundation

/*
    Swift2.0 网络请求封装
*/
class HttpSwift {
    
    
    /*静态方法*/
    
    static func request(method: String, url: String, params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>(), callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void){
        
        let session = NSURLSession.sharedSession()
        
        var newURL = url
        /* GET */
        //判断请求方法
        if method == "GET"{
            //拼接url
            newURL += "?" + HttpSwift().buildParams(params)
        
        }
        //进行网络请求，返回结果 闭包
        let request = NSMutableURLRequest(URL:NSURL(string: url)!)
        request.HTTPMethod = method
        
        /* POST */
        if method == "POST" {
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = HttpSwift().buildParams(params).dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        let task = session.dataTaskWithRequest(request,completionHandler: { (data, response, error) -> Void in
            callback(data: NSString(data: data!, encoding: NSUTF8StringEncoding), response: response, error: error)
        })
        //获取
        task.resume()
    }
        
    //借用 Alamofire 函数
    func buildParams(parameters: [String: AnyObject]) -> String {
        
        var components: [(String, String)] = []
        
        for key in  parameters.keys.sort() {
            let value: AnyObject! = parameters[key]
            //拼接url
            components += self.queryComponents(key, value)
        } 
        return "&".join( components.map{"\($0)=\($1)"} as [String])
    }
    
    
    func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)", value)
            }
        } else {
            components.extend([(escape(key), escape("\(value)"))])
        }
        
        return components
    }
    
    
    func escape(string: String) -> String {
        let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
        return CFURLCreateStringByAddingPercentEscapes(nil, string, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
    
    
    
    
    
    
    
    
    
    
    
    
}