//
//  ProcessView.m
//  JiaXiaoTongTeacher
//
//  Created by littleBit on 16/9/1.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import "ProcessView.h"

@implementation ProcessView
-(instancetype)initWithFrame:(CGRect)frame andTopLabelText:(NSString *)topLabelText andBottomLabelText:(NSString *)bottomLabelText withSaleString:(NSString *)saleString
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [kBGCOLOR CGColor];
        self.topLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 * kWidthScale, 10 * kWidthScale, 60 * kWidthScale, 21 * kWidthScale)];
        self.topLabel.text = topLabelText;
        self.topLabel.textAlignment = NSTextAlignmentCenter;
        self.topLabel.font = [UIFont systemFontOfSize:15];
        self.topLabel.textColor = kBGCOLOR;
        
        self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 * kWidthScale, 31 * kWidthScale, 50 * kWidthScale, 15 * kWidthScale)];
        self.bottomLabel.textAlignment = NSTextAlignmentCenter;
        self.bottomLabel.textColor = kBGCOLOR;
        self.bottomLabel.font = [UIFont systemFontOfSize:10];
        self.bottomLabel.text = bottomLabelText;
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(35* kWidthScale, -10, 60* kWidthScale, 35)];
        self.saleLabel = [[UILabel alloc] initWithFrame:CGRectMake(34* kWidthScale, 11, 53* kWidthScale, 13)];
        self.saleLabel.text = saleString;
        self.saleLabel.textColor = [UIColor whiteColor];
        view.backgroundColor = [UIColor redColor];
        self.saleLabel.font = [UIFont systemFontOfSize:11.2];
        view.transform=CGAffineTransformMakeRotation(M_PI/4);
        self.saleLabel.transform=CGAffineTransformMakeRotation(M_PI/4);
        [view addSubview:self.saleLabel];
        
        
        [self addSubview:view];
        [self addSubview:self.saleLabel];
        [self addSubview:self.topLabel];
        [self addSubview:self.bottomLabel];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame andTopLabelText:(NSString *)topLabelText andBottomLabelText:(NSString *)bottomLabelText
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1.0f;
        
        self.topLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 * kWidthScale, 10 * kWidthScale, 60 * kWidthScale, 21 * kWidthScale)];
        self.topLabel.text = topLabelText;
        self.topLabel.textAlignment = NSTextAlignmentCenter;
        self.topLabel.font = [UIFont systemFontOfSize:15];
        
        self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 * kWidthScale, 31 * kWidthScale, 50 * kWidthScale, 15 * kWidthScale)];
        self.bottomLabel.textAlignment = NSTextAlignmentCenter;
        self.bottomLabel.font = [UIFont systemFontOfSize:10];
        self.bottomLabel.text = bottomLabelText;
        
        if ([bottomLabelText isEqualToString:@"2"]) {
            self.bottomLabel.textColor = kBGCOLOR;
            self.layer.borderColor = [kBGCOLOR CGColor];
            self.topLabel.textColor = kBGCOLOR;
            self.bottomLabel.text = @"已通过";
        }else if ([bottomLabelText isEqualToString:@"3"]){
            self.layer.borderColor =[UIColor redColor].CGColor;
            self.bottomLabel.textColor = [UIColor redColor];
            self.topLabel.textColor =[UIColor redColor];
            self.bottomLabel.text = @"已拒绝";
        }else if ([bottomLabelText isEqualToString:@"0"]){//不需要审批
            self.topLabel = [[UILabel alloc]initWithFrame:CGRectMake(5 * kWidthScale, 14 * kWidthScale, 60 * kWidthScale, 21 * kWidthScale)];
            self.topLabel.text = topLabelText;
            self.topLabel.textAlignment = NSTextAlignmentCenter;
            self.topLabel.font = [UIFont systemFontOfSize:15];
            self.bottomLabel.textColor = kBGCOLOR;
            self.layer.borderColor = [kBGCOLOR CGColor];
            self.topLabel.textColor = kBGCOLOR;
            self.bottomLabel.text = @"";
        }else{
            self.bottomLabel.textColor =  [UIColor colorWithRed:221.0f/255.0f green:150.0f/255.0f blue:17.0f/255.0f alpha:1];
            self.layer.borderColor = [UIColor colorWithRed:221.0f/255.0f green:150.0f/255.0f blue:17.0f/255.0f alpha:1].CGColor;
            self.topLabel.textColor = [UIColor colorWithRed:221.0f/255.0f green:150.0f/255.0f blue:17.0f/255.0f alpha:1] ;
            self.bottomLabel.text = @"审核中";
        }
        [self addSubview:self.topLabel];
        [self addSubview:self.bottomLabel];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame andIconImage:(UIImage *)image andDescription:(NSString *)des
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [kBGCOLOR CGColor];
        self.iconBtn = [[UIButton alloc]initWithFrame:CGRectMake(10 * kWidthScale, 10 * kWidthScale, 60 * kWidthScale, 60 * kWidthScale)];
        [self.iconBtn setBackgroundImage:image forState:UIControlStateNormal];

        
        self.bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(10 * kWidthScale, 80 * kWidthScale, 60 * kWidthScale, 20 * kWidthScale)];
        self.bottomLabel.textAlignment = NSTextAlignmentCenter;
        self.bottomLabel.textColor = kBGCOLOR;
        self.bottomLabel.font = [UIFont systemFontOfSize:10];
        self.bottomLabel.text = des;

        [self addSubview:self.iconBtn];
        [self addSubview:self.bottomLabel];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
