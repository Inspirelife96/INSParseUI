//
//  INSCommentQueryViewModel.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import "INSQueryViewModel.h"

#import "INSParseUIConstants.h"

@class INSFeed;

NS_ASSUME_NONNULL_BEGIN

@interface INSCommentQueryViewModel : INSQueryViewModel

- (instancetype)initWithFeed:(INSFeed *)feed;

- (void)addComment:(NSString *)content withBlock:(INSBooleanResultBlock)block;

@end

NS_ASSUME_NONNULL_END
