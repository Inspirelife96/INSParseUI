//
//  UIViewController+INSLogin.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (INSLogin)

- (BOOL)ins_isLogin;

- (void)ins_login;
- (void)ins_logout;

- (void)ins_showLoginAlertViewWithSubTitle:(NSString *)subTitle;

- (void)ins_showLogoutAlertWithBlock:(void(^)(void))logoutBlock andUnsubscribeAlertWithBlock:(void(^)(void))unsubscribeBlock;

@end

NS_ASSUME_NONNULL_END
