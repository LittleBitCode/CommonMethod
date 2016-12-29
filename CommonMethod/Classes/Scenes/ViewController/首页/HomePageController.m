//
//  HomePageController.m
//  CommonMethod
//
//  Created by littleBit on 2016/11/24.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import "HomePageController.h"

#import "PopViewController.h"
@interface HomePageController ()<CustomPopOverViewDelegate>
@property (nonatomic, strong)CustomPopOverView *popView;
@end

@implementation HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViews];
    [LBHTTPRequest requestWithHttpMethod:POST_REQUEST succeedBlock:^(BOOL isSuccess, NSDictionary *resultDic) {
        if (isSuccess) {
            [self bk_performBlock:^(id obj) {
                [self dismiss];
            } afterDelay:1.0f];
            NSLog(@"%@",resultDic);
        }else {
            [self bk_performBlock:^(id obj) {
                [self dismiss];
            } afterDelay:1.0f];
        }
    } failure:^(NSError *error) {
        LBLog(@"%@", error);
    }];

//     [self showAppStoreTip];
    // Do any additional setup after loading the view.
}
- (void)setViews {
    self.navigationItem.title = @"首页";
    UIButton *createButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [createButton setImage:[UIImage imageNamed:@"HomePage_Add"] forState:UIControlStateNormal];
    [createButton addTarget:self action:@selector(createGroup:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *createGroupItem = [[UIBarButtonItem alloc] initWithCustomView:createButton];
    [self.navigationItem setRightBarButtonItems:@[createGroupItem]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(popViewDismis) name:@"popViewDismis" object:nil];
}
/**
 弹出提示让用户去评论
 */
- (void)showAppStoreTip {
    // 在当前时间往后的1天后提示
    NSTimeInterval tipTime = [[NSUserDefaults standardUserDefaults]doubleForKey:@"tipToAppstore"];
    if (tipTime < 1) {
        [[NSUserDefaults standardUserDefaults]setObject:[NSDate dateWithTimeIntervalSince1970:+ 86400] forKey:@"tipToAppstore"];
    }
    //当前时间超过了规定时间就弹窗提示
    NSTimeInterval nowTime = [[NSDate date]timeIntervalSince1970];
    if (nowTime > tipTime) {
        LBToAppStore *lbs = [[LBToAppStore alloc] init];
        lbs.myAppID = @"1146271758";
        [lbs showGotoAppStore:self];
    }
}
#pragma mark - 让弹出视图消失
- (void)popViewDismis {
    [_popView dismiss];
}
- (void)createGroup:(UIButton *)sender {
    PopViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PopViewController"];
    vc.view.frame = CGRectMake(0, 0, kMainScreenWidth - 50, 270 *kWidthScale);
    _popView = [CustomPopOverView popOverView];
    _popView.delegate = self;
    _popView.contentViewController = vc;
    [_popView showFrom:sender alignStyle:CPAlignStyleRight];
}
- (void)dismiss {
    [MBProgressHUD hideHUD];
    [MBProgressHUD showSuccess:@"加载完成"];
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
