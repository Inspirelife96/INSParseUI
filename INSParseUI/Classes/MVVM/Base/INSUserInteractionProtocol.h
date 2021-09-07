//
//  INSUserInteractionProtocol.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import <Foundation/Foundation.h>

@class INSFeed;


@class INSFeedViewModel;
@class INSCommentViewModel;

NS_ASSUME_NONNULL_BEGIN

@protocol INSUserInteractionProtocol <NSObject>

- (void)interactWithUser:(PFUser *)userObject;

- (void)clickFeedForwardFrom:(INSFeed *)feed;

- (void)commentFeed:(INSFeed *)feed;

- (void)likeFeed:(INSFeedViewModel *)feedVM;

- (void)tagFeed:(INSFeedViewModel *)feedVM;

- (void)shareFeed:(INSFeedViewModel *)feedVM;

- (void)reviewFeed:(INSFeedViewModel *)feedVM;

- (void)reportFeed:(INSFeedViewModel *)feedVM;

- (void)deleteComment:(INSCommentViewModel *)commentVM;

- (void)reportComment:(INSCommentViewModel *)commentVM;

- (void)popFeed:(INSFeedViewModel *)feedVM;

@end

NS_ASSUME_NONNULL_END
