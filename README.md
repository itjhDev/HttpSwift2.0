## HttpSwift2.0

Swift2.0封装http请求

由于现在Swift2.0是beta版本，一些github上网络请求的框架不能使用，自己封装了一下！！

有问题可以发送邮件iosdev@itjh.com.cn, QQ群：383126909 IT江湖

感谢@johnlui 提供的Swift-On-iOS，Alamofire框架的函数

## 解决Swift2.0 请求http api不成功方案

在Info.plist文件中添加如下代码

```xml
<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitrayLoads</key>
		<true/>
		<key>NSExceptionDomains</key>
		<dict>
			<key>NSAllowsArbitraryLoads</key>
			<true/>
			<key>www.weather.com.cn</key>
			<dict>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSTemporaryExceptionMinimumTLSVersion</key>
				<string>TLSv1.1</string>
			</dict>
		</dict>
	</dict>
```
参考地址：https://developer.apple.com/library/prerelease/ios/technotes/App-Transport-Security-Technote/index.html 


## 开发环境
- iOS 9.0 / Mac OS X 10.11
- Xcode7 bete4 
- Swift2.0 beta

Installation
==========================
#### Cocoapod Method:-

`pod 'HttpSwift2.0', '~> 1.3'`


```swift
import HttpSwift
```

## 使用

### GET

```swift
HttpSwift.request("get", url: url) { (data, response, error) -> Void in
   //使用guard判断
   guard error != nil else{
     print(data)
     return
    }
 }
```
#### 打印结果
```shell
  返回结果
 {
    "weatherinfo":
    {"city":"太仓","cityid":"101190408","temp":"13","WD":"西北风","WS":"3级","SD":"93%","WSE":"3","time":"10:20","isR        adar":"0","Radar":"","njd":"暂无实况","qy":"1005"
    }
 }
```
### POST

```swift
/*测试POST请求*/ 

params:请求参数 

HttpSwift.request("POST", url: url, params: ["post": "value"]) { (data, response, error) -> Void in
    //使用guard判断
    guard error != nil else{
      print(data) 
      return
    }
}
```
## 更多方法请求

### POST

- POST不带参数
```swift
HttpSwift.post(url, callback: { (data, response, error) -> Void in
    //使用guard判断
    guard error != nil else{
        print(data)
        print("POST不带参数 请求成功")
        return
    }
})
```
- POST带参数
```swift
HttpSwift.post(url, params: ["post": "POST Network"], callback: { (data, response, error) -> Void in
    let string = data
    //使用guard判断
    guard error != nil else{
        print(data)
        print("POST 2 请求成功 \(string)")
        return
    }
})
```
### GET
- GET不带参数
```swift
HttpSwift.get(url, callback: { (data, response, error) -> Void in
    let string = data
    //使用guard判断
    guard error != nil else{
        print(data)
        print("GET不带参数 请求成功 \(string)")
        return
    }
})
```
- GET带参数
```swift
HttpSwift.get(url, params: ["get": "POST Network"], callback: { (data, response, error) -> Void in
    let string = data
    //使用guard判断
    guard error != nil else{
        print(data)
        print("GET带参数 请求成功 \(string)")
        return
    }
})
```

- PUT带参数
```swift
HttpSwift.put(url, params: ["put": "POST Network"], callback: { (data, response, error) -> Void in
    let string = data
    //使用guard判断
    guard error != nil else{
        print(data)
        print("put带参数 请求成功 \(string)")
        return
    }
})
```

- DELETE带参数
```swift
HttpSwift.delete(url, params: ["id":122]) { (data, response, error) -> Void in
    guard error != nil else{
        print(data)
        print("DELETE带参数 请求成功\(data)")
        return
    }
}
```


未完待续 PUT DELETE等请求方法
