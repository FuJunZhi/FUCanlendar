//
//  FUCandarWeekCell.m
//  FUDateAbout
//
//  Created by fujunzhi on 16/9/7.
//  Copyright © 2016年 FJZ. All rights reserved.
//

#import "FUCandarWeekCell.h"
#import "FUCandarModel.h"
#import "FUcanlendarHeader.h"

@interface FUCandarWeekCell()
@property (weak, nonatomic) IBOutlet UILabel *weekTitleLabel;

@end

@implementation FUCandarWeekCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setModel:(FUCandarModel *)model
{
    _model = model;
    self.weekTitleLabel.text = model.text;
    self.weekTitleLabel.font = _model.textFont;
    self.weekTitleLabel.textColor = _model.monthTextColor;
    self.backgroundColor = _model.dayColor;
}

@end
