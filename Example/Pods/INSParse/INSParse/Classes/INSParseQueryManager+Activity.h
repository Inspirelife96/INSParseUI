//
//  INSParseQueryManager+Activity.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager.h"

@class INSFeed;
@class INSComment;
@class INSLike;
@class INSShare;
@class INSFollow;

NS_ASSUME_NONNULL_BEGIN

@interface INSParseQueryManager (Activity)

// Activity表查询
// 通常用例有
// - 查询XX用户的所有（或某一类型的）Activity，这个可以用作类似朋友圈的所有消息，或者XX的足迹
// - 查询XX用户接受到的消息，可以用作消息列表

+ (NSArray *)queryActivityFromUser:(PFUser *)fromUser toUser:(PFUser *)toUser type:(NSString *)type page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError **)error;

// 添加
+ (BOOL)addFeedActivity:(INSFeed *)feed error:(NSError **)error;

+ (BOOL)addCommentActivity:(INSComment *)comment error:(NSError **)error;

+ (BOOL)addLikeActivity:(INSLike *)like error:(NSError **)error;

+ (BOOL)addShareActivity:(INSShare *)share error:(NSError **)error;

+ (BOOL)addFollowActivity:(INSFollow *)follow error:(NSError **)error;

// 删除
// 当用户删除评论/赞/关注时，对应的Activity也需要被删除，Feed/Share无法撤回。
// 警告：对于添加操作，例如XX用户添加了一条评论，此时Activity先会插入一条记录，是没有疑问的。
// 但是对于删除操作，例如XX用户删除了一条评论，此时Activity有两种做法，一种是删除先前添加的Activity记录，还有一种做法是插入一条删除评论的Activity记录。
// 目前还是采用了前者。
+ (BOOL)deleteCommentActivity:(INSComment *)comment error:(NSError **)error;

+ (BOOL)deleteLikeActivity:(INSLike *)comment error:(NSError **)error;

+ (BOOL)deleteFollowActivity:(INSFollow *)comment error:(NSError **)error;

// 更新
// Feed可以由管理员进行Public或者Ban
// 其实评论也可以被管理员进行Ban，但目前就不提供了
+ (BOOL)publicFeedActivity:(INSFeed *)feed fromUser:(PFUser *)fromUser error:(NSError **)error;

+ (BOOL)banFeedActivity:(INSFeed *)feed fromUser:(PFUser *)fromUser error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
