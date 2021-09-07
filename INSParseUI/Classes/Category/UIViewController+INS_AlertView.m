//
//  UIViewController+INS_AlertView.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/30.
//

#import "UIViewController+INS_AlertView.h"

#import "SCLAlertView+ShowOnMostTopViewController.h"

@implementation UIViewController (INS_AlertView)

- (void)ins_alertErrorWithTitle:(NSString *)title subTitle:(NSString *)subTtile {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    [alert ins_showErrorOnMostTopViewControllerWithTitle:title subTitle:subTtile closeButtonTitle:@"确认" duration:0.0f];
}

- (void)ins_alertInfoWithTitle:(NSString *)title subTitle:(NSString *)subTtile {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    [alert ins_showInfoOnMostTopViewControllerWithTitle:title subTitle:subTtile closeButtonTitle:@"确认" duration:0.0f];
}

@end
