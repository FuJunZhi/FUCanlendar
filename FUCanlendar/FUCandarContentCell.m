//
//  FUCandarContentCell.m
//  FUDateAbout
//
//  Created by fujunzhi on 16/9/7.
//  Copyright © 2016年 FJZ. All rights reserved.
//

#import "FUCandarContentCell.h"
#import "FUcanlendarHeader.h"
#import "FUCandarModel.h"

@interface FUCandarContentCell()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end


@implementation FUCandarContentCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(FUCandarModel *)model
{
    _model = model;
    [self setNeedsLayout];
}


- (BOOL)isCurrentMonth
{
    return self.model.monthType == MonthTypeOfCurrent;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.font = _model.textFont;
    if (self.isCurrentMonth)
    {
        self.textLabel.text = _model.text;
        self.textLabel.textColor = _model.monthTextColor;
        self.detailLabel.textColor = _model.monthTextColor;
        self.backgroundColor = _model.dayColor;
        if (_model.isWhetherSelect) {
            self.backgroundColor = _model.daySelectColor;
        }
    } else
    {
        self.textLabel.text = _model.text;
        self.textLabel.textColor = _model.otherMonthTextColor;
        self.detailLabel.textColor = _model.otherMonthTextColor;
        self.backgroundColor = _model.otherDayColor;
    }
}

@end
