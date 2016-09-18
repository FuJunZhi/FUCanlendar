//
//  FUCanlendarTestVC.m
//  FUDateAbout
//
//  Created by fujunzhi on 16/9/7.
//  Copyright © 2016年 FJZ. All rights reserved.
//

#import "FUCanlendarTestVC.h"
#import "FUCanlendarView.h"
#import "UIColor+FURandom.h"

#define iOS8_3Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.3f)

@interface FUCanlendarTestVC ()<UIActionSheetDelegate>
@property (weak, nonatomic) FUCanlendarView *fuCanlendarView;
@end

@implementation FUCanlendarTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    //set up
    [self setUpFUCanlendarView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:NSSelectorFromString(@"editEffectOfFUCanlendarView")];
}

//设置FUCanlendarView（*****）
- (void)setUpFUCanlendarView
{
    FUCanlendarView *fuCanlendarView = [FUCanlendarView fuCanlendarViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    self.fuCanlendarView = fuCanlendarView;
    [self.view addSubview:fuCanlendarView];
}


//更改效果
- (void)changeEffect
{
    //block change color
    [self.fuCanlendarView setUpEffect:^(UIColor *__autoreleasing *borderColor, UIColor *__autoreleasing *monthTextColor, UIColor *__autoreleasing *dayColor, UIColor *__autoreleasing *daySelectColor, UIColor *__autoreleasing *otherDayColor, UIColor *__autoreleasing *otherMonthTextColor, UIFont *__autoreleasing *textFont, UIFont *__autoreleasing *textSelectFont) {
        *borderColor = [UIColor fu_randomColor];
        *dayColor = [UIColor fu_randomColor];
        *daySelectColor = [UIColor fu_randomColor];
        *otherDayColor = [UIColor fu_randomColor];
        *otherMonthTextColor = [UIColor fu_randomColor];
    }];
}

//默认效果
- (void)changeDefaultEffect
{
    //方法一：block nil
//    [self.fuCanlendarView setUpEffect:nil];
    
    
    //方法二：
    [self.fuCanlendarView setUpEffect:^(UIColor *__autoreleasing *borderColor, UIColor *__autoreleasing *monthTextColor, UIColor *__autoreleasing *dayColor, UIColor *__autoreleasing *daySelectColor, UIColor *__autoreleasing *otherDayColor, UIColor *__autoreleasing *otherMonthTextColor, UIFont *__autoreleasing *textFont, UIFont *__autoreleasing *textSelectFont) {
        
    }];
}

//更改标题边框样式
- (void)changeWeekBorderType:(NSInteger)type
{
    [self.fuCanlendarView setWeekBorderType:type];
}

//更改周首日
- (void)changeFirstWeekDay:(NSInteger)day
{
    [self.fuCanlendarView setFirstWeekday:day];
}


/*............................以下都是弹框(测试效果)............................*/
#pragma mark - 弹框
- (void)editEffectOfFUCanlendarView
{
    if (iOS8_3Later) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"编辑" message:@"更改效果" preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"更改每周首日" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self changeFirstWeekDay];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"更改效果" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self changeEffect];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"默认效果" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //block nil
            [self changeDefaultEffect];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"更改标题边框样式" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self changeWeekBorderType];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    } else
    {
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"编辑" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"更改每周首日",@"更改效果",@"默认效果",@"更改标题边框样式", nil];
        action.tag = 101;
        [action showInView:self.view];
    }
    
}

//UIActionSheet相关
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 101)
    {
        switch (buttonIndex) {
            case 0:
            {
                //设置每周是周几开始
                UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"周" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"一",@"二",@"三",@"四",@"五",@"六",@"日", nil];
                action.tag = 102;
                [action showInView:self.view];
            }
                break;
            case 1:
            {
                //更改效果
                [self changeEffect];
            }
                break;
            case 2:
            {
                //默认效果
                [self changeDefaultEffect];
            }
                break;
            case 3:
            {
                //更改标题边框样式
                UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"标题边框样式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"WeekBorderTypeAround",@"WeekBorderTypeFill",@"WeekBorderTypeGap", nil];
                action.tag = 103;
                [action showInView:self.view];
            }
                break;
                
            default:
                break;
        }
    } else if (actionSheet.tag == 102)
    {
        [self changeFirstWeekDay:buttonIndex + 1];
    } else if (actionSheet.tag == 103)
    {
        [self.fuCanlendarView setWeekBorderType:buttonIndex];
    }
}




//UIAlertController相关
//更改周首日
- (void)changeFirstWeekDay
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"周" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"一" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self changeFirstWeekDay:1];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"二" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self changeFirstWeekDay:2];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"三" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self changeFirstWeekDay:3];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"四" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self changeFirstWeekDay:4];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"五" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self changeFirstWeekDay:5];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"六" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self changeFirstWeekDay:6];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"日" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self changeFirstWeekDay:7];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
//更改边框样式
- (void)changeWeekBorderType
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"标题边框样式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"WeekBorderTypeAround" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.fuCanlendarView setWeekBorderType:WeekBorderTypeAround];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"WeekBorderTypeFill" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.fuCanlendarView setWeekBorderType:WeekBorderTypeFill];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"WeekBorderTypeGap" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.fuCanlendarView setWeekBorderType:WeekBorderTypeGap];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
