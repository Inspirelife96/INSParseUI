//
//  INSCommentViewModel.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import "INSCommentViewModel.h"

#import <Parse/Parse.h>


#import "INSFeedViewModel.h"

#import <JKCategories/NSDate+JKExtension.h>

@implementation INSCommentViewModel

- (instancetype)initWithComment:(INSComment *)comment recurrenceIfToComment:(BOOL)recurrence error:(NSError **)error {
    if (self = [super init]) {
        _comment = comment;
        
        _toFeed = comment.toFeed;
        [_toFeed fetchIfNeeded:error];
        if (*error) {
            return nil;
        }
        
        _toComment = comment.toComment;
        [_toComment fetchIfNeeded:error];
        if (*error) {
            return nil;
        }

        _fromUser = comment.fromUser;
        [_fromUser fetchIfNeeded:error];
        if (*error) {
            return nil;
        }
        
        _feedVM = [[INSFeedViewModel alloc] initWithFeed:_toFeed error:error];
        if (*error) {
            return nil;
        }
        
        if (recurrence) {
            _commentVM = [[INSCommentViewModel alloc] initWithComment:_toComment recurrenceIfToComment:NO error:error];
            if (*error) {
                return nil;
            }
        }

        _content = comment.content;
        
        _fromUserName = _fromUser.username;
        _postTimeInfo = [comment.createdAt jk_timeInfo];
        
        if ([PFUser currentUser] && [[PFUser currentUser].objectId isEqualToString:_fromUser.objectId]) {
            _isDeletable = YES;
        } else {
            _isDeletable = NO;
        }
    }
    
    return self;
}

- (void)deleteCommentInBackgroundWithBlock:(INSBooleanResultBlock)block; {
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        STRONGSELF
        NSError *error = nil;
        
        BOOL succeeded = [INSParseQueryManager deleteComment:strongSelf.comment error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(succeeded, error);
        });
    });
}

- (void)reportCommentForReasonInBackground:(INSParseReportReason)reason withBlock:(INSBooleanResultBlock)block {
    NSAssert([PFUser currentUser], @"reportFeedForReasonInBackground shouldn't be called when [PFUser currentUser] is nil");
    
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        STRONGSELF
        NSError *error = nil;
        
        BOOL succeeded = [INSParseQueryManager addReportFromUser:[PFUser currentUser] feed:nil comment:strongSelf.comment reason:reason error:&error];

        dispatch_async(dispatch_get_main_queue(), ^{
            block(succeeded, error);
        });
    });
}

@end
