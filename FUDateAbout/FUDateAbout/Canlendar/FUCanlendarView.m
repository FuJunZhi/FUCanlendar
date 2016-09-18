//
//  FUCanlendarView.m
//  FUDateAbout
//
//  Created by fujunzhi on 16/9/7.
//  Copyright © 2016年 FJZ. All rights reserved.
//

#import "FUCanlendarView.h"
#import "FUcanlendarHeader.h"
#import "FUCandarContentCell.h"
#import "FUCandarWeekCell.h"

#define effectSetUp(weakSelf) \
UIColor *borderColor;\
UIColor *monthTextColor;\
UIColor *dayColor;\
UIColor *daySelectColor;\
UIColor *otherDayColor;\
UIColor *otherMonthTextColor;\
UIFont *textFont;\
UIFont *textSelectFont;\
if (effectBlock) \
    effectBlock(&borderColor,&monthTextColor,&dayColor,&daySelectColor,&otherDayColor,&otherMonthTextColor,&textFont,&textSelectFont);\
weakSelf.borderColor = borderColor;\
weakSelf.monthTextColor = monthTextColor;\
weakSelf.dayColor = dayColor;\
weakSelf.daySelectColor = daySelectColor;\
weakSelf.otherDayColor = otherDayColor;\
weakSelf.otherMonthTextColor = otherMonthTextColor;\
weakSelf.textFont = textFont;\
weakSelf.textSelectFont = textSelectFont;\
[weakSelf setNeedsDisplay];


@interface FUCanlendarView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    LastBtnClick _lastBtnClick;
    NextBtnClick _nextBtnClick;
    DidSelectItem _didSelectItem;
}
@property (nonatomic, strong) NSMutableArray *dateDtaArray;
@property (nonatomic, strong) NSMutableArray *weekStrArr;//周数组
@property (nonatomic, copy) NSDictionary *todayDic;      //当前时间
@property (nonatomic, copy) NSString *selectDate;        //选择的时间
@property (nonatomic, assign) NSInteger year;            //年
@property (nonatomic, assign) NSInteger month;           //月
@property (nonatomic, assign) NSInteger day;             //日
@property (nonatomic, assign) NSInteger week;            //月第一天为周几

@property (assign, nonatomic,getter=isWTMonth) BOOL whetherThisMonth;

@property (weak, nonatomic) IBOutlet UIButton *lastMonthBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextMonthBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) UIView *backgroundView;
@property (weak, nonatomic) UICollectionView *weekTitleCV;
@property (weak, nonatomic) UICollectionView *contentCV;

@end


@implementation FUCanlendarView


#pragma mark - 懒加载
- (NSMutableArray *)weekStrArr
{
    if (!_weekStrArr)
    {
        self.weekStrArr = [@[] mutableCopy];
    }
    return _weekStrArr;
}

- (NSDictionary *)todayDic
{
    if (!_todayDic) {
    /*key值:
        S: 时间 Y: 年 M: 月 D: 日 
     */
        self.todayDic = @{};
    }
    return _todayDic;
}

- (NSString *)selectDate
{
    return [NSString stringWithFormat:@"%lu年%lu月%lu日",(long)_year,(long)_month,(long)_day];
}

- (void)setDay:(NSInteger)day
{
    _day = day;
    self.titleLabel.text = self.selectDate;
}

- (NSMutableArray *)dateDtaArray {
    
    if (!_dateDtaArray) {
        self.dateDtaArray = [@[] mutableCopy];
    }
    return _dateDtaArray;
}


- (UIColor *)borderColor
{
    if (!_borderColor) {
        self.borderColor = FUBorderColor;
    }
    return _borderColor;
}

-(UIColor *)monthTextColor
{
    if (!_monthTextColor) {
        self.monthTextColor = FUMonthTextColor;
    }
    return _monthTextColor;
}

