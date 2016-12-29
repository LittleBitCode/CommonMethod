//
//  MyController.m
//  CommonMethod
//
//  Created by littleBit on 2016/11/25.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import "MyController.h"



@interface MyController ()

@end

@implementation MyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title  = @"我的";
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    MySwiftController *vc = [[MySwiftController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
