//
//  UIViewController+INSLoginNotifications.h
//  Bolts
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (INSLoginNotifications)

- (void)ins_registerLoginNotifications;
- (void)ins_unregisterLoginNotifications;

@end

NS_ASSUME_NONNULL_END
