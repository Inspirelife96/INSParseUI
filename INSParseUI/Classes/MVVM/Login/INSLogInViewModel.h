//
//  INSLogInViewModel.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSLogInViewModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *authType;
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *authData;

- (BOOL)checkUserName:(NSString * _Nonnull *_Nullable)errorMessage;
- (BOOL)checkPassword:(NSString * _Nonnull *_Nullable)errorMessage;
- (BOOL)checkEmail:(NSString * _Nonnull *_Nullable)errorMessage;

- (void)loginInBackground:(void(^)(BOOL succeeded, NSString *messageTitle, NSString *messageSubTitle))refreshUIBlock;
- (void)signUpInBackground:(void(^)(BOOL succeeded, NSString *messageTitle, NSString *messageSubTitle))refreshUIBlock;
- (void)loginWithAppleAuthDataInBackground:(void(^)(BOOL succeeded, NSString *messageTitle, NSString *messageSubTitle))refreshUIBlock;
- (void)requestPasswordResetForEmailInBackground:(void(^)(BOOL succeeded, NSString *messageTitle, NSString *messageSubTitle))refreshUIBlock;

@end

NS_ASSUME_NONNULL_END
