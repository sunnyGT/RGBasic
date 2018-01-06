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
  s.version      = "0.0.1"
  s.summary      = "A basic RGBasic."

  s.homepage     = "https://github.com/sunnyGT/RGBasic"


 # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "Robin_Gzb" => "a184820975@sina.cn" }

  s.platform     = :ios
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/sunnyGT/RGBasic.git", :tag => s.version }


  s.source_files  = "RGBasic", "RGBasic/**/*.{h,m}" , "RGBasic/**/**/*.{h,m}"

  s.framework  = "UIKit"
  s.requires_arc = true


  s.xcconfig = {"USER_HEADER_SEARCH_PATHS"=>"$(SRCROOT)" }

  s.prefix_header_file = 'RGBasic/XMPrefixHeader.pch'

  s.dependency "AFNetworking", "~> 3.1.0"
  s.dependency "Masonry", "~> 1.1.0"
  s.dependency "SDWebImage", "~> 4.2.2"
  s.dependency "MBProgressHUD", "~> 1.1.0"
  s.dependency "Base64", "~> 1.1.2"
  s.dependency "Mantle", "~> 2.1.0"
end
