//
//  FUcanlendarHeader.h
//  FUDateAbout
//
//  Created by fujunzhi on 16/9/8.
//  Copyright © 2016年 FJZ. All rights reserved.
//

#ifndef FUcanlendarHeader_h
#define FUcanlendarHeader_h
#import "FUCandarModel.h"

static NSString *const FUBackgroundIdentifier = @"backgroundCV";
static NSString *const FUCandarWeekCellIdentifier = @"FUCandarWeekCell";
static NSString *const FUCandarContentCellIdentifier = @"FUCandarContentCell";

//默认每周开始时间
#define FUFirstWeekday        7
//默认边框颜色
#define FUBorderColor         [UIColor lightGrayColor]

//默认本月字体颜色
#define FUMonthTextColor      [UIColor blackColor]

//默认非本月字体颜色
#define FUOtherMonthTextColor [UIColor lightGrayColor]

//默认本月日历颜色
#define FUDayColor            [UIColor whiteColor]

//默认选中颜色
#define FUDaySelectColor      [UIColor redColor]

//默认非本月日历颜色
#define FUOtherDayColor       [UIColor lightTextColor]

// 默认标题字体
#define FUTextFont            [UIFont systemFontOfSize:15]

//默认选中字体
#define FUTextSelectFont      [UIFont systemFontOfSize:17]

//默认周标题高度
#define FUWeekHeight          35

//默认日高度
#define FUDayHeight           60

#endif /* FUcanlendarHeader_h */
