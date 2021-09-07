//
//  UIViewController+INSLoginNotifications.m
//  Bolts
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import "UIViewController+INSLoginNotifications.h"

#import "INSParseUIConstants.h"

@implementation UIViewController (INSLoginNotifications)

- (void)ins_registerLoginNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChanged) name:kNotificationUserLogin object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChanged) name:kNotificationUserSignUp object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStatusChanged) name:kNotificationUserLogout object:nil];
}

- (void)ins_unregisterLoginNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationUserLogin object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationUserSignUp object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationUserLogout object:nil];
}

@end
