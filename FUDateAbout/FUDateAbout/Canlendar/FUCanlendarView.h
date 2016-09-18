//
//  FUCanlendarView.h
//  FUDateAbout
//
//  Created by fujunzhi on 16/9/7.
//  Copyright © 2016年 FJZ. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ EffectBlock)(UIColor **borderColor,UIColor **monthTextColor,UIColor **dayColor,UIColor **daySelectColor,UIColor **otherDayColor,UIColor **otherMonthTextColor,UIFont **textFont,UIFont **textSelectFont);
typedef void(^DidSelectItem)(UICollectionViewCell *collectionViewCell,NSInteger year, NSInteger month, NSInteger day);
typedef void(^LastBtnClick)(NSString *currentTieme, NSInteger year, NSInteger month, NSInteger day);
typedef void(^NextBtnClick)(NSString *currentTieme, NSInteger year, NSInteger month, NSInteger day);


/**
 *  周标题 边框样式
 */
typedef NS_ENUM(NSInteger, WeekBorderType) {
    WeekBorderTypeAround = 0,
    WeekBorderTypeFill,
    WeekBorderTypeGap
};


@interface FUCanlendarView : UIView


/**************************效果****************************/
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
 *  每周第一天（周一至周日：1-7，默认7）
 */
@property (assign, nonatomic) NSInteger firstWeekday;
/**
 *  周标题边框样式
 */
@property (assign, nonatomic) WeekBorderType weekBorderType;


//一次性设置所有的效果
- (void)setUpEffect:(EffectBlock)effectBlock;

/************************初始化******************************/

/**
 *  创建FUCanlendarView
 *
 *  @param frame CGRect
 *
 *  @return FUCanlendarView
 */
+ (instancetype)fuCanlendarViewWithFrame:(CGRect)frame;
/**
 *  创建FUCanlendarView
 *
 *  @param frame       CGRect
 *  @param effectBlock 一次性设置所有的效果
 *
 *  @return FUCanlendarView
 */
+ (instancetype)fuCanlendarViewWithFrame:(CGRect)frame effect:(EffectBlock)effectBlock;
/**
 *  创建FUCanlendarView
 *
 *  @param frame         CGRect
 *  @param didselectItem 选中Item
 *  @param lastBtnClick  上个月点击事件
 *  @param nextBtnClick  下个月点击事件
 *
 *  @return FUCanlendarView
 */
+ (instancetype)fuCanlendarViewWithFrame:(CGRect)frame didSelectItem:(DidSelectItem)didselectItem lastBtnClick:(LastBtnClick)lastBtnClick nextBtnClick:(NextBtnClick)nextBtnClick;
/**
 *  创建FUCanlendarView
 *
 *  @param frame         CGRect
 *  @param effectBlock   一次性设置所有的效果
 *  @param didselectItem 选中Item
 *  @param lastBtnClick  上个月点击事件
 *  @param nextBtnClick  下个月点击事件
 *
 *  @return FUCanlendarView
 */
+ (instancetype)fuCanlendarViewWithFrame:(CGRect)frame effect:(EffectBlock)effectBlock didSelectItem:(DidSelectItem)didselectItem lastBtnClick:(LastBtnClick)lastBtnClick nextBtnClick:(NextBtnClick)nextBtnClick;



- (void)didSelectItem:(DidSelectItem)didselectItem;
- (void)lastButtonClick:(LastBtnClick)lastBtnClick;
- (void)nextButtonClick:(NextBtnClick)nextBtnClick;




@end
