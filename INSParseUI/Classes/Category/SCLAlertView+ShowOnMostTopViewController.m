//
//  SCLAlertView+ShowOnMostTopViewController.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import "SCLAlertView+ShowOnMostTopViewController.h"

@implementation SCLAlertView (ShowOnMostTopViewController)

- (void)ins_showSuccessOnMostTopViewControllerWithTitle:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration {
    return [self showSuccess:[self _mostTopViewController] title:title subTitle:subTitle closeButtonTitle:closeButtonTitle duration:duration];
}

- (void)ins_showErrorOnMostTopViewControllerWithTitle:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration {
    return [self showError:[self _mostTopViewController] title:title subTitle:subTitle closeButtonTitle:closeButtonTitle duration:duration];
}

- (void)ins_showNoticeOnMostTopViewControllerWithTitle:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration {
    return [self showNotice:[self _mostTopViewController] title:title subTitle:subTitle closeButtonTitle:closeButtonTitle duration:duration];
}

- (void)ins_showWarningOnMostTopViewControllerWithTitle:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration {
    return [self showWarning:[self _mostTopViewController] title:title subTitle:subTitle closeButtonTitle:closeButtonTitle duration:duration];
}

- (void)ins_showInfoOnMostTopViewControllerWithTitle:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration {
    return [self showInfo:[self _mostTopViewController] title:title subTitle:subTitle closeButtonTitle:closeButtonTitle duration:duration];
}

- (void)ins_showEditOnMostTopViewControllerWithTitle:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration {
    return [self showEdit:[self _mostTopViewController] title:title subTitle:subTitle closeButtonTitle:closeButtonTitle duration:duration];
}

- (UIViewController *)_mostTopViewController {
    UIWindow *mainWindow = [[UIApplication sharedApplication] windows][0];
    return [mainWindow jk_topMostController];
}

@end
