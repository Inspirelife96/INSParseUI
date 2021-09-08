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
#import "INSArticle.h"

#import "INSParseQueryManager+Activity.h"

@implementation INSParseQueryManager (Feed)

+ (NSArray<INSFeed *> *)queryFeedWithCategory:(NSNumber * _Nullable)category
                                          tag:(NSString * _Nullable)tag
                                     fromUser:(PFUser * _Nullable)fromUser
                                      orderBy:(NSString * _Nullable)orderBy
                                         page:(NSUInteger)page
                                    pageCount:(NSUInteger)pageCount
                                        error:(NSError **)error
{
    PFQuery *publicFeedsQuery = [PFQuery queryWithClassName:kFeedClassKey];

    [publicFeedsQuery whereKey:kStatus equalTo:@(INSParseRecordStatusPublic)];
    
    if (category) {
        [publicFeedsQuery whereKey:kCategory equalTo:category];
    }
    
    if (tag) {
        [publicFeedsQuery whereKey:kFeedTags equalTo:tag];
    }
    
    if (fromUser) {
        [publicFeedsQuery whereKey:kFeedFromUser equalTo:fromUser];
    }
    
    PFQuery *query = publicFeedsQuery;
    
    if ([PFUser currentUser]) {
        // 登录状态，删除黑名单关联的内容
        PFQuery *blockQuery = [PFQuery queryWithClassName:kBlockClassKey];
        [blockQuery whereKey:kBlockFromUser equalTo:[PFUser currentUser]];
        [publicFeedsQuery whereKey:kFeedFromUser doesNotMatchKey:kBlockToUser inQuery:blockQuery];
        
        // 登录状态，如果没有设置fromUser或者fromUser == [PFUser currentUser]
        // 那么追加自己的符合条件的其他状态下（Block或者Private）的Feeds
        if (!fromUser || [fromUser.objectId isEqualToString:[PFUser currentUser].objectId]) {
            PFQuery *selfOwnedFeedsQuery = [PFQuery queryWithClassName:kFeedClassKey];
            
            [selfOwnedFeedsQuery whereKey:kFeedFromUser equalTo:[PFUser currentUser]];
            
            if (category) {
                [selfOwnedFeedsQuery whereKey:kCategory equalTo:category];
            }
            
            if (tag) {
                [selfOwnedFeedsQuery whereKey:kFeedTags equalTo:tag];
            }
            
            query = [PFQuery orQueryWithSubqueries:@[publicFeedsQuery, selfOwnedFeedsQuery]];
        }
    }
    
    return [INSParseQueryManager _excuteFeedQuery:query orderBy:orderBy page:page pageCount:pageCount error:error];
}

+ (NSArray<INSFeed *> *)queryFeedWithCategory:(NSNumber * _Nullable)category
                                 likeFromUser:(PFUser *)fromUser
                                         page:(NSInteger)page
                                    pageCount:(NSInteger)pageCount
                                        error:(NSError **)error
{
    PFQuery *query = [PFQuery queryWithClassName:kLikeClassKey];
    
    [query whereKey:kLikeType equalTo:@(INSParseLikeTypeFeed)];

    if (category) {
        [query whereKey:kCategory equalTo:category];
    }

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

+ (NSArray<INSFeed *> *)queryFeedWithCategory:(NSNumber * _Nullable)category
                               followFromUser:(PFUser *)fromUser
                                      orderBy:(NSString *)orderBy
                                         page:(NSInteger)page
                                    pageCount:(NSInteger)pageCount
                                        error:(NSError **)error
{
    // 查询fromUser关注的用户，原则上讲，这个数目不会太多。
    PFQuery *followQuery = [PFQuery queryWithClassName:kFollowClassKey];
    [followQuery whereKey:kFollowFromUser equalTo:fromUser];

    // 查询公开的Feed，且创建者是fromUser关注的人
    PFQuery *query = [PFQuery queryWithClassName:kFeedClassKey];
    [query whereKey:kStatus equalTo:@(INSParseRecordStatusPublic)];

    if (category) {
        [query whereKey:kCategory equalTo:category];
    }
    
    [query whereKey:kFeedFromUser matchesKey:kFollowToUser inQuery:followQuery];
    
    return [INSParseQueryManager _excuteFeedQuery:query orderBy:orderBy page:page pageCount:pageCount error:error];
}


+ (NSArray<INSFeed *> *)queryFeedWithStatus:(NSNumber *)status
                                    orderBy:(NSString *)orderBy
                                       page:(NSInteger)page
                                  pageCount:(NSInteger)pageCount
                                      error:(NSError **)error
{
    PFQuery *query = [PFQuery queryWithClassName:kFeedClassKey];
    [query whereKey:kStatus equalTo:status];
    
    return [INSParseQueryManager _excuteFeedQuery:query orderBy:orderBy page:page pageCount:pageCount error:error];
}


+ (BOOL)addFeedWithStatus:(NSNumber *)status
                 category:(NSNumber *)category
                    title:(NSString *)title
                  content:(NSString *)content
            mediaContents:(NSArray<PFFileObject *> *)mediaContents
                 fromUser:(PFUser *)fromUser
               isOriginal:(BOOL)isOriginal
              forwardFrom:(INSFeed *__nullable)forwardFrom
             commentCount:(NSNumber *)commentCount
                likeCount:(NSNumber *)likeCount
               shareCount:(NSNumber *)shareCount
                     tags:(NSArray<NSString *> *)tags
                  article:(INSArticle *__nullable)article
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
    
    if (forwardFrom != nil) {
        feed.forwardFrom = forwardFrom;
    }
    
    feed.commentCount = commentCount;
    feed.likeCount = likeCount;
    feed.shareCount = shareCount;
    feed.tags = tags;

    if (article != nil) {
        feed.article = article;
    }
    
    BOOL succeeded = [feed save:error];
    
    if (succeeded) {
        return [INSParseQueryManager addFeedActivity:feed error:error];
    } else {
        return NO;
    }
}

+ (BOOL)updateFeed:(INSFeed *)feed toStatus:(NSNumber *)status error:(NSError **)error {
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

+ (NSArray *)_excuteFeedQuery:(PFQuery *)query orderBy:(nonnull NSString *)orderBy page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError **)error {
    [query orderByDescending:orderBy];
    
    [query setSkip:pageCount * page];
    [query setLimit:pageCount];
    
    return [query findObjects:error];
}

@end
