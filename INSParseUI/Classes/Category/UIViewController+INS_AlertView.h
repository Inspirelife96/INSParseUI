//
//  UIViewController+INS_AlertView.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (INS_AlertView)

- (void)ins_alertErrorWithTitle:(NSString *)title subTitle:(NSString *)subTtile;

- (void)ins_alertInfoWithTitle:(NSString *)title subTitle:(NSString *)subTtile;
@end

NS_ASSUME_NONNULL_END
