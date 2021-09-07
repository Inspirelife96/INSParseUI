//
//  INSParseQueryManager+Feed.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager+Feed.h"

#import "INSParseTableDefines.h"
#import "INSFeed.h"
#import "INSLike.h"
#import "INSActivity.h"

#import "INSParseQueryManager+Activity.h"

@implementation INSParseQueryManager (Feed)

+ (nonnull NSArray *)queryFeedWithCategory:(NSNumber *)category followFromUser:(PFUser *)fromUser orderBy:(nonnull NSString *)orderBy page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    
    // 查询fromUser关注的用户，原则上讲，这个数目不会太多。
    PFQuery *followQuery = [PFQuery queryWithClassName:kFollowClassKey];
    [followQuery whereKey:kFollowFromUser equalTo:fromUser];

    // 查询公开的Feed，且创建者是fromUser关注的人
    PFQuery *query = [PFQuery queryWithClassName:kFeedClassKey];
    [query whereKey:kCategory equalTo:category];
    [query whereKey:kStatus equalTo:@1];
    [query whereKey:kFeedFromUser matchesKey:kFollowToUser inQuery:followQuery];
    
    return [INSParseQueryManager _excuteFeedQuery:query orderBy:orderBy page:page pageCount:pageCount error:error];
}

+ (nonnull NSArray *)queryFeedWithCategory:(NSNumber *)category likeFromUser:(PFUser *)fromUser page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    
    PFQuery *query = [PFQuery queryWithClassName:kLikeClassKey];
    [query whereKey:kCategory equalTo:category];
    [query whereKey:kLikeFromUser equalTo:fromUser];

    [query orderByDescending:kCreatedAt];

    [query includeKey:kLikeToFeed];
    [query setSkip:pageCount * page];
    [query setLimit:pageCount];

    NSArray *likeArray = [query findObjects:error];
    
    if (*error) {
        return @[];
    } else {
        NSMutableArray *feedArray = [[NSMutableArray alloc] init];
        
        [likeArray enumerateObjectsUsingBlock:^(INSLike *  _Nonnull like, NSUInteger idx, BOOL * _Nonnull stop) {
            [feedArray addObject:like.toFeed];
        }];
        
        return [feedArray copy];
    }
}

+ (nonnull NSArray *)queryFeedWithCategory:(NSNumber *)category tag:(nonnull NSString *)tag fromUser:(PFUser *)fromUser orderBy:(nonnull NSString *)orderBy page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    
    // 默认查找公开的Feed
    PFQuery *publicFeedsQuery = [INSParseQueryManager _prepareFeedQueryCategory:category tag:tag fromUser:fromUser];
    [publicFeedsQuery whereKey:kStatus equalTo:@(1)];
    
    PFQuery *query = publicFeedsQuery;
    
    // 登录状态下，同时查找当前用户的非公有Feed
    if ([PFUser currentUser]) {
        PFQuery *privateFeedsQuery = [INSParseQueryManager _prepareFeedQueryCategory:category tag:tag fromUser:fromUser];
        [privateFeedsQuery whereKey:kStatus notEqualTo:@(1)];
        [privateFeedsQuery whereKey:kFeedFromUser equalTo:[PFUser currentUser]];
        
        query = [PFQuery orQueryWithSubqueries:@[publicFeedsQuery, privateFeedsQuery]];
    }
    
    return [INSParseQueryManager _excuteFeedQuery:query orderBy:orderBy page:page pageCount:pageCount error:error];
}

+ (nonnull NSArray<INSFeed *> *)queryFeedWithStatus:(nonnull NSNumber *)status orderBy:(nonnull NSString *)orderBy page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    PFQuery *query = [PFQuery queryWithClassName:kLikeClassKey];
    [query whereKey:kStatus equalTo:status];
    
    return [INSParseQueryManager _excuteFeedQuery:query orderBy:orderBy page:page pageCount:pageCount error:error];
}

+ (BOOL)addFeedWithStatus:(nonnull NSNumber *)status
                 category:(nonnull NSNumber *)category
                    title:(nonnull NSString *)title
                  content:(nonnull NSString *)content
            mediaContents:(nonnull NSArray<PFFileObject *> *)mediaContents
                 fromUser:(nonnull PFUser *)fromUser
               isOriginal:(BOOL)isOriginal
              forwardFrom:(nonnull NSString *)forwardFrom
             commentCount:(nonnull NSNumber *)commentCount
                likeCount:(nonnull NSNumber *)likeCount
               shareCount:(nonnull NSNumber *)shareCount
                     tags:(nonnull NSArray<NSString *> *)tags
                  extend1:(nonnull id)extend1
                  extend2:(nonnull id)extend2
                  extend3:(nonnull id)extend3
                  extend4:(nonnull id)extend4
                  extend5:(nonnull id)extend5
                  extend6:(nonnull id)extend6
                    error:(NSError **)error
{
    INSFeed *feed = [[INSFeed alloc] init];
    feed.status = status;
    feed.category = category;
    feed.title = title;
    feed.content = content;
    feed.mediaContents = mediaContents;
    feed.fromUser = fromUser;
    feed.isOriginal = isOriginal;
    feed.forwardFrom = forwardFrom;
    feed.commentCount = commentCount;
    feed.likeCount = likeCount;
    feed.shareCount = shareCount;
    feed.tags = tags;
    feed.extend1 = extend1;
    feed.extend2 = extend2;
    feed.extend3 = extend3;
    feed.extend4 = extend4;
    feed.extend5 = extend5;
    feed.extend6 = extend6;
    
    BOOL succeeded = [feed save:error];
    
    if (succeeded) {
        return [INSParseQueryManager addFeedActivity:feed error:error];
    } else {
        return NO;
    }
}

+ (BOOL)updateFeed:(nonnull INSFeed *)feed toStatus:(nonnull NSNumber *)status error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    
    NSAssert([PFUser currentUser], @"登录用户才能更新Feed");
    
    feed.status = status;
    BOOL succeeded = [feed save:error];
    if (succeeded) {
        return NO;
    } else {
        if ([status intValue] == INSParseRecordStatusPublic) {
            return [INSParseQueryManager publicFeedActivity:feed fromUser:[PFUser currentUser] error:error];
        } else if ([status intValue] == INSParseRecordStatusBanned) {
            return [INSParseQueryManager banFeedActivity:feed fromUser:[PFUser currentUser] error:error];
        } else {
            return YES;
        }
    }
}

#pragma mark Private Methods

+ (NSArray *)_excuteFeedQuery:(PFQuery *)query orderBy:(nonnull NSString *)orderBy page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError *__autoreleasing  _Nullable * _Nullable)error {
    [query orderByDescending:orderBy];
    
    [query setSkip:pageCount * page];
    [query setLimit:pageCount];
    
    return [query findObjects:error];
}

+ (PFQuery *)_prepareFeedQueryCategory:(NSNumber *)category tag:(nonnull NSString *)tag fromUser:(PFUser *)fromUser {
    PFQuery *query = [PFQuery queryWithClassName:kFeedClassKey];
    
    // 如果有指定板块，添加板块的条件
    if ([category intValue] != -1) {
        [query whereKey:kCategory equalTo:category];
    }
    
    // 如果有指定tag，添加tag条件
    if (tag && ![tag isEqualToString:@""]) {
        [query whereKey:kFeedTags equalTo:tag];
    }
    
    // 如果有指定fromUser，添加fromUser条件
    if (fromUser) {
        [query whereKey:kFeedFromUser equalTo:fromUser];
    }
    
    return query;
}

@end
