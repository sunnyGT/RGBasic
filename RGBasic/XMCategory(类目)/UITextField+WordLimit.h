//
//  UITextField+WordLimit.h
//  AoChuangEconomics
//
//  Created by robin on 2017/4/12.
//  Copyright © 2017年 KuBaoInternet. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITextField (WordLimit)

@property (nonatomic ,assign)NSInteger maxLength;
@property (nonatomic ,assign)NSInteger minLength;

- (void)configureMaxLength:(NSInteger)maxLength minLength:(NSInteger)minLength;
@end
