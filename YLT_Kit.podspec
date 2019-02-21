
Pod::Spec.new do |s|
  s.name             = 'YLT_Kit'
  s.version          = '0.3.16'
  s.summary          = 'YLT_Kit. 基础的kit框架'

  s.description      = <<-DESC
  平常使用的基础kit框架封装
                       DESC

  s.homepage         = 'https://github.com/YLTTeam/ylt_kit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xphaijj0305@126.com' => 'xiangph@qtec.cn' }
  s.source           = { :git => 'https://github.com/YLTTeam/ylt_kit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'YLT_Kit/Classes/**/*'
  s.public_header_files = 'YLT_Kit/Classes/**/*.h'
  s.frameworks = 'UIKit', 'AVFoundation', 'AssetsLibrary', 'WebKit'
  s.dependency 'AFNetworking'
  s.dependency 'ReactiveObjC'
  s.dependency 'Masonry'
  s.dependency 'YLT_BaseLib'
  s.dependency 'SDWebImage'
  s.dependency 'MJRefresh'
  s.dependency 'Aspects'
end
