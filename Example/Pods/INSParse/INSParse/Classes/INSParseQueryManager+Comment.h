//
//  INSParseQueryManager+Comment.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager.h"

@class INSFeed;
@class INSComment;

NS_ASSUME_NONNULL_BEGIN

@interface INSParseQueryManager (Comment)

// Comment表查询
// 通常是两种用例
// - 查询某一个Feed的评论
// - 查询某人发表的评论

+ (NSArray *)queryCommentWithCategory:(NSNumber *)category toFeed:(INSFeed *)toFeed fromUser:(PFUser *)fromUser page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError **)error;


// Comment表增加
+ (BOOL)addCommentWithCategory:(NSNumber *)category
                        toFeed:(INSFeed *)toFeed
                     toComment:(INSComment *)toComment
                       content:(NSString *)content
                      fromUser:(PFUser *)fromUser
                         error:(NSError **)error;

// Comment表删除

+ (BOOL)deleteComment:(INSComment *)comment error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
