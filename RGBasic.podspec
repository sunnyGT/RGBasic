Pod::Spec.new do |s|

  s.name         = "RGBasic"
  s.version      = "0.0.6"
  s.summary      = "A basic RGBasic."
  s.homepage     = "https://github.com/sunnyGT/RGBasic"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "Robin_Gzb" => "a184820975@sina.cn" }
  s.platform     = :ios
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/sunnyGT/RGBasic.git", :tag => s.version }


  s.source_files  = "RGBasic/XM.h" , "RGBasic/Relevance/*.h"


  s.subspec 'RGMacro' do |ms|

    ms.source_files = 'RGBasic/XMMacro.h'
    ms.public_header_files = 'RGBasic/XMMacro.h'
  end

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

    bs.source_files = 'RGBasic/XMBasicUI(UI基类)/*.{h,m}' , 'RGBasic/XMBasicUI(UI基类)/**/*.h'
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
  

  s.framework  = "UIKit"
  s.requires_arc = true

  s.xcconfig = {"USER_HEADER_SEARCH_PATHS"=>"$(SRCROOT)" }

  # s.prefix_header_file = "RGBasic/XMPrefixHeader.pch"

  # s.prefix_header_contents = '#import "XMMacro.h"','#import "XMAppDelegate.h"','#import "XMHUD.h"','#import "XMNetworkMananger.h"','#import "UIView+XMViewRect.h"','#import "NSString+XMStringTool.h"','#import "Masonry.h"','#import "XMNavigationBar.h"','#import "XMNavigationController.h"','#import "XMViewController.h"','#import "NSUserDefaults+XMSaveTool.h"'
 
end
