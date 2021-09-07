//
//  INSLogInView.h
//  Bolts
//
//  Created by XueFeng Chen on 2021/6/30.
//

#import <UIKit/UIKit.h>

#import "INSLogInViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface INSLogInView : UIView

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *signUpButton;
@property (nonatomic, strong) UIButton *resetPasswordButton;

@property (nonatomic, weak) id<INSLogInViewProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