- (UIColor *)otherMonthTextColor
{
    if (!_otherMonthTextColor) {
        self.otherMonthTextColor = FUOtherMonthTextColor;
    }
    return _otherMonthTextColor;
}

- (UIColor *)dayColor
{
    if (!_dayColor) {
        self.dayColor = FUDayColor;
    }
    return _dayColor;
}

- (UIColor *)daySelectColor
{
    if (!_daySelectColor) {
        self.daySelectColor = FUDaySelectColor;
    }
    return _daySelectColor;
}

- (UIColor *)otherDayColor
{
    if (!_otherDayColor) {
        self.otherDayColor = FUOtherDayColor;
    }
    return _otherDayColor;
}

- (UIFont *)textFont
{
    if (!_textFont) {
        self.textFont = FUTextFont;
    }
    return _textFont;
}

- (UIFont *)textSelectFont
{
    if (!_textSelectFont) {
        self.textSelectFont = FUTextSelectFont;
    }
    return _textSelectFont;
}


//是否是本月
- (BOOL)isWTMonth
{
    return (_year == [self.todayDic[@"Y"] integerValue] && _month == [self.todayDic[@"M"] integerValue]);
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        UIView *backgroundView = [[UIView alloc] init];
        self.backgroundView = backgroundView;
        [self addSubview:backgroundView];
    }
    return _backgroundView;
}


- (UICollectionView *)weekTitleCV
{
    if (!_weekTitleCV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        UICollectionView *weekTitleCV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.weekTitleCV = weekTitleCV;
        weekTitleCV.showsHorizontalScrollIndicator = NO;
        weekTitleCV.showsVerticalScrollIndicator = NO;
        weekTitleCV.dataSource = self;
        weekTitleCV.delegate = self;
        [weekTitleCV registerNib:[UINib nibWithNibName:NSStringFromClass([FUCandarWeekCell class]) bundle:nil] forCellWithReuseIdentifier:FUCandarWeekCellIdentifier];
        [self.backgroundView addSubview:weekTitleCV];
    }
    return _weekTitleCV;
}

- (UICollectionView *)contentCV
{
    if (!_contentCV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //左右
        layout.minimumInteritemSpacing = 1;
        //上下
        layout.minimumLineSpacing = 1;
        
        UICollectionView *contentCV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.contentCV = contentCV;
        contentCV.showsHorizontalScrollIndicator = NO;
        contentCV.showsVerticalScrollIndicator = NO;
        contentCV.dataSource = self;
        contentCV.delegate = self;
        [contentCV registerNib:[UINib nibWithNibName:NSStringFromClass([FUCandarContentCell class]) bundle:nil] forCellWithReuseIdentifier:FUCandarContentCellIdentifier];
        [self.backgroundView addSubview:contentCV];
    }
    return _contentCV;
}


//设置每周是周几开始
- (void)setFirstWeekday:(NSInteger)firstWeekday
{
    _firstWeekday = firstWeekday;
    if (firstWeekday > 7 || firstWeekday < 1)
        firstWeekday = 7;
    NSDictionary *weekDic = [NSDictionary dictionaryWithObjects:@[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"] forKeys:@[@(7),@(1),@(2),@(3),@(4),@(5),@(6)]];
    [self.weekStrArr removeAllObjects];
    for (int i = 0; i < 7; i++) {
        NSInteger week = (firstWeekday + i) % 7;
        week += week ? 0 : 7;
        FUCandarModel *model = [self fuCandarModelWithType:MonthTypeOfOther text:weekDic[@(week)]];
        [self.weekStrArr addObject:model];
    }
//    [self.weekTitleCV reloadData];
    [self computeDateMany];
}


- (void)setWeekBorderType:(WeekBorderType)weekBorderType
{
    _weekBorderType = weekBorderType;
    self.weekTitleCV.backgroundColor = (self.weekBorderType == WeekBorderTypeFill ? [UIColor clearColor] : self.dayColor);
    [self setNeedsLayout];
    
}


/*------------------------------------------------------*/

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
        self.frame = frame;
        [self computeDateToday];
    }
    return self;
}

