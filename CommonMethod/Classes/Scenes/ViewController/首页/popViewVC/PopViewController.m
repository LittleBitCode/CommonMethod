//
//  PopViewController.m
//  CommonMethod
//
//  Created by littleBit on 2016/12/2.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import "PopViewController.h"
#import "ProcessView.h"
@interface PopViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

@end

@implementation PopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[
                       @{@"assignee":@"Icon",@"state":@"0"},
                       @{@"assignee":@"Icon",@"state":@"1"},
                       @{@"assignee":@"Icon",@"state":@"2"},
                       @{@"assignee":@"Icon",@"state":@"3"},
                       @{@"assignee":@"Icon",@"state":@"4"},
                       @{@"assignee":@"Icon",@"state":@"5"},
                       @{@"assignee":@"Icon",@"state":@"6"},
                       @{@"assignee":@"Icon",@"state":@"7"},
                       @{@"assignee":@"Icon",@"state":@"8"},
                       @{@"assignee":@"Icon",@"state":@"9"},
                       ];
    [self creatProcessWithProcessList:array];
    // Do any additional setup after loading the view.
}
- (void)creatProcessWithProcessList:(NSArray *)array {
    if (array.count <= 3 && array.count > 0) {
        self.contentHeight.constant = 150 *kWidthScale;
    }else if (array.count <= 6 && array.count > 3) {
        self.contentHeight.constant = 300 *kWidthScale;
    }else if (array.count <=9 && array.count > 6){
        self.contentHeight.constant = 400 *kWidthScale;
    }else if (array.count <= 12 && array.count > 9){
        self.contentHeight.constant = 500 *kWidthScale;
    }else if (array.count <= 15 && array.count > 12){
        self.contentHeight.constant = 650 *kWidthScale;
    }
    int totalloc = 3;
    CGFloat appvieww = 80 * kWidthScale;
    CGFloat appviewh = 110 * kWidthScale;
    CGFloat margin = (kMainScreenWidth - 40 - totalloc * appvieww)/(totalloc + 1);
    int count = (int)array.count;
    for (int i =  0;  i < count; i++) {
        int row = i/totalloc;//行号
        int loc = i%totalloc;//列号
        CGFloat appviewx = margin + (margin + appvieww)*loc;
        CGFloat appviewy = margin + (margin + appviewh)*row;
        ProcessView *appview = [[ProcessView alloc] initWithFrame:CGRectMake(appviewx - 5,  appviewy , appvieww, appviewh) andIconImage:[UIImage imageNamed:array[i][@"assignee"]] andDescription:array[i][@"state"]];
        appview.tag = 1088 + i;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SingleTap:)];
        [appview.iconBtn addTarget:self action:@selector(chooseChild:) forControlEvents:UIControlEventTouchUpInside];
        [appview addGestureRecognizer:tap];
        [self.mainScrollView addSubview:appview];
    }
}
- (void)SingleTap:(UITapGestureRecognizer *)tap {
    [self chooseChildWithTag:tap.view.tag];
}
- (void)chooseChild:(UIButton *)sender {
    [self chooseChildWithTag:sender.superview.tag];
}

- (void)chooseChildWithTag:(NSInteger)tag {
//    NSLog(@"%ld",tag);
    [MBProgressHUD showMessage:[NSString stringWithFormat:@"您选择的是第%ld个item",tag-1088]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
    });
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popViewDismis" object:nil];
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
