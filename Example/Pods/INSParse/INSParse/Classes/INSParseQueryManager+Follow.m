//
//  INSParseQueryManager+Follow.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager+Follow.h"

#import "INSParseTableDefines.h"

#import "INSFollow.h"

#import "INSParseQueryManager+Activity.h"

@implementation INSParseQueryManager (Follow)

+ (BOOL)isFollowFromUser:(PFUser *)fromUser toUser:(PFUser *)toUser error:(NSError **)error {
    NSArray *followArray = [INSParseQueryManager _findFollowFromUser:fromUser toUser:toUser error:error];
    
    if (*error) {
        return NO;
    } else {
        if (followArray.count > 0) {
            return YES;
        } else {
            return NO;
        }
    }
}

// Follow表添加
+ (BOOL)addFollowFromUser:(PFUser *)fromUser toUser:(PFUser *)toUser error:(NSError **)error {
    BOOL isFollowed = [INSParseQueryManager isFollowFromUser:fromUser toUser:toUser error:error];
    
    if (*error) {
        return NO;
    } else {
        if (isFollowed) {
            return YES;
        } else {
            INSFollow *follow = [[INSFollow alloc] init];
            follow.fromUser = fromUser;
            follow.toUser = toUser;
            BOOL succeeded = [follow save:error];
            if (succeeded) {
                return [INSParseQueryManager addFollowActivity:follow error:error];
            } else {
                return NO;
            }
        }
    }
}

+ (BOOL)deleteFollow:(INSFollow *)follow error:(NSError **)error {
    BOOL succeeded = [INSParseQueryManager deleteFollowActivity:follow error:error];
    
    if (succeeded) {
        return [follow delete:error];
    } else {
        return NO;
    }
}

// Follow表删除
+ (BOOL)deleteFollowFromUser:(PFUser *)fromUser toUser:(PFUser *)toUser error:(NSError **)error {
    NSArray *followArray = [INSParseQueryManager _findFollowFromUser:fromUser toUser:toUser error:error];
    if (*error) {
        return NO;
    } else {
        // 理论上应该只找到一条记录
        if (followArray.count > 0) {
            // 删除所有
            for (NSInteger i = 0; i < followArray.count; i++) {
                INSFollow *follow = followArray[i];
                BOOL succeeded = [INSParseQueryManager deleteFollow:follow error:error];
                if (!succeeded) {
                    return NO;
                }
            }
            return YES;
        } else {
            return YES;//没找到，证明已经删除了
        }
    }
}


#pragma mark Private Methods

+ (NSArray *)_findFollowFromUser:(PFUser *)fromUser toUser:(PFUser *)toUser error:(NSError **)error {
    PFQuery *query = [PFQuery queryWithClassName:kFollowClassKey];
    [query whereKey:kFollowFromUser equalTo:fromUser];
    [query whereKey:kFollowToUser equalTo:toUser];
    
    return [query findObjects:error];
}

@end
