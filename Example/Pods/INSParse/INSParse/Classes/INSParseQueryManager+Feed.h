//
//  INSParseQueryManager+Feed.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager.h"

@class INSFeed;
@class INSArticle;

NS_ASSUME_NONNULL_BEGIN

@interface INSParseQueryManager (Feed)

// Feed表查询

// 最常见的查询,大概的需求有下面几种
// 1 分类查询 (板块的概念)，例如查询某一个板块的所有Feed
// 2 根据Tag (标签的概念)，例如查询某一个Tag的所有Feed
// 3 根据发布者，例如查询有XX用户发布的所有Feed
// 4 根据赞，例如查询XX用户赞过的所有Feed
// 5 根据关注，例如查询XX用户关注的用户发布的所有Feed

// 由于Feed存在Status，即私有/公开/锁定，1/2/3需要返回公开以及当前用户非公开的Feed
// 4 其实查询的是Like表，由于不能Like其他人的私有Feed，所以返回Like表内关联的Feed即可，无需关心关联的Feed的Status。
// 5 由于自己不能关注自己，所以仅需要返回公开的Feed

// 由于黑名单的存在，对于登录用户，我们需要考虑：
// 不返回黑名单用户创建的Feed

// 排序
// 分为安时间排序，或者热度排序（评论数，点赞数，分享数）

// 页数，每页记录数

// 出错处理

/**
 通用查询

 根据输入的条件进行查询
 默认条件：
 1. 返回公开的Feed
 2. 登录状态下，不返回当前用户黑名单列表内用户创建的Feed
 3. 登录状态下，返回当前用户的所有Feed（包括Banned和Private）

 @param category 分类/板块，可以为nil，nil情况下不设置该条件。
 @param tag 标签，可以为nil，nil情况下不设置该条件。
 @param fromUser 创建人， 可以为nil，nil情况下不设置该条件。
 @param orderBy 排序，可以为nil，nil情况下默认以创建时间倒序为排序。
 @param page 第几页，必须设置为 > 0的整数
 @param pageCount 每页的记录数, 必须设置为 > 0的整数
 @param error 出错信息， 不可以nil
 
 @return 返回查询到的Feed列表，没有则返回空数组。
 */
+ (NSArray<INSFeed *> *)queryFeedWithCategory:(NSNumber * _Nullable)category
                                          tag:(NSString * _Nullable)tag
                                     fromUser:(PFUser * _Nullable)fromUser
                                      orderBy:(NSString * _Nullable)orderBy
                                         page:(NSUInteger)page
                                    pageCount:(NSUInteger)pageCount
                                        error:(NSError **)error;

/**
 查询XX用户喜欢的Feeds

 这个API会从Like表中进行查询，此时我们不考虑黑名单和Banned的情况了。
 暂时的方案是：如果喜欢的内容由黑名单用户发布，那么继续展示，并由用户自己来进行后续的操作。
 如果是Banned的Feed，应该显示Banned标记，并提示用户

 @param category 分类/板块，可以为nil，nil情况下不设置该条件。
 @param fromUser XX用户
 @param page 第几页，必须设置为 > 0的整数
 @param pageCount 每页的记录数, 必须设置为 > 0的整数
 @param error 出错信息， 不可以nil
 
 @return 返回查询到的Feed列表，没有则返回空数组。
 */
+ (NSArray<INSFeed *> *)queryFeedWithCategory:(NSNumber * _Nullable)category
                                 likeFromUser:(PFUser *)fromUser
                                         page:(NSInteger)page
                                    pageCount:(NSInteger)pageCount
                                        error:(NSError **)error;

/**
 查询XX用户关注的用户发布的Feeds

 默认条件：
 返回公开的Feed
 黑名单和关注是冲突的，所以不需要考虑黑名单
 自己不能关注自己，所以也不需要考虑自己的非公开的Feed

 @param category 分类/板块，可以为nil，nil情况下不设置该条件。
 @param fromUser XX用户
 @param orderBy 排序
 @param page 第几页，必须设置为 > 0的整数
 @param pageCount 每页的记录数, 必须设置为 > 0的整数
 @param error 出错信息， 不可以nil
 
 @return 返回查询到的Feed列表，没有则返回空数组。
 */
+ (NSArray<INSFeed *> *)queryFeedWithCategory:(NSNumber * _Nullable)category
                               followFromUser:(PFUser *)fromUser
                                      orderBy:(NSString *)orderBy
                                         page:(NSInteger)page
                                    pageCount:(NSInteger)pageCount
                                        error:(NSError **)error;

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
                 fromUser:(PFUser *)fromUser
               isOriginal:(BOOL)isOriginal
              forwardFrom:(INSFeed *__nullable)forwardFrom
             commentCount:(NSNumber *)commentCount
                likeCount:(NSNumber *)likeCount
               shareCount:(NSNumber *)shareCount
                     tags:(NSArray<NSString *> *)tags
                  article:(INSArticle *__nullable)article
                    error:(NSError **)error;

// Feed表更新
// 原则上发布之后不允许更新了，仅允许管理员更新下状态
+ (BOOL)updateFeed:(INSFeed *)feed toStatus:(NSNumber *)status error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
