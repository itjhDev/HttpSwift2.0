## HttpSwift2.0

Swift2.0封装http请求

由于现在Swift2.0是beta版本，一些github上网络请求的框架不能使用，自己封装了一下！！

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

```swift
import HttpSwift
```

## 使用

###GET

```swift
HttpSwift.request("get", url: url) { (data, response, error) -> Void in
   //使用guard判断
   guard error != nil else{
     print(data)
     return
    }
 }
```




