//
//  INSParseQueryManager+Feed.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager.h"

@class INSFeed;

NS_ASSUME_NONNULL_BEGIN

@interface INSParseQueryManager (Feed)

// Feed表查询

// 最常见的查询,大概的需求有下面几种
// 1 分类查询 (板块的概念)，例如查询某一个板块的所有Feed
// 2 根据Tag (标签的概念)，例如查询某一个Tag的所有Feed
// 3 根据发布者，例如查询有XX用户发布的所有Feed
// 4 根据赞，例如查询XX用户赞过的所有Feed
// 5 根据关注，例如查询XX用户关注的用户发布的所有Feed

// 由于Feed存在Status，即私有/公开/删除，1/2/3需要返回公开以及当前用户非公开的Feed
// 4 其实查询的是Like表，由于不能Like其他人的私有Feed，所以返回Like表内关联的Feed即可，无需关心关联的Feed的Status。
// 5 由于自己不能关注自己，所以仅需要返回公开的Feed

// 排序
// 分为安时间排序，或者热度排序（评论数，点赞数，分享数）

// 页数，每页记录数

// 出错处理

+ (NSArray<INSFeed *> *)queryFeedWithCategory:(NSNumber *)category tag:(NSString *)tag fromUser:(PFUser *)fromUser orderBy:(NSString *)orderBy page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError **)error;

+ (NSArray<INSFeed *> *)queryFeedWithCategory:(NSNumber *)category likeFromUser:(PFUser *)fromUser page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError **)error;

+ (NSArray<INSFeed *> *)queryFeedWithCategory:(NSNumber *)category followFromUser:(PFUser *)fromUser orderBy:(NSString *)orderBy page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError **)error;

// 特殊，管理专用，一般用来查询需要审核的文章
+ (NSArray<INSFeed *> *)queryFeedWithStatus:(NSNumber *)status
                                    orderBy:(NSString *)orderBy
                                       page:(NSInteger)page
                                  pageCount:(NSInteger)pageCount
                                      error:(NSError **)error;

// Feed表增加
+ (BOOL)addFeedWithStatus:(NSNumber *)status
                 category:(NSNumber *)category
                    title:(NSString *)title
                  content:(NSString *)content
            mediaContents:(NSArray<PFFileObject *> *)mediaContents
                 fromUser:(PFUser *)fromUser isOriginal:(BOOL)isOriginal
              forwardFrom:(NSString *)forwardFrom
             commentCount:(NSNumber *)commentCount
                likeCount:(NSNumber *)likeCount
               shareCount:(NSNumber *)shareCount
                     tags:(NSArray<NSString *> *)tags
                  extend1:(id)extend1
                  extend2:(id)extend2
                  extend3:(id)extend3
                  extend4:(id)extend4
                  extend5:(id)extend5
                  extend6:(id)extend6
                    error:(NSError **)error;

// Feed表更新
// 原则上发布之后不允许更新了，仅允许管理员更新下状态
+ (BOOL)updateFeed:(INSFeed *)feed toStatus:(NSNumber *)status error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
