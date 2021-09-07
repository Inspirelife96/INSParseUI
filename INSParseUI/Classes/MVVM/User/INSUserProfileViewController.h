//
//  INSUserProfileViewController.h
//  Bolts
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import <HJTabViewController/HJTabViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSUserProfileViewController : HJTabViewController

- (instancetype)initWithUser:(PFUser *)userObject;

@end

NS_ASSUME_NONNULL_END
