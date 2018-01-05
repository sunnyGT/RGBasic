//
//  XMMacro.h
//  XMBasicProject
//
//  Created by robin on 2017/4/13.
//  Copyright © 2017年 robin. All rights reserved.
//

#ifndef XMMacro_h
#define XMMacro_h

#pragma mark - Tools

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...){}
#endif

#define  isNUllOrNil(object) (((object) == (id)kCFNull)  || !(object))

#define XMUserDefaults [NSUserDefaults standardUserDefaults]

#define RADIANS_TO_DEGREES(x) ((x)/M_PI*180.0) //弧度转角度
#define DEGREES_TO_RADIANS(x) ((x)/180.0*M_PI) //角度转弧度

#ifndef weakify

#define weakify(object) __weak typeof(object) weak##object = object;

#endif

#ifndef strongify

#define strongify(object) __strong typeof(object) strong##_##object = object;

#endif


#pragma mark -runtime 添加各个类型属性

/**
 exmaple:
 
 #import "XMProjectManager.h"
 
 @interface XMProjectManager (RGProjectManager)
 
 @property (nonatomic ,strong)id project;
 @end

 
 #import "XMProjectManager+RGProjectManager.h"
 
 #import <objc/runtime.h>
 
 @implementation XMProjectManager (RGProjectManager)
 
 XM_DYNAMIC_PROPERTY_OBJECT(project, setProject, RETAIN, id)
 
 @end
 */

/**
 
 runtime 动态添加对象熟悉 注意引入objc/runtime.h头文件

 @param _getter_ 对象get方法名称
 @param _setter_ 对象get方法名称
 @param _associated_ OBJC_ASSOCIATION_RETAIN_NONATOMIC
 @param _type_ 对象类型
 @return
 */
#ifndef XM_DYNAMIC_PROPERTY_OBJECT
#define XM_DYNAMIC_PROPERTY_OBJECT(_getter_ , _setter_ , _associated_, _type_)\
- (void) _setter_ : (_type_) object{ \
[self willChangeValueForKey:@#_getter_];\
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _associated_ ## _NONATOMIC); \
[self didChangeValueForKey:@#_getter_];\
}\
- (_type_)_getter_{\
return objc_getAssociatedObject(self , @selector(_setter_:));\
}
#endif


//动态添加结构体类型属性
#ifndef XM_DYNAMIC_PROPERTY_CTYPE
#define XM_DYNAMIC_PROPERTY_CTYPE(_getter_ , _setter_ , _type_)\
- (void) _setter_ :(_type_)object{\
[self willChangeValueForKey:@#_getter_];\
NSValue *value = [NSValue value:&object withObjCType:@encode(_type_)];\
objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
[self didChangeValueForKey:@#_getter_];\
}\
- (_type_)_getter_{\
_type tempValue = { 0 };\
NSValue *value = objc_getAssociatedObject(self , @selector(_setter_:));\
[value getValue:&tempValue];\
return tempValue;\
}
#endif

//动态添加基础数据类型属性
#ifndef XM_DYNAMIC_PROPERTY_N_TYPE
#define XM_DYNAMIC_PROPERTY_N_TYPE(_getter_ , _setter_ , _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
NSValue *value = [NSValue value:&object withObjCType:@encode(_type_)]; \
objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
_type_ cValue; \
NSValue *value = objc_getAssociatedObject(self, @selector(_setter_:)); \
[value getValue:&cValue]; \
return cValue; \
}
#endif

#ifndef XM_OBJECT
#define XM_OBJECT(_className_)\
Class cls = NSClassFromString(_className_); \
id clsObject = [cls new];
#endif


#pragma mark - Screen

//****************SCREEN************************
#define Screen_Height [[UIScreen mainScreen] bounds].size.height
#define Screen_Width [[UIScreen mainScreen] bounds].size.width
#define Screen_CenterY CGRectGetMidY([[UIScreen mainScreen] bounds])
#define Screen_ScaleW (Screen_Width/375.f)
#define Screen_ScaleH (Screen_Height/667.f)
#define NavigationBarHeight 44.f
#define StatusBarHeight 20.f
#define NavigationBarBottomY (64.f+(kDevice_Is_iPhoneX?24:0))
#define TabbarHeight (49.f+(kDevice_Is_iPhoneX?20:0))
#define KeyWindow [UIApplication sharedApplication].keyWindow

#pragma mark -Font
//************************FONT************************ //

//HelveticaNeue-Medium
//HelveticaNeue-Thin
//HelveticaNeue-Regular
#define XMFontOfSize(SIZE) [UIFont fontWithName:@"HelveticaNeue" size:((SIZE) * Screen_ScaleH)]

#define XMFontWithNameAndSize(NAME,SIZE) [UIFont fontWithName:NAME size:((SIZE) * Screen_ScaleH)]

#define WidthToFit(Width) ((Width) * Screen_ScaleW)
#define HeightToFit(Height) ((Height) * Screen_ScaleH)


#pragma mark - Colors
//************************Color************************ //
#define  ThemeColor  [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]

#define  ThemeTintColor   [UIColor colorWithRed:250/255.0 green:76/255.0 blue:20/255.0 alpha:1]

#define  VCBackgroudColor [UIColor colorWithRed:240/255.0 green:246/255.0 blue:250/255.0 alpha:1]

#define  LightGrayColor  [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1]


#define  LightTextGrayColor  [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1]

#define  RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define  RGBA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A];


#pragma mark - Rect


#pragma mark - Host

#define XM_SUCCESS_CODE 0
//http://xmap1708111.php.hzxmnet.com/Admin/Index/index.html
#define XM_BASIC_URL @"http://xmap1708111.php.hzxmnet.com"

#pragma mark - Key

#define RSA_PUBLIC_KEY @""
#define RSA_PRIVATE_KEY @""

#define AES_ENCODE_AND_DECODE_KEY @"7L26ZYCYRNQF43A3"

#ifndef IS_SIMULATOR
    #if TARGET_IPHONE_SIMULATOR
        #define IS_SIMULATOR 1
    #elif TARGET_OS_IPHONE
        #define IS_SIMULATOR 0
    #endif
#endif

#endif /* XMMacro_h */
