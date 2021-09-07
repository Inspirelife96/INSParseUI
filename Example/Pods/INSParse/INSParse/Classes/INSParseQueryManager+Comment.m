//
//  INSParseQueryManager+Comment.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager+Comment.h"

#import "INSParseTableDefines.h"
#import "INSComment.h"
#import "INSActivity.h"

#import "INSParseQueryManager+Activity.h"

@implementation INSParseQueryManager (Comment)

+ (NSArray *)queryCommentWithCategory:(NSNumber *)category toFeed:(INSFeed *)toFeed fromUser:(PFUser *)fromUser page:(NSInteger)page pageCount:(NSInteger)pageCount error:(NSError **)error {
    PFQuery *query = [PFQuery queryWithClassName:kCommentClassKey];
    
    if ([category intValue] != -1) {
        [query whereKey:kCategory equalTo:category];
    }
    
    if (toFeed) {
        [query whereKey:kCommentToFeed equalTo:toFeed];
    }
    
    if (fromUser) {
        [query whereKey:kCommentFromUser equalTo:fromUser];
    }
    
    // 评论内容目前不支持点赞，所以统一按时间倒序
    [query orderByDescending:kCreatedAt];
    
    [query setSkip:pageCount * page];
    [query setLimit:pageCount];
    
    return [query findObjects:error];
}

+ (BOOL)addCommentWithCategory:(NSNumber *)category
                        toFeed:(INSFeed *)toFeed
                     toComment:(INSComment *)toComment
                       content:(NSString *)content
                      fromUser:(PFUser *)fromUser
                         error:(NSError **)error {
    INSComment *comment = [[INSComment alloc] init];
    comment.category = category;
    comment.toFeed = toFeed;
    comment.toComment = toComment;
    comment.content = content;
    comment.fromUser = fromUser;
    
    BOOL succeeded = [comment save:error];
    
    if (succeeded) {
        return [INSParseQueryManager addCommentActivity:comment error:error];
    } else {
        return NO;
    }
}

+ (BOOL)deleteComment:(INSComment *)comment error:(NSError **)error {
    BOOL succeeded = [INSParseQueryManager deleteCommentActivity:comment error:error];
    
    if (succeeded) {
        return [comment delete:error];
    } else {
        return NO;
    }
}

@end
