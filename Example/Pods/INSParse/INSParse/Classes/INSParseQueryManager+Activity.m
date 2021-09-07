//
//  INSParseQueryManager+Activity.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager+Activity.h"

#import "INSParseTableDefines.h"
#import "INSFeed.h"
#import "INSComment.h"
#import "INSLike.h"
#import "INSShare.h"
#import "INSFollow.h"
#import "INSActivity.h"

@implementation INSParseQueryManager (Activity)

+ (NSArray *)queryActivityFromUser:(PFUser *)fromUser toUser:(PFUser *)toUser type:(NSString *)type page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError **)error {
    PFQuery *query = [PFQuery queryWithClassName:kActivityClassKey];
    
    if (fromUser) {
        [query whereKey:kActivityFromUser equalTo:fromUser];
    }
    
    if (toUser) {
        [query whereKey:kActivityToUser equalTo:toUser];
    }
    
    if (type) {
        [query whereKey:kActivityType equalTo:type];
    }
    
    [query orderByDescending:kCreatedAt];
    
    [query setSkip:pageCount * page];
    [query setLimit:pageCount];
    
    return [query findObjects:error];
}

+ (BOOL)addFeedActivity:(INSFeed *)feed error:(NSError **)error {
    return [INSParseQueryManager _addFeedActivity:feed type:INSParseActivityTypeAddFeed fromUser:nil error:error];
}

+ (BOOL)publicFeedActivity:(INSFeed *)feed fromUser:(PFUser *)fromUser error:(NSError **)error {
    return [INSParseQueryManager _addFeedActivity:feed type:INSParseActivityTypePublicFeed fromUser:fromUser error:error];
}

+ (BOOL)banFeedActivity:(INSFeed *)feed fromUser:(PFUser *)fromUser error:(NSError **)error {
    return [INSParseQueryManager _addFeedActivity:feed type:INSParseActivityTypeBanFeed fromUser:fromUser error:error];
}

+ (BOOL)addCommentActivity:(INSComment *)comment error:(NSError **)error {
    INSActivity *activity = [[INSActivity alloc] init];
    
    activity.type = @(INSParseActivityTypeAddComment);
    activity.comment = comment;
    activity.fromUser = comment.fromUser;
    if (comment.toComment) {
        [comment.toComment fetchIfNeeded:error];
        if (*error) {
            return NO;
        } else {
            activity.toUser = comment.toComment.fromUser;
        }
    } else {
        [comment.toFeed fetchIfNeeded:error];
        if (*error) {
            return NO;
        } else {
            activity.toUser = comment.toFeed.fromUser;
        }
    }
    
    return [activity save:error];
}

+ (BOOL)addLikeActivity:(INSLike *)like error:(NSError **)error {
    INSActivity *activity = [[INSActivity alloc] init];
    
    activity.type = @(INSParseActivityTypeAddLike);
    activity.like = like;
    activity.fromUser = like.fromUser;

    [like.toFeed fetchIfNeeded:error];
    if (*error) {
        return NO;
    } else {
        activity.toUser = like.toFeed.fromUser;
    }
    return [activity save:error];
}

+ (BOOL)addShareActivity:(INSShare *)share error:(NSError **)error {
    INSActivity *activity = [[INSActivity alloc] init];
    
    activity.type = @(INSParseActivityTypeAddShare);
    activity.share = share;
    activity.fromUser = share.fromUser;

    [share.feed fetchIfNeeded:error];
    if (*error) {
        return NO;
    } else {
        activity.toUser = share.feed.fromUser;
    }
    return [activity save:error];
}

+ (BOOL)addFollowActivity:(INSFollow *)follow error:(NSError **)error {
    INSActivity *activity = [[INSActivity alloc] init];
    
    activity.type = @(INSParseActivityTypeAddFollow);
    activity.fromUser = follow.fromUser;
    activity.toUser = follow.toUser;

    return [activity save:error];
}

+ (BOOL)deleteCommentActivity:(INSComment *)comment error:(NSError **)error {
    return [INSParseQueryManager _deleteActivityWhereKey:kActivityComment equalTo:comment error:error];
}

+ (BOOL)deleteLikeActivity:(INSLike *)like error:(NSError **)error {
    return [INSParseQueryManager _deleteActivityWhereKey:kActivityLike equalTo:like error:error];
}

+ (BOOL)deleteFollowActivity:(INSFollow *)follow error:(NSError **)error {
    return [INSParseQueryManager _deleteActivityWhereKey:kActivityFollow equalTo:follow error:error];
}

#pragma mark Private Methods

+ (BOOL)_addFeedActivity:(INSFeed *)feed type:(NSInteger)type fromUser:(PFUser *)fromUser error:(NSError **)error {
    INSActivity *activity = [[INSActivity alloc] init];
    
    activity.type = @(type);
    activity.feed = feed;
    
    if (fromUser) {
        activity.fromUser = fromUser;
    } else {
        activity.fromUser = feed.fromUser;
    }
    
    activity.toUser = feed.fromUser;

    return [activity save:error];
}

+ (BOOL)_deleteActivityWhereKey:(NSString *)key equalTo:(id)object error:(NSError **)error {
    PFQuery *query = [PFQuery queryWithClassName:kActivityClassKey];
    [query whereKey:key equalTo:object];
    
    NSArray *activityArray = [query findObjects:error];
    
    if (*error) {
        return NO;
    }
    
    for (NSInteger i = 0; i < activityArray.count; i++) {
        INSActivity *activity = activityArray[i];
        BOOL succeeded = [activity delete:error];
        if (!succeeded) {
            return NO;
        }
    }

    return YES;
}

@end
