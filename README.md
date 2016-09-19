# FUCanlendar
Custom Calendar view

# initialize
1.+ (instancetype)fuCanlendarViewWithFrame:(CGRect)frame;
 
2.frame:CGRect;  effectBlock: 一次性设置所有的效果

 + (instancetype)fuCanlendarViewWithFrame:(CGRect)frame effect:(EffectBlock)effectBlock;

3.frame:CGRect;  didselectItem:选中Item;  lastBtnClick:上个月点击事件;  nextBtnClick:下个月点击事件

 + (instancetype)fuCanlendarViewWithFrame:(CGRect)frame didSelectItem:(DidSelectItem)didselectItem lastBtnClick:(LastBtnClick)lastBtnClick nextBtnClick:(NextBtnClick)nextBtnClick;

4.frame:CGRect; effectBlock:一次性设置所有的效果;  tem:选中Item;  lastBtnClick:上个月点击事件;  nextBtnClick:下个月点击事件
 
 + (instancetype)fuCanlendarViewWithFrame:(CGRect)frame effect:(EffectBlock)effectBlock didSelectItem:(DidSelectItem)didselectItem lastBtnClick:(LastBtnClick)lastBtnClick nextBtnClick:(NextBtnClick)nextBtnClick;

# setup
边框颜色
@property (strong, nonatomic) UIColor *borderColor;

本月字体颜色
@property (strong, nonatomic) UIColor *monthTextColor;

本月日历颜色
@property (strong, nonatomic) UIColor *dayColor;

选中颜色
@property (strong, nonatomic) UIColor *daySelectColor;

非本月字体颜色
@property (strong, nonatomic) UIColor *otherMonthTextColor;

非本月日历颜色
@property (strong, nonatomic) UIColor *otherDayColor;

字体
@property (strong, nonatomic) UIFont *textFont;

选中字体
@property (strong, nonatomic) UIFont *textSelectFont;

每周第一天（周一至周日：1-7，默认7）
@property (assign, nonatomic) NSInteger firstWeekday;

周标题边框样式
@property (assign, nonatomic) WeekBorderType weekBorderType;


//一次性设置所有的效果
- (void)setUpEffect:(EffectBlock)effectBlock;
