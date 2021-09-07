//
//  INSFeedViewModel.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSFeedViewModel.h"

#import <INSParse/INSParse-umbrella.h>

#import <JKCategories/NSDate+JKExtension.h>

#import <Parse/Parse.h>

@implementation INSFeedViewModel

- (instancetype)initWithFeed:(INSFeed *)feed error:(NSError **)error {
    if (self = [super init]) {
        _feed = feed;
        
        _fromUser = feed.fromUser;
        [_fromUser fetchIfNeeded:error];
        if (*error) {
            return nil;
        }
        
        _title = feed.title;
        _content = feed.content;
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        [self.feed.mediaContents enumerateObjectsUsingBlock:^(PFFileObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [mutableArray addObject:obj.url];
        }];
        _mediaContentUrlStringArray = [mutableArray copy];
        
        _commentCount = [feed.commentCount intValue];
        _likeCount = [feed.likeCount intValue];
        _shareCount = [feed.shareCount intValue];
        
        _tags = feed.tags;
        _tagCount = feed.tags.count;
        
        _status = feed.status;
        _postTimeInfo = [feed.createdAt jk_timeInfo];
        _fromUserName = _fromUser.username;
        
        if ([PFUser currentUser]) {
            _isLikedByCurrentUser = [INSParseQueryManager isFeed:feed likedbyUser:[PFUser currentUser] error:error];
            if (*error) {
                return nil;
            }
        } else {
            _isLikedByCurrentUser = NO;
        }
    }
    
    return self;
}


- (void)likeFeedInBackgroundWithBlock:(INSBooleanResultBlock)block {
    NSAssert([PFUser currentUser], @"likeFeedInBackgroundWithBlock shouldn't be called when [PFUser currentUser] is nil");
    
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        STRONGSELF
        NSError *error = nil;
        BOOL succeeded = YES;
        
        if (strongSelf.isLikedByCurrentUser) {
            succeeded = [INSParseQueryManager deleteLikeToFeed:strongSelf.feed fromUser:[PFUser currentUser] error:&error];
            if (succeeded) {
                strongSelf.isLikedByCurrentUser = NO;
                strongSelf.likeCount--;
            }
        } else {
            succeeded = [INSParseQueryManager addLikeWithCategory:strongSelf.feed.category toFeed:strongSelf.feed toComment:nil fromUser:[PFUser currentUser] error:&error];
            if (succeeded) {
                strongSelf.isLikedByCurrentUser = YES;
                strongSelf.likeCount++;
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(succeeded, error);
        });
    });
}

- (void)shareFeedToPlatformInBackgound:(NSString *)toPlatform withBlock:(INSBooleanResultBlock)block {
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        STRONGSELF
        NSError *error = nil;
        
        INSShare *share = [[INSShare alloc] init];
        share.feed = strongSelf.feed;
        share.category = strongSelf.feed.category;
        share.toPlatform = toPlatform;
        
        if ([PFUser currentUser]) {
            share.fromUser = [PFUser currentUser];
        }
        
        BOOL succeeded = [share save:&error];
        if (succeeded) {
            strongSelf.shareCount++;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(succeeded, error);
        });
    });
}

- (void)publicFeedInBackgroundWithBlock:(INSBooleanResultBlock)block {
    [self _updateFeedStatusInBackground:@(INSParseRecordStatusPublic) withBlock:^(BOOL succeeded, NSError * _Nullable error) {
        block(succeeded, error);
    }];
}

- (void)banFeedInBackgroundWithBlock:(INSBooleanResultBlock)block {
    [self _updateFeedStatusInBackground:@(INSParseRecordStatusBanned) withBlock:^(BOOL succeeded, NSError * _Nullable error) {
        block(succeeded, error);
    }];
}

- (void)_updateFeedStatusInBackground:(NSNumber *)status withBlock:(INSBooleanResultBlock)block {
    NSAssert([PFUser currentUser], @"_updateFeedStatusInBackground shouldn't be called when [PFUser currentUser] is nil");
    
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        STRONGSELF
        NSError *error = nil;
        
        BOOL succeeded = [INSParseQueryManager updateFeed:strongSelf.feed toStatus:status error:&error];
        if (succeeded) {
            strongSelf.status = status;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(succeeded, error);
        });
    });
}

- (void)reportFeedForReasonInBackground:(INSParseReportReason)reason withBlock:(INSBooleanResultBlock)block {
    NSAssert([PFUser currentUser], @"reportFeedForReasonInBackground shouldn't be called when [PFUser currentUser] is nil");
    
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        STRONGSELF
        NSError *error = nil;
        
        BOOL succeeded = [INSParseQueryManager addReportFromUser:[PFUser currentUser] feed:strongSelf.feed comment:nil reason:reason error:&error];

        dispatch_async(dispatch_get_main_queue(), ^{
            block(succeeded, error);
        });
    });
}

- (void)bindCellIdentifier:(NSArray<NSString *> *)registeredIdentifierArray {
    if (registeredIdentifierArray.count > 0) {
        NSString *cellIdentifier = registeredIdentifierArray[0];
        self.cellIdentifier = [NSString stringWithFormat:@"%@%ld", cellIdentifier, self.mediaContentUrlStringArray.count];
    }
}

@end
