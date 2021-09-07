//
//  INSCommentViewModel.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import "INSObjectViewModel.h"

#import <INSParse/INSParse-umbrella.h>

#import "INSParseUIConstants.h"

@class INSFeedViewModel;
@class INSComment;
@class INSFeed;
@class PFUser;

NS_ASSUME_NONNULL_BEGIN

@interface INSCommentViewModel : INSObjectViewModel

// 持有
@property (nonatomic, strong) INSComment *comment;

// 需要Fetch的
@property (nonatomic, strong) INSFeed *toFeed;
@property (nonatomic, strong) INSComment *toComment;
@property (nonatomic, strong) PFUser *fromUser;

// Fetch之后需要VM化的
@property (nonatomic, strong) INSFeedViewModel *feedVM;
@property (nonatomic, strong) INSCommentViewModel *commentVM;

// UI展示相关
// 核心数据
@property (nonatomic, copy) NSString *content;

// 状态和时间：Feed的状态，发布者和发布时间
@property (nonatomic, copy) NSString *fromUserName;
@property (nonatomic, copy) NSString *postTimeInfo;

// 可否删除
@property (nonatomic, assign) BOOL isDeletable;

- (instancetype)initWithComment:(INSComment *)comment recurrenceIfToComment:(BOOL)recurrence error:(NSError **)error;

- (void)deleteCommentInBackgroundWithBlock:(INSBooleanResultBlock)block;
- (void)reportCommentForReasonInBackground:(INSParseReportReason)reason withBlock:(INSBooleanResultBlock)block;

@end

NS_ASSUME_NONNULL_END
