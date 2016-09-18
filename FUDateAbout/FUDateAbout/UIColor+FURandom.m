//
//  UIColor+FURandom.m
//  FUDateAbout
//
//  Created by fujunzhi on 16/9/13.
//  Copyright © 2016年 FJZ. All rights reserved.
//

#import "UIColor+FURandom.h"

@implementation UIColor (FURandom)
+ (UIColor *)fu_randomColor
{
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}
@end
