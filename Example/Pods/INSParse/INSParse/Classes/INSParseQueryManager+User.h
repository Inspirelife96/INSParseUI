//
//  INSParseQueryManager+User.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface INSParseQueryManager (User)

/**
 同步登录

 可以由error判断登录是否成功
 登录成功后可以调用[PFUser currentUser]获取当前的登录用户

 @param userName 用户名
 @param password 密码
 @param error 出错信息
 */
+ (void)logInWithUsername:(NSString *)userName password:(NSString *)password error:(NSError **)error;

+ (BFTask *)loginWithAppleAuthType:(NSString *)authType authData:(NSDictionary<NSString *, NSString *> *)authData username:(NSString *)userName email:(NSString *)email error:(NSError **)error;

+ (void)signUpWithUsername:(NSString *)userName password:(NSString *)password email:(NSString *)email error:(NSError **)error;

+ (void)logOut;

+ (void)requestPasswordResetForEmail:(NSString *)email error:(NSError **)error;

+ (void)unsubscribe:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
