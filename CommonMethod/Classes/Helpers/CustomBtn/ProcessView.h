//
//  ProcessView.h
//  JiaXiaoTongTeacher
//
//  Created by littleBit on 16/9/1.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProcessView : UIView
@property (nonatomic , strong)UILabel *topLabel;

@property (nonatomic , strong)UILabel *bottomLabel;

@property (nonatomic ,strong)UILabel *saleLabel;

@property (nonatomic ,strong)UIButton *iconBtn;

-(instancetype)initWithFrame:(CGRect)frame andTopLabelText:(NSString *)topLabelText andBottomLabelText:(NSString *)bottomLabelText withSaleString:(NSString *)saleString;

-(instancetype)initWithFrame:(CGRect)frame andTopLabelText:(NSString *)topLabelText andBottomLabelText:(NSString *)bottomLabelText ;

-(instancetype)initWithFrame:(CGRect)frame andIconImage:(UIImage *)image andDescription:(NSString *)des;

@end
