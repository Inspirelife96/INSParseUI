//
//  INSLogInViewModel.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/30.
//

#import "INSLogInViewModel.h"

#import "NSString+JKNormalRegex.h"

#import "INSParseErrorHandler.h"

@implementation INSLogInViewModel

- (instancetype)init {
    if (self = [super init]) {
        _userName = @"";
        _password = @"";
        _email = @"";
        _authType = @"";
        _authData = @{};
    }
    
    return self;
}

- (BOOL)checkUserName:(NSString **)errorMessage {
    if ([self.userName isEqualToString:@""]) {
        *errorMessage = @"请输入用户名";
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)checkPassword:(NSString **)errorMessage {
    if ([self.password isEqualToString:@""]) {
        *errorMessage = @"请输入密码";
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)checkEmail:(NSString **)errorMessage {
    if ([self.email jk_isEmailAddress]) {
        return YES;
    } else {
        *errorMessage = @"请输入正确的邮箱地址";
        return NO;
    }
}

- (void)loginInBackground:(void(^)(BOOL succeeded, NSString *messageTitle, NSString *messageSubTitle))refreshUIBlock {
//    self.isLogining = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL succeeded = YES;
        NSString *messageTitle = @"";
        NSString *messageSubTitle = @"";

        NSError *error = nil;
        [INSParseQueryManager logInWithUsername:self.userName password:self.password error:&error];

        if (error) {
            succeeded = NO;
            messageTitle = @"登录失败";
            if (error.code == kPFErrorObjectNotFound) {
                messageSubTitle = @"用户名/密码错误";
            } else {
                messageSubTitle = [INSParseErrorHandler errorMessage:error.code];
            }
        } else {
            succeeded = YES;
            messageTitle = @"恭喜您，登录成功";
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            refreshUIBlock(succeeded, messageTitle, messageSubTitle);
        });
    });
}

- (void)signUpInBackground:(void(^)(BOOL succeeded, NSString *messageTitle, NSString *messageSubTitle))refreshUIBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL succeeded = YES;
        NSString *messageTitle = @"";
        NSString *messageSubTitle = @"";

        NSError *error = nil;
        [INSParseQueryManager signUpWithUsername:self.userName password:self.password email:self.email error:&error];
        
        if (error) {
            succeeded = NO;
            messageTitle = @"注册失败";
            messageSubTitle = [INSParseErrorHandler errorMessage:error.code];
        } else {
            succeeded = YES;
            messageTitle = @"恭喜您，注册成功";
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            refreshUIBlock(succeeded, messageTitle, messageSubTitle);
        });
        
    });
}

// 和平常的不同，内部直接调用了PFUser的函数
- (void)loginWithAppleAuthDataInBackground:(void(^)(BOOL succeeded, NSString *messageTitle, NSString *messageSubTitle))refreshUIBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL succeeded = YES;
        NSString *messageTitle = @"";
        NSString *messageSubTitle = @"";
        
        NSError *error = nil;
        BFTask *task = [INSParseQueryManager loginWithAppleAuthType:self.authType authData:self.authData username:self.userName email:self.email error:&error];
        
        if (task.isCancelled) {
            succeeded = NO;
            messageTitle = @"登陆失败";
            messageSubTitle = @"用户取消了登陆请求";
        } else if (task.error) {
            succeeded = NO;
            messageTitle = @"登陆失败";
            messageSubTitle = [INSParseErrorHandler errorMessage:error.code];
        } else {
            succeeded = YES;
            messageTitle = @"恭喜您，登录成功";
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            refreshUIBlock(succeeded, messageTitle, messageSubTitle);
        });
        
    });
}

- (void)requestPasswordResetForEmailInBackground:(void(^)(BOOL succeeded, NSString *messageTitle, NSString *messageSubTitle))refreshUIBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL succeeded = YES;
        NSString *messageTitle = @"";
        NSString *messageSubTitle = @"";
        
        NSError *error = nil;
        [INSParseQueryManager requestPasswordResetForEmail:self.email error:&error];
        
        if (error) {
            succeeded = NO;
            messageTitle = @"密码重置失败";
            messageSubTitle = [INSParseErrorHandler errorMessage:error.code];
        } else {
            succeeded = YES;
            messageTitle = @"密码重置成功";
            messageSubTitle = @"请前往您的邮箱，进行后续的密码重置操作";
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            refreshUIBlock(succeeded, messageTitle, messageSubTitle);
        });
        
    });
}

@end
