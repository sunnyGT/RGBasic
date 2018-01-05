//
//  UITableView+XMTableViewTool.m
//  RGBasic
//
//  Created by robin on 2017/5/20.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "UITableView+XMTableViewTool.h"
#import <objc/runtime.h>

@implementation UITableView (XMTableViewTool)

@dynamic placeHoldView;

XM_DYNAMIC_PROPERTY_OBJECT(placeHoldView, setPlaceHoldView, RETAIN, UIView *);

//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        Class cls = [self class];
//        
//        SEL originSEL = @selector(reloadData);
//        
//        SEL swizzlSEL = @selector(swizzl_reloadData);
//        
//        Method originMethod = class_getInstanceMethod(cls, originSEL);
//        Method swizzlMethod = class_getInstanceMethod(cls, swizzlSEL);
//        
//        method_exchangeImplementations(originMethod, swizzlMethod);
//    });
//}

- (void)swizzl_reloadData{
    [self swizzl_reloadData];
    [self configurePlaceHoldView];
}

- (void)swizzl_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    [self swizzl_deleteSections:sections withRowAnimation:animation];
    [self configurePlaceHoldView];

}

- (void)swizzl_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation{
    [self swizzl_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self configurePlaceHoldView];

}

- (void)configurePlaceHoldView{
    
    if ([self isEnmptyOrNot]) {
        [self setupPlaceHoldView];
    }else{
        [self resetPlaceHoldView];
    }
}

- (void)setupPlaceHoldView{
    
    if (self.placeHoldView) {
        
        if (self.placeHoldView.superview) return;
        
    }else{
        
        [self defualtPlaceHoldView];
    }
    [self addSubview:self.placeHoldView];
    self.scrollEnabled = NO;
    
}

- (void )defualtPlaceHoldView{
    [self.superview layoutIfNeeded];
    UIView *containView = [[UIView alloc] initWithFrame:self.bounds];
    
    UIImage *placeHoldImage = [UIImage imageNamed:@"placeHoldImage"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:placeHoldImage];
    imageView.bounds = (CGRect){CGPointZero ,placeHoldImage.size};
    imageView.center = self.center;
    [containView addSubview:imageView];
    
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 30.f)];
    alertLabel.center = CGPointMake(imageView.center.x, imageView.y - alertLabel.height);
    alertLabel.text = @"除了一阵风什么都没有";
    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.textColor = [UIColor lightGrayColor];
    [containView addSubview:alertLabel];
    
    self.placeHoldView = containView;
}

- (void)resetPlaceHoldView{
    
    [self.placeHoldView removeFromSuperview];
    self.placeHoldView = nil;
    self.scrollEnabled = YES;
}

- (BOOL)isEnmptyOrNot{
    NSInteger numSections = [self numberOfSections];
    for (NSInteger idx =  0; idx < numSections; idx ++ ) {
        if ([self.dataSource tableView:self numberOfRowsInSection:idx]) return NO;
    }
    return YES;
}



@end
