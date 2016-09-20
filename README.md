# FUCanlendar
*Custom Calendar view

# initialize
==============

### CocoaPods
Installation with CocoaPods
1. Add `pod 'FUCanlendar 1.0.1'` to your Podfile.
2. Run `pod install` or `pod update`.
3. #import "FUCanlendarView.h".


1.+ (instancetype)fuCanlendarViewWithFrame:(CGRect)frame;
 
2.frame:CGRect;  effectBlock: 一次性设置所有的效果

 + (instancetype)fuCanlendarViewWithFrame:(CGRect)frame effect:(EffectBlock)effectBlock;

3.frame:CGRect;  didselectItem:选中Item;  lastBtnClick:上个月点击事件;  nextBtnClick:下个月点击事件

 + (instancetype)fuCanlendarViewWithFrame:(CGRect)frame didSelectItem:(DidSelectItem)didselectItem lastBtnClick:(LastBtnClick)lastBtnClick nextBtnClick:(NextBtnClick)nextBtnClick;

4.frame:CGRect; effectBlock:一次性设置所有的效果;  tem:选中Item;  lastBtnClick:上个月点击事件;  nextBtnClick:下个月点击事件
 
 + (instancetype)fuCanlendarViewWithFrame:(CGRect)frame effect:(EffectBlock)effectBlock didSelectItem:(DidSelectItem)didselectItem lastBtnClick:(LastBtnClick)lastBtnClick nextBtnClick:(NextBtnClick)nextBtnClick;

# setup
1.边框颜色
@property (strong, nonatomic) UIColor *borderColor;

2.本月字体颜色
@property (strong, nonatomic) UIColor *monthTextColor;

3.本月日历颜色
@property (strong, nonatomic) UIColor *dayColor;

4.选中颜色
@property (strong, nonatomic) UIColor *daySelectColor;

5.非本月字体颜色
@property (strong, nonatomic) UIColor *otherMonthTextColor;

6.非本月日历颜色
@property (strong, nonatomic) UIColor *otherDayColor;

7.字体
@property (strong, nonatomic) UIFont *textFont;

8.选中字体
@property (strong, nonatomic) UIFont *textSelectFont;

9.每周第一天（周一至周日：1-7，默认7）
@property (assign, nonatomic) NSInteger firstWeekday;

10.周标题边框样式
@property (assign, nonatomic) WeekBorderType weekBorderType;


.一次性设置所有的效果
- (void)setUpEffect:(EffectBlock)effectBlock;
