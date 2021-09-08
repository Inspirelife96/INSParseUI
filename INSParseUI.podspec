#
# Be sure to run `pod lib lint INSParseUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'INSParseUI'
  s.version          = '0.1.6'
  s.summary          = 'A short description of INSParseUI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Inspirelife96/INSParseUI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'inspirelife@hotmail.com' => 'inspirelife@hotmail.com' }
  s.source           = { :git => 'https://github.com/Inspirelife96/INSParseUI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'INSParseUI/Classes/**/*'
  
  s.resource_bundles = {
    'INSParseUI' => ['INSParseUI/Assets/*.*']
  }
  
  s.prefix_header_contents = '#import <Parse/Parse.h>', '#import <INSParse/INSParse-umbrella.h>', '#import <DZNEmptyDataSet/DZNEmptyDataSet-umbrella.h>', '#import <Lottie/lottie-ios-umbrella.h>', '#import <YBImageBrowser/YBImageBrowser.h>', '#import <SDWebImage/SDWebImage.h>', '#import <Masonry/Masonry.h>', '#import <MJRefresh/MJRefresh.h>', '#import <SVProgressHUD/SVProgressHUD.h>', '#import <SCLAlertView_Objective_C/SCLAlertView-Objective-C-umbrella.h>', '#import <JKCategories/JKCategories-umbrella.h>', '#import <YYText/YYText.h>', '#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>', '#import <SwiftTheme/SwiftTheme-Swift.h>', '#import <TZImagePickerController/TZImagePickerController.h>', '#import <MKDropdownMenu/MKDropdownMenu.h>', '#import <LSTPopView/LSTPopView.h>'

  s.public_header_files = 'INSParseUI/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'Parse'
  s.dependency 'INSParse'
  s.dependency 'JKCategories/Foundation/NSDate'
  s.dependency 'JKCategories/Foundation/NSString'
  s.dependency 'JKCategories/UIKit/UIWindow'
  s.dependency 'JKCategories/UIKit/UIScreen'
  s.dependency 'JKCategories/UIKit/UIButton'
  s.dependency 'JKCategories/UIKit/UIColor'
  s.dependency 'JKCategories/UIKit/UIView'
  s.dependency 'DZNEmptyDataSet'
  s.dependency 'Masonry'
  s.dependency 'lottie-ios'
  s.dependency 'SDWebImage'
  s.dependency 'YBImageBrowser'
  s.dependency 'MJRefresh'
  s.dependency 'SVProgressHUD'
  s.dependency 'SCLAlertView-Objective-C'
  s.dependency 'YYText'
  s.dependency 'SwiftTheme'
  s.dependency 'TZImagePickerController'
  s.dependency 'MKDropdownMenu'
  s.dependency 'LSTPopView'
  s.dependency 'HJTabViewController', '~> 1.0'
  
end
