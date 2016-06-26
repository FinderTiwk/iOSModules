Pod::Spec.new do |spec|
  spec.name         = "XKSHomeModule"       #名称
  spec.version      = "1.0.0"              #版本号
  spec.summary      = "登录模块"         #描述
  spec.homepage     = "www.xkeshi.com" #描述页面
  spec.license      = 'WTF'    #版权声明
  spec.author       = { "_Finder丶Tiwk" => "fh@xkeshi.com" }
  spec.platform     = :ios, '8.0'    #支持的系统
  spec.source       = { :path => 'XKSHomeModule'}
  spec.source_files  = 'XKSHomeModule/src/**/*.{h,m}'    #源码
  spec.requires_arc = true       #是否需要arc
  spec.resource_bundles = {
    'XKSHomeModule' => [
        'XKSHomeModule/src/**/*.{storyboard,xib}',
        'XKSHomeModule/images/images.xcassets'
    ]
  }

end
