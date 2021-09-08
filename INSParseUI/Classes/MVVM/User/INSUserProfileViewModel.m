//
//  INSUserProfileViewModel.m
//  Bolts
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import "INSUserProfileViewModel.h"

#import "INSFollowInfo.h"

@implementation INSUserProfileViewModel

- (instancetype)init {
    if (self = [super init]) {
        _user = nil;
        _userName = @"未登录";
        _followCount = 0;
        _followedCount = 0;
        _profileImageLink = @"user_profile_icon";
        _backgroundImageLink = [NSString stringWithFormat:@"user_profile_background%ld", (NSInteger)arc4random()%6];
        _isFollowedByCurrentUser = NO;
    }
    
    return  self;
}

- (instancetype)initWithUser:(PFUser *)user withBlock:(INSBooleanResultBlock)block {
    NSAssert(user, @"userObject shouldn't be nil!");

    if (self = [self init]) {

        _user = user;
        
        _userName = self.user.username;
        
        PFFileObject *profileImage = [user objectForKey:@"profileImage"];
        if (profileImage) {
            self.profileImageLink = profileImage.url;
        }
        
        PFFileObject *backgroundImage = [user objectForKey:@"backgroundImage"];
        if (backgroundImage) {
            self.backgroundImageLink = backgroundImage.url;
        }
        
        WEAKSELF
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            STRONGSELF
            
            NSError *error = nil;
            BOOL succeeded = YES;
            
            INSFollowInfo *followInfo = [strongSelf.user objectForKey:@"followInfo"];
            [followInfo fetch:&error];
            if (!error) {
                strongSelf.followCount = [followInfo.followCount integerValue];
                strongSelf.followedCount = [followInfo.followedCount integerValue];
            } else {
                succeeded = NO;
            }
            
            if ([PFUser currentUser]) {
                BOOL isFollowedByCurrentUser = [INSParseQueryManager isFollowFromUser:[PFUser currentUser] toUser:strongSelf.user error:&error];
                
                if (!error) {
                    strongSelf.isFollowedByCurrentUser = isFollowedByCurrentUser;
                } else {
                    succeeded = NO;
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                block(succeeded, error);
            });
        });
    }
    
    return  self;
}

- (void)changeFollowedByCurrentUserStatus:(INSBooleanResultBlock)block {
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        STRONGSELF
        NSError *error = nil;
        BOOL succeeded = YES;
        
        if (self.isFollowedByCurrentUser) {
            succeeded = [INSParseQueryManager deleteFollowFromUser:[PFUser currentUser] toUser:strongSelf.user error:&error];
            
            if (succeeded) {
                strongSelf.isFollowedByCurrentUser = NO;
                strongSelf.followedCount -= 1;
            }
        } else {
            succeeded = [INSParseQueryManager addFollowFromUser:[PFUser currentUser] toUser:strongSelf.user error:&error];
            
            if (succeeded) {
                strongSelf.isFollowedByCurrentUser = YES;
                strongSelf.followedCount++;
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(succeeded, error);
        });
    });
}

- (void)logout:(void(^)(void))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [INSParseQueryManager logOut];

        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLogout object:nil];
            block();
        });
    });
}

- (void)unsubscribe:(void(^)(void))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        [INSParseQueryManager unsubscribe:&error];

        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLogout object:nil];
            block();
        });
    });
}
@end
