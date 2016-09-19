//
//  FUCandarModel.h
//  FUDateAbout
//
//  Created by fujunzhi on 16/9/8.
//  Copyright © 2016年 FJZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MonthType)
{
    MonthTypeOfLast = 0,
    MonthTypeOfCurrent,
    MonthTypeOfNext,
    MonthTypeOfOther
};


@interface FUCandarModel : NSObject
/**
 *  边框颜色
 */
@property (strong, nonatomic) UIColor *borderColor;
/**
 *  本月字体颜色
 */
@property (strong, nonatomic) UIColor *monthTextColor;
/**
 *  本月日历颜色
 */
@property (strong, nonatomic) UIColor *dayColor;
/**
 *  选中颜色
 */
@property (strong, nonatomic) UIColor *daySelectColor;
/**
 *  非本月字体颜色
 */
@property (strong, nonatomic) UIColor *otherMonthTextColor;
/**
 *  非本月日历颜色
 */
@property (strong, nonatomic) UIColor *otherDayColor;
/**
 *  字体
 */
@property (strong, nonatomic) UIFont *textFont;
/**
 *  选中字体
 */
@property (strong, nonatomic) UIFont *textSelectFont;
/**
 *  内容
 */
@property (copy, nonatomic) NSString *text;
/**
 *  是否被选中
 */
@property (assign, nonatomic,getter=isWhetherSelect) BOOL whetherSelect;
/**
 *  月份类别
 */
@property (assign, nonatomic) MonthType monthType;

@end
