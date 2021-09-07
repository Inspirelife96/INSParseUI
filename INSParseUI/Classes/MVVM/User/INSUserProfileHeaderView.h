//
//  INSUserProfileHeaderView.h
//  Bolts
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class INSUserProfileViewModel;

@protocol INSUserProfileHeaderViewProtocol <NSObject>

@required
- (void)clickProfileImageButton:(id)sender;

@optional
- (void)clickFollow:(PFUser *)userObject;
- (void)clickFollowed:(PFUser *)userObject;

@end

@interface INSUserProfileHeaderView : UIView

@property (nonatomic, weak) id<INSUserProfileHeaderViewProtocol> delegate;

- (void)configWithUserProfileVM:(INSUserProfileViewModel *)userProfileVM;

@end

NS_ASSUME_NONNULL_END
