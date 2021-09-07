//
//  INSLikeViewModel.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import "INSLikeViewModel.h"

@implementation INSLikeViewModel

- (instancetype)initWithLike:(INSLike *)like error:(NSError **)error {
    if (self = [super init]) {
        _like = like;
        
        _toFeed = like.toFeed;
        [_toFeed fetchIfNeeded:error];
        if (*error) {
            return nil;
        }
        
        _fromUser = like.fromUser;
        [_fromUser fetchIfNeeded:error];
        if (*error) {
            return nil;
        }
        
        _feedVM = [[INSFeedViewModel alloc] initWithFeed:_toFeed error:error];
        if (*error) {
            return nil;
        }

        _fromUserName = _fromUser.username;
    }
    
    return self;
}

@end
