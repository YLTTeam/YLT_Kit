#
# Be sure to run `pod lib lint YLT_Kit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YLT_Kit'
  s.version          = '0.0.2'
  s.summary          = 'YLT_Kit. 基础的kit框架'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  平常使用的基础kit框架封装
                       DESC

  s.homepage         = 'https://github.com/YLTTeam/ylt_kit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xphaijj0305@126.com' => 'xiangph@qtec.cn' }
  s.source           = { :git => 'https://github.com/YLTTeam/ylt_kit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YLT_Kit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'YLT_Kit' => ['YLT_Kit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ReactiveObjC', '~> 3.0.0'
end
