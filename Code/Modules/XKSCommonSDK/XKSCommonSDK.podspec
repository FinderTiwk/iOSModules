Pod::Spec.new do |spec|
  spec.name         = "XKSCommonSDK"       #名称
  spec.version      = "1.0.0"              #版本号
  spec.summary      = "公用模块组件"         #描述
  spec.homepage     = "www.xkeshi.com" #描述页面
  spec.license      = 'WTF'    #版权声明
  spec.author       = { "_Finder丶Tiwk" => "fh@xkeshi.com" }
  spec.platform     = :ios, '8.0'    #支持的系统
  spec.source       = { :path => 'XKSCommon'}
  spec.source_files  = 'XKSCommon/SDK/**/*.{h,m}'    #源码
  spec.requires_arc = true       #是否需要arc
  spec.resource_bundles = {
    'XKSCommonSDK' => [
        'XKSCommon/SDK/**/*.{storyboard,xcassets,xib}'
    ]
  }
  spec.ios.dependency 'OpenSSL-Classic', '~> 1.0.1.j'

end
