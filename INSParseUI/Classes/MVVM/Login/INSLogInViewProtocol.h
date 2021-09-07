//
//  INSLogInViewProtocol.h
//  Bolts
//
//  Created by XueFeng Chen on 2021/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol INSLogInViewProtocol <NSObject>

@required
- (void)login;
- (void)signUp;
- (void)resetPassword;
- (void)loginWithAppleID;

@end

NS_ASSUME_NONNULL_END
