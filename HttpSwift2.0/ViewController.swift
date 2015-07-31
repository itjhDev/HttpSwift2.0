//
//  ViewController.swift
//  HttpSwift2.0
//
//  Created by SongLijun on 15/7/31.
//  Copyright © 2015年 SongLijun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //天气的url
    let url = "http://www.weather.com.cn/adat/sk/101190408.html"
    
    
    /*
    返回结果
    {
    "weatherinfo":
    {"city":"太仓","cityid":"101190408","temp":"13","WD":"西北风","WS":"3级","SD":"93%","WSE":"3","time":"10:20","isRadar":"0","Radar":"","njd":"暂无实况","qy":"1005"
    }
    }
    
    
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*测试GET请求*/
    @IBAction func getRequest(sender: UIButton) {
        
        HttpSwift.request("get", url: url) { (data, response, error) -> Void in
            //使用guard判断
            guard error != nil else{
                print(data)
                return
            }
            
        }
        
    }
    /*测试POST请求*/
    @IBAction func postRequest(sender: UIButton) {
        
        
        HttpSwift.request("POST", url: url, params: ["post": "value"]) { (data, response, error) -> Void in
            //使用guard判断
            guard error != nil else{
                print(data)
                
                return
            }
            
        }
        
        let url = "http://pitayaswift.sinaapp.com/pitaya.php"
        
        HttpSwift.post(url, callback: { (data, response, error) -> Void in
            //使用guard判断
            guard error != nil else{
                print(data)
                print("POST不带参数 请求成功")
                return
            }
            
        })
        HttpSwift.post(url, params: ["post": "POST Network"], callback: { (data, response, error) -> Void in
            let string = data
            
            //使用guard判断
            guard error != nil else{
                print(data)
                print("POST 2 请求成功 \(string)")
                return
            }
        })
        
        HttpSwift.get(url, callback: { (data, response, error) -> Void in
            let string = data
            
            //使用guard判断
            guard error != nil else{
                print(data)
                print("GET不带参数 请求成功 \(string)")
                return
            }
        })
        HttpSwift.get(url, params: ["get": "POST Network"], callback: { (data, response, error) -> Void in
            let string = data
            
            //使用guard判断
            guard error != nil else{
                print(data)
                print("GET带参数 请求成功 \(string)")
                return
            }
        })
        
        HttpSwift.request("GET", url: url, params: ["get": "Request Network"]) { (data, response, error) -> Void in
            let string = data
            print("Request 请求成功 \(string)")
        }
        
    }

}

