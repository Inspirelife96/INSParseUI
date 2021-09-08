//
//  INSParseUIConstants.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import <Foundation/Foundation.h>

#define WEAKSELF __weak __typeof(&*self)weakSelf = self;
#define STRONGSELF __strong __typeof(weakSelf)strongSelf = weakSelf;

//static inline void delay(NSTimeInterval delay, dispatch_block_t block) {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
//}

extern NSString *const kNotificationUserLogin;
extern NSString *const kNotificationUserLogout;
extern NSString *const kNotificationUserSignUp;

extern NSString *const kNotificationFeedAdded;

typedef void (^INSBooleanResultBlock)(BOOL succeeded, NSError *_Nullable error);

