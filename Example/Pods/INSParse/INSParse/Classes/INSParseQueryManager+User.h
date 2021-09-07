//
//  INSParseQueryManager+User.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface INSParseQueryManager (User)

+ (void)logInWithUsername:(NSString *)userName password:(NSString *)password error:(NSError **)error;

+ (void)signUpWithUsername:(NSString *)userName password:(NSString *)password email:(NSString *)email error:(NSError **)error;

+ (BFTask *)loginWithAppleAuthType:(NSString *)authType authData:(NSDictionary<NSString *, NSString *> *)authData username:(NSString *)userName email:(NSString *)email error:(NSError **)error;

+ (void)logout;

+ (void)unsubscribe;

+ (void)requestPasswordResetForEmail:(NSString *)email error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
