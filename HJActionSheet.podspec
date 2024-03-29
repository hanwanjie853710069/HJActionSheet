
Pod::Spec.new do |s|

  #名称，pod search 搜索的关键词,注意这里一定要和.podspec的名称一样,否则报错
  s.name         = "HJActionSheet"
  #版本号
  s.version      = "1.0.3"
  #支持的pod最低版本
  s.ios.deployment_target = '8.0'
  #简介
  s.summary      = "底部表单弹框"
  #项目主页地址
  s.homepage     = "https://github.com/hanwanjie853710069/HJActionSheet"
  #许可证
  s.license      = { :type => "MIT" }
  #作者
  s.author             = { "Mr.H" => "471941655@qq.com" }
  #社交网址
  s.social_media_url   = "https://www.jianshu.com/u/7f3c4198e1bd"
  #项目的地址
  s.source       = { :git => "https://github.com/hanwanjie853710069/HJActionSheet.git", :tag => s.version }
  #需要包含的源文件
  s.source_files  = "HJActionSheet/HJActionSheet/HJActionSheet/*.{h,m}"
  #是否支持ARC
  s.requires_arc = true

end
