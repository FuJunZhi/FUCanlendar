//
//  FUCandarContentCell.h
//  FUDateAbout
//
//  Created by fujunzhi on 16/9/7.
//  Copyright © 2016年 FJZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FUCandarModel;

@interface FUCandarContentCell : UICollectionViewCell

@property (assign, nonatomic,getter=isCurrentMonth) BOOL currentMonth;
@property (strong, nonatomic) FUCandarModel *model;

@end
