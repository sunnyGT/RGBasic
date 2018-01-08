#
#  Be sure to run `pod spec lint RGBasic.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "RGBasic"
  s.version      = "0.0.3"
  s.summary      = "A basic RGBasic."

  s.homepage     = "https://github.com/sunnyGT/RGBasic"


 # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "Robin_Gzb" => "a184820975@sina.cn" }

  s.platform     = :ios
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/sunnyGT/RGBasic.git", :tag => s.version }


  s.source_files  = "RGBasic/*.{h.m}" , "RGBasic/Relevance/*.h"

  #  , "RGBasic/**/**/*.{h,m}"

  s.framework  = "UIKit"
  s.requires_arc = true

  s.xcconfig = {"USER_HEADER_SEARCH_PATHS"=>"$(SRCROOT)" }
  s.prefix_header_file = 'RGBasic/XMPrefixHeader.pch'

 
  # s.dependency "Masonry", "~> 1.1.0"
  # s.dependency "MBProgressHUD", "~> 1.1.0"
  # s.dependency "Base64", "~> 1.1.2"


  s.subspec 'RGNetwork' do |ns|

    ns.source_files = 'RGBasic/XMNetWork(网络)/*.{h,m}'
    ns.public_header_files = 'RGBasic/XMNetWork(网络)/*.h'
    ns.dependency "AFNetworking", "~> 3.1.0"
  end

  s.subspec 'RGCategory' do |cs|

    cs.source_files = 'RGBasic/XMCategory(类目)/*.{h,m}'
    cs.public_header_files = 'RGBasic/XMCategory(类目)/*.h'
    cs.dependency "RGBasic/RGUtilities"
    cs.dependency "RGBasic/RGMacro"
    cs.framework  = "UIKit"
    cs.dependency "RGBasic/RGMacro"
  end

  s.subspec 'RGBasicUI' do |bs|

    bs.source_files = 'RGBasic/XMBasicUI(UI基类)/*.{h,m}'
    bs.public_header_files = 'RGBasic/XMBasicUI(UI基类)/*.h'
    bs.dependency "Masonry", "~> 1.1.0"
    bs.dependency "RGBasic/RGMacro"
    bs.dependency "RGBasic/RGCategory"
  end

  s.subspec 'RGUtilities' do |us|

    us.source_files = 'RGBasic/XMUtilities(工具)/**/*.{h,m}'
    us.public_header_files = 'RGBasic/XMUtilities(工具)/**/*.h'
    us.dependency "Base64", "~> 1.1.2"
    us.dependency "MBProgressHUD", "~> 1.1.0"
    us.dependency "RGBasic/RGMacro"
  end
  
  s.subspec 'RGMacro' do |ms|

    ms.source_files = 'RGBasic/XMMacro.h'
    ms.public_header_files = 'RGBasic/XMMacro.h'
  end
 
end