+ (instancetype)fuCanlendarViewWithFrame:(CGRect)frame
{
    FUCanlendarView *canlendarView = [[FUCanlendarView alloc] initWithFrame:frame];
    return canlendarView;
}

+ (instancetype)fuCanlendarViewWithFrame:(CGRect)frame effect:(EffectBlock)effectBlock
{
    FUCanlendarView *canlendarView = [self fuCanlendarViewWithFrame:frame];
    effectSetUp(canlendarView)
    return canlendarView;
}

+ (instancetype)fuCanlendarViewWithFrame:(CGRect)frame didSelectItem:(DidSelectItem)didselectItem lastBtnClick:(LastBtnClick)lastBtnClick nextBtnClick:(NextBtnClick)nextBtnClick
{
    FUCanlendarView *canlendarView = [self fuCanlendarViewWithFrame:frame];
    canlendarView->_didSelectItem = didselectItem;
    canlendarView->_lastBtnClick = lastBtnClick;
    canlendarView->_nextBtnClick = nextBtnClick;
    return canlendarView;
}

+ (instancetype)fuCanlendarViewWithFrame:(CGRect)frame effect:(EffectBlock)effectBlock didSelectItem:(DidSelectItem)didselectItem lastBtnClick:(LastBtnClick)lastBtnClick nextBtnClick:(NextBtnClick)nextBtnClick
{
    FUCanlendarView *canlendarView = [self fuCanlendarViewWithFrame:frame didSelectItem:didselectItem lastBtnClick:lastBtnClick nextBtnClick:nextBtnClick];
    effectSetUp(canlendarView);
    return canlendarView;
}


//一次性设置所有的颜色
- (void)setUpEffect:(EffectBlock)effectBlock
{
    effectSetUp(self)
}

/*------------------------------------------------------*/

#pragma mark - 添加数据源

- (void)computeDateMany
{
    //计算当前月的第一天是周几
    [self computeWeek];
    //清空数据源
    [self.dateDtaArray removeAllObjects];
    
    int currentMonthDay = [self computeDateWithYear:_year month:_month];
    int lastMonthDay = [self computeLastDateWithYear:_year month:_month];
    
    //填充当月第一天之前的表格
    int nullCount = (int)_week - (_firstWeekday % 7 + 1);
    nullCount += nullCount < 0 ? 7 : 0;
    for (int i = lastMonthDay - nullCount + 1; i <= lastMonthDay; i++) {
        FUCandarModel *model = [self fuCandarModelWithType:MonthTypeOfLast text:[NSString stringWithFormat:@"%d",i]];
        [self.dateDtaArray addObject:model];
    }
    //添加当月天数
    for (int i = 1; i <= currentMonthDay; i++) {
        FUCandarModel *model = [self fuCandarModelWithType:MonthTypeOfCurrent text:[NSString stringWithFormat:@"%d",i]];
        [self.dateDtaArray addObject:model];
    }
    int n = 7 - ((nullCount + currentMonthDay) % 7 ? : 7);
    //填充剩余表格
    for (int i = 1; i <= n; i++) {
        FUCandarModel *model = [self fuCandarModelWithType:MonthTypeOfNext text:[NSString stringWithFormat:@"%d",i]];
        [self.dateDtaArray addObject:model];
    }
    [self setNeedsLayout];
    [self setNeedsDisplay];
//    [self.contentCV reloadData];
    
}

- (FUCandarModel *)fuCandarModelWithType:(MonthType)monthType text:(NSString *)text
{
    FUCandarModel *model = [[FUCandarModel alloc] init];
    model.text = text;
    model.monthType = monthType;
    if (monthType == MonthTypeOfCurrent) {
        //非当月第一天、当天，选中
        if ([self whetherThisDay:[text intValue]] || (!self.isWTMonth && [text intValue] == 1)) {
            model.whetherSelect = YES;
            [self setDay:[text intValue]];
        }
    }
    return model;
}

