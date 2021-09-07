//
//  SCLAlertView+ShowOnMostTopViewController.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import <SCLAlertView_Objective_C/SCLAlertView.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCLAlertView (ShowOnMostTopViewController)

- (void)ins_showSuccessOnMostTopViewControllerWithTitle:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration;

- (void)ins_showErrorOnMostTopViewControllerWithTitle:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration;

- (void)ins_showNoticeOnMostTopViewControllerWithTitle:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration;

- (void)ins_showWarningOnMostTopViewControllerWithTitle:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration;

- (void)ins_showInfoOnMostTopViewControllerWithTitle:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration;

- (void)ins_showEditOnMostTopViewControllerWithTitle:(NSString *)title subTitle:(NSString *)subTitle closeButtonTitle:(NSString *)closeButtonTitle duration:(NSTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
