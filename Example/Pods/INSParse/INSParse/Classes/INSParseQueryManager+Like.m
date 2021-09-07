//
//  INSParseQueryManager+Like.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager+Like.h"

#import "INSParseTableDefines.h"
#import "INSLike.h"
#import "INSActivity.h"

#import "INSParseQueryManager+Activity.h"

@implementation INSParseQueryManager (Like)

+ (NSArray *)queryLikeToFeed:(INSFeed *)toFeed fromUser:(PFUser *)fromUser error:(NSError **)error {
    PFQuery *query = [PFQuery queryWithClassName:kLikeClassKey];
    
    if (toFeed) {
        [query whereKey:kLikeToFeed equalTo:toFeed];
    }
    
    if (fromUser) {
        [query whereKey:kLikeFromUser equalTo:fromUser];
    }
    
    [query orderByDescending:kCreatedAt];
    
    return [query findObjects:error];
}

+ (BOOL)isFeed:(INSFeed *)feed likedbyUser:(PFUser *)user error:(NSError **)error {
    NSArray *likeArray = [INSParseQueryManager queryLikeToFeed:feed fromUser:user error:error];
    
    if (*error) {
        return NO;
    } else {
        if (likeArray.count > 0) {
            return YES;
        } else {
            return NO;
        }
    }
}

+ (BOOL)addLikeWithCategory:(NSNumber *)category
                     toFeed:(INSFeed *)toFeed
                  toComment:(INSComment *)toComment
                   fromUser:(PFUser *)fromUser
                      error:(NSError **)error {
    BOOL succeeded = [INSParseQueryManager isFeed:toFeed likedbyUser:fromUser error:error];
    
    if (*error) {
        return NO;
    } else {
        if (succeeded) {
            return YES;
        } else {
            INSLike *like = [[INSLike alloc] init];
            like.category = category;
            like.toFeed = toFeed;
            like.toComment = toComment;
            like.fromUser = fromUser;
            
            succeeded = [like save:error];
            
            if (succeeded) {
                return [INSParseQueryManager addLikeActivity:like error:error];
            } else {
                return NO;
            }
        }
    }
}

+ (BOOL)deleteLike:(INSLike *)like error:(NSError **)error {
    BOOL succeeded = [INSParseQueryManager deleteLikeActivity:like error:error];
    
    if (succeeded) {
        return [like delete:error];
    } else {
        return NO;
    }
}

+ (BOOL)deleteLikeToFeed:(INSFeed *)toFeed fromUser:(PFUser *)fromUser error:(NSError **)error {
    NSArray *likeArray = [INSParseQueryManager queryLikeToFeed:toFeed fromUser:fromUser error:error];
    if (*error) {
        return NO;
    } else {
        // 理论上应该只找到一条记录
        if (likeArray.count > 0) {
            // 删除所有
            for (NSInteger i = 0; i < likeArray.count; i++) {
                INSLike *like = likeArray[i];
                BOOL succeeded = [INSParseQueryManager deleteLike:like error:error];
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

@end