- (void)changeFUCandarModelEffect:(NSArray *)modelArr
{
    [modelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FUCandarModel *model = (FUCandarModel *)obj;
        model.borderColor = self.borderColor;
        model.monthTextColor = self.monthTextColor;
        model.dayColor = self.dayColor;
        model.daySelectColor = self.daySelectColor;
        model.otherMonthTextColor = self.otherMonthTextColor;
        model.otherDayColor = self.otherDayColor;
        model.textFont = self.textFont;
        model.textSelectFont = self.textSelectFont;
    }];
}



//计算当前天
- (void)computeDateToday {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *currentDate = [formatter stringFromDate:date];

    NSArray *yearMonthDay = [currentDate componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"年月日"]];
    _year = [yearMonthDay[0] integerValue];
    _month = [yearMonthDay[1] integerValue];
    _day = [yearMonthDay[2] integerValue];
    
    self.todayDic = @{@"S":currentDate,@"Y":@(_year),@"M":@(_month),@"D":@(_day)};
    
    self.nextMonthBtn.enabled = NO;
}

//计算当前月的第一天是周几
-(void)computeWeek {
    
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:1];
    [_comps setMonth:_month];
    [_comps setYear:_year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    _week = [weekdayComponents weekday]; // 星期天是 1
}

//计算月有几天
- (int)computeDateWithYear:(NSInteger)year month:(NSInteger)month {
    
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
        return 31;
    }else if (month == 2) {
        if(((year % 4 == 0)&&(year % 100 != 0))||(year %400 == 0)) {
            return 29;
        } else {
            return 28; // or return 29
        }
    } else {
        return 30;
    }
}

- (int)computeLastDateWithYear:(NSInteger)year month:(NSInteger)month
{
    NSInteger tempYear = year;
    NSInteger tempMonth = month - 1;
    if (tempMonth == 0)
    {
        tempYear -= 1;
        tempMonth = 12;
    }
    return [self computeDateWithYear:tempYear month:tempMonth];
}

//当天
- (BOOL)whetherThisDay:(NSInteger)day
{
    return self.isWTMonth && [self.todayDic[@"D"] integerValue] == day;
}


#pragma mark - <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.contentCV == collectionView) {
        FUCandarContentCell *cell = (FUCandarContentCell *)[collectionView cellForItemAtIndexPath:indexPath];
        FUCandarModel *model = cell.model;
        switch (model.monthType) {
            case MonthTypeOfCurrent:
            {
                [self.dateDtaArray makeObjectsPerformSelector:@selector(setWhetherSelect:) withObject:0];
                model.whetherSelect = YES;
                [collectionView reloadData];
                
                [self setDay:[model.text integerValue]];
            }
                break;
            case MonthTypeOfLast:
                !self.lastMonthBtn.enabled ? : [self lastMonthBtnClick:nil];
                break;
            case MonthTypeOfNext:
                !self.nextMonthBtn.enabled ? : [self nextMonthBtnClick:nil];
                break;
            default:
                break;
        }
        
        if (_didSelectItem) {
            _didSelectItem(cell,_year,_month,_day);
        }
        
        NSLog(@"fu_DidSelectItemAtIndexPath<%ld,%ld>：%@",indexPath.section,indexPath.item,self.titleLabel.text);
    }
}


#pragma mark - <UICollectionViewDataSource>
//返回Item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.contentCV)
        return self.dateDtaArray.count;
    else
        return self.weekStrArr.count;
}

