//
//  UIViewController+INSLogin.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import "UIViewController+INSLogin.h"

#import "INSLogInViewController.h"

#import "UIViewController+INS_AlertView.h"

#import "INSParseUIConstants.h"

#import "SCLAlertView+ShowOnMostTopViewController.h"

@implementation UIViewController (INSLogin)

- (BOOL)ins_isLogin {
    if ([PFUser currentUser]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)ins_login {
    INSLogInViewController *loginVC = [[INSLogInViewController alloc] init];
    loginVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)ins_logout {
    //[[IRDLocalConfiguration sharedInstance] updateToParseServer];
    [SVProgressHUD showWithStatus:@"退出中..."];
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        if (error) {
            [self ins_alertErrorWithTitle:@"退出失败，请重新再试" subTitle:error.localizedDescription];
        } else {
            [[PFInstallation currentInstallation] removeObjectForKey:@"user"];
            [[PFInstallation currentInstallation] saveInBackground];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLogout object:nil];
        }
    }];
}

- (void)ins_showLoginAlertViewWithSubTitle:(NSString *)subTitle {
    SCLAlertView *alertView = [[SCLAlertView alloc] init];
    [alertView addButton:@"好的，去登录" actionBlock:^{
        [self ins_login];
    }];
    
    [alertView ins_showInfoOnMostTopViewControllerWithTitle:@"请先登录" subTitle:subTitle closeButtonTitle:@"不了，先逛逛" duration:0];
}

- (void)ins_showLogoutAlertWithBlock:(void(^)(void))logoutBlock andUnsubscribeAlertWithBlock:(void(^)(void))unsubscribeBlock {
    SCLAlertView *alertView = [[SCLAlertView alloc] init];
    [alertView addButton:@"退出登录" actionBlock:^{
        logoutBlock();
    }];
    
    [alertView addButton:@"注销账户" actionBlock:^{
        [self ins_showUnsubscribeAlertWithBlock:unsubscribeBlock];
    }];
    
    [alertView ins_showInfoOnMostTopViewControllerWithTitle:@"账户操作" subTitle:@"" closeButtonTitle:@"继续逛逛" duration:0];
}

- (void)ins_showUnsubscribeAlertWithBlock:(void(^)(void))unsubscribeBlock {
    SCLAlertView *alertView = [[SCLAlertView alloc] init];
    [alertView addButton:@"确定" actionBlock:^{
        unsubscribeBlock();
    }];
    
    [alertView ins_showWarningOnMostTopViewControllerWithTitle:@"注销账户" subTitle:@"系统将回收这个账户，我们将删除您的信息，且今后您将不能使用这个账户进行登录，确认吗？" closeButtonTitle:@"取消" duration:0];
}

@end
