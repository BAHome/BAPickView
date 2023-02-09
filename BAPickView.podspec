#
# Be sure to run `pod lib lint BAPickView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BAPickView'
  s.version          = '1.2.5'
  s.summary          = 'BAPickView 精简高效的选择器！'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.description      = <<-DESC
  V1.2.3 全新改版，优化一些小问题
  DESC
  
  s.homepage         = 'https://github.com/BAHome/BAPickView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'boai' => 'sunboyan@outlook.com' }
  s.source           = { :git => 'https://github.com/BAHome/BAPickView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.ios.deployment_target = '9.0'
  
  s.source_files = 'BAPickView/Classes/BAPickView_OC.h'
  s.resource_bundles = {
    'BAPickView' => ['BAPickView/Resources/*.{bundle}']
  }
  
  # Tools
  s.subspec 'Tools' do |stools|
    stools.source_files  = "BAPickView/Classes/Tools/*.{h,m}"
    stools.prefix_header_contents =
    '#import <UIKit/UIKit.h>',
    '#import <Foundation/Foundation.h>',
    '#import "BAKit_ConfigurationDefine.h"'
  end

  # PickerView
  s.subspec 'PickerView' do |spicker|
    spicker.dependency "BAPickView/Tools"
    spicker.source_files  = "BAPickView/Classes/PickerView/*.{h,m}"
    
  end
  
  s.dependency "Masonry"
    
  s.frameworks = 'UIKit', 'Foundation'
  s.requires_arc = true
  
end