//返回Item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.contentCV) {
        FUCandarContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FUCandarContentCellIdentifier forIndexPath:indexPath];
        cell.model = self.dateDtaArray[indexPath.item];
        return cell;
        
    } else
    {
        FUCandarWeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FUCandarWeekCellIdentifier forIndexPath:indexPath];
        cell.model = self.weekStrArr[indexPath.item];
        return cell;
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
//设置每一个 item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize collectionSize = collectionView.bounds.size;
    CGFloat itemW = (collectionSize.width  - 6) / 7;
    if (collectionView == self.weekTitleCV)
        return CGSizeMake(itemW, collectionSize.height);
    else
        return CGSizeMake(itemW, FUDayHeight);
}


#pragma mark - 上一月、下一月

- (IBAction)lastMonthBtnClick:(UIButton *)sender {
    
    if (_month == 1) {
        _month = 12 ;
        _year --;
    }else {
        _month -- ;
    }
    
    //设置按钮的显隐
    self.nextMonthBtn.enabled = !self.isWTMonth;
    //刷新
    [self computeDateMany];
    
    if (_lastBtnClick) {
        _lastBtnClick(self.selectDate,_year,_month,_year);
    }
    
}

- (IBAction)nextMonthBtnClick:(UIButton *)sender {
    
    if (_month == 12) {
        _month = 1 ;
        _year ++;
    }else {
        _month ++ ;
    }
    //设置按钮的显隐
    self.nextMonthBtn.enabled = !self.isWTMonth;
    //刷新
    [self computeDateMany];
    
    if (_nextBtnClick) {
        _nextBtnClick(self.selectDate,_year,_month,_year);
    }
    
}


#pragma  mark - layoutSubviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat bgX = 5;
    CGFloat bgY = CGRectGetMaxY(self.titleLabel.frame) + bgX;
    CGFloat bgW = self.frame.size.width - 2 * bgX;
    
    //设置标题frame
    CGFloat weekTitleX = (self.weekBorderType == WeekBorderTypeGap ? 0 : 1);
    CGFloat weekTitleY = (self.weekBorderType == WeekBorderTypeGap ? 0 : 1);
    CGFloat weekTitleW = bgW - 2 * weekTitleX;
    CGFloat weekTitleH = FUWeekHeight;
    self.weekTitleCV.frame = CGRectMake(weekTitleX, weekTitleY, weekTitleW, weekTitleH);
    
    //设置内容frame
    CGFloat contentX = 1;
    CGFloat contentY = CGRectGetMaxY(self.weekTitleCV.frame) + contentX;
    CGFloat contentW = bgW - 2 * contentX;
    NSInteger lineCount = self.dateDtaArray.count / 7;
    CGFloat realityH = lineCount * FUDayHeight + (lineCount - 1);
    CGFloat visualH = self.frame.size.height - bgY - contentY;
    self.contentCV.frame = CGRectMake(contentX, contentY, contentW, MIN(realityH, visualH));
    self.contentCV.contentSize = CGSizeMake(contentW, MAX(visualH, realityH));
    
    //设置背景frame
    CGFloat bgH = CGRectGetMaxY(self.contentCV.frame) + contentX;
    self.backgroundView.frame = CGRectMake(bgX, bgY, bgW, bgH);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.weekTitleCV.backgroundColor = (self.weekBorderType == WeekBorderTypeFill ? [UIColor clearColor] : self.dayColor);
    self.contentCV.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = self.borderColor;
    [self changeFUCandarModelEffect:self.weekStrArr];
    [self changeFUCandarModelEffect:self.dateDtaArray];
    [self.contentCV reloadData];
    [self.weekTitleCV reloadData];
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    self.firstWeekday ? : [self setFirstWeekday:FUFirstWeekday];
}

- (void)didSelectItem:(DidSelectItem)didselectItem
{
    _didSelectItem = didselectItem;
}
- (void)lastButtonClick:(LastBtnClick)lastBtnClick
{
    _lastBtnClick = lastBtnClick;
}
- (void)nextButtonClick:(NextBtnClick)nextBtnClick
{
    _nextBtnClick = nextBtnClick;
}











@end
