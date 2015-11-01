Pod::Spec.new do |s|
  s.name         = "HttpSwift2.0"
  s.version      = "1.2"
  s.summary      = "httpSwift2.0 HttpClient"

  s.homepage     = "https://github.com/itjhDev/HttpSwift2.0"

  s.license      = 'MIT'
  s.author       = { "Lijun Song" => "iosdev@itjh.com.cn" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/itjhDev/HttpSwift2.0.git", :tag => s.version}
  s.source_files  = 'HttpSwift2.0/HttpSwift.swift'
  s.requires_arc = true
end