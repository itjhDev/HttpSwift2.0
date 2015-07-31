//  HttpSwift.swift
//  HttpSwift2.0
//
//  Created by SongLijun on 15/7/30.
//  Copyright © 2015年 SongLijun. All rights reserved.
//

import Foundation

extension String {
    var nsdata: NSData {
        return self.dataUsingEncoding(NSUTF8StringEncoding)!
    }
}

/*
    Swift2.0 网络请求封装
*/
class HttpSwift {
    
    static func request(method: String, url: String, params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>(), callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void){
        
        let manager = HttpSwiftManager(url: url, method: method, params: params, callback: callback)
        manager.fire()
    }
    
    /*get请求，不带参数*/
    static func get(url: String, callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = HttpSwiftManager(url: url, method: "GET", callback: callback)
        manager.fire()
    }
    
     /*get请求，带参数*/
    static func get(url: String, params: Dictionary<String, AnyObject>, callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = HttpSwiftManager(url: url, method: "GET", params: params, callback: callback)
        manager.fire()
    }
    
    /*POST请求，不带参数*/
    static func post(url: String, callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = HttpSwiftManager(url: url, method: "POST", callback: callback)
        manager.fire()
    }
    
    /*POST请求，带参数*/
    static func post(url: String, params: Dictionary<String, AnyObject>, callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = HttpSwiftManager(url: url, method: "POST", params: params, callback: callback)
        manager.fire()
    }
    
    
}

/*扩展*/
class HttpSwiftManager {
    
    let method: String!
    let params: Dictionary<String, AnyObject>
    let callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void
    
    
    var session = NSURLSession.sharedSession()
    let url: String!
    var request: NSMutableURLRequest!
    var task: NSURLSessionTask!
    
    /*带参数 构造器*/
    init(url: String, method: String, params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>(), callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void) {
        self.url = url
        self.request = NSMutableURLRequest(URL: NSURL(string: url)!)
        self.method = method
        self.params = params
        self.callback = callback 
    }
    
    func buildRequest() {
        if self.method == "GET" && self.params.count > 0 {
            self.request = NSMutableURLRequest(URL: NSURL(string: url + "?" + buildParams(self.params))!)
        }
        
        request.HTTPMethod = self.method
        
        if self.params.count > 0 {
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
    }
    func buildBody() {
        if self.params.count > 0 && self.method != "GET" {
            request.HTTPBody = buildParams(self.params).nsdata
        }
    }
    func fireTask() {
         task = session.dataTaskWithRequest(request,completionHandler: { (data, response, error) -> Void in
            self.callback(data: NSString(data: data!, encoding: NSUTF8StringEncoding), response: response, error: error)
        })
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
    
    func fire() {
        buildRequest()
        buildBody()
        fireTask()
    }
    
    
}

