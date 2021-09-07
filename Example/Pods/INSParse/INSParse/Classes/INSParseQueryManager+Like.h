//
//  INSParseQueryManager+Like.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager.h"

@class INSFeed;
@class INSLike;
@class INSComment;

NS_ASSUME_NONNULL_BEGIN

@interface INSParseQueryManager (Like)

// Like表查询
// 通常用例有
// - 查询某一个Feed喜欢的所有用户
// - 查询XX用户喜欢的所有Feed
// - 查询XX是否喜欢Feed
// 目前不支持喜欢Comment，所以Comment相关的操作暂时不定义了。

+ (NSArray *)queryLikeToFeed:(INSFeed *)toFeed fromUser:(PFUser *)fromUser error:(NSError **)error;

// 先判断Error，执行是否成功，再判断返回着，判断是否是否喜欢
+ (BOOL)isFeed:(INSFeed *)feed likedbyUser:(PFUser *)user error:(NSError **)error;

// Like表添加

+ (BOOL)addLikeWithCategory:(NSNumber *)category
                     toFeed:(INSFeed *)toFeed
                  toComment:(INSComment *)toComment
                   fromUser:(PFUser *)fromUser
                      error:(NSError **)error;


// Like表删除
+ (BOOL)deleteLike:(INSLike *)like error:(NSError **)error;
+ (BOOL)deleteLikeToFeed:(INSFeed *)toFeed fromUser:(PFUser *)fromUser error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
