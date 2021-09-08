//
//  INSFeedViewModel.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSObjectViewModel.h"


#import "INSParseUIConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface INSFeedViewModel : INSObjectViewModel

// 继续持有
@property (nonatomic, strong) INSFeed *feed;

// 需要Fetch的
@property (nonatomic, strong) PFUser *fromUser;

// UI展示相关
// 核心数据： 标题，内容和图片
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSArray<NSString *> *mediaContentUrlStringArray;

// 统计数据：评论数，赞数，分享数
@property (nonatomic, assign) NSInteger commentCount;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, assign) NSInteger shareCount;

// 状态和时间：Feed的状态，发布者和发布时间
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy) NSString *postTimeInfo;
@property (nonatomic, copy) NSString *fromUserName;

// 辅助数据, 标签及标签数
@property (nonatomic, assign) NSInteger tagCount;
@property (nonatomic, strong) NSArray<NSString *> *tags;

// 个性化数据，如果登录状态下，查看当前用户是否赞了这个Feed
@property (nonatomic, assign) BOOL isLikedByCurrentUser;

// 初始化，核心的操作，由于有Fetch的存在，可能发生错误
// 目前没有放入异步线程中，所以请勿在主线程中调用，建议和Query一起放在异步线程中调用。
- (instancetype)initWithFeed:(INSFeed *)feed error:(NSError **)error;

// 包括Like/UnLike，根据当前的isLikedByCurrentUser进行取反
- (void)likeFeedInBackgroundWithBlock:(INSBooleanResultBlock)block;

- (void)shareFeedToPlatformInBackgound:(NSString *)toPlatform withBlock:(INSBooleanResultBlock)block;

- (void)publicFeedInBackgroundWithBlock:(INSBooleanResultBlock)block;

- (void)banFeedInBackgroundWithBlock:(INSBooleanResultBlock)block;

- (void)reportFeedForReasonInBackground:(INSParseReportReason)reason withBlock:(INSBooleanResultBlock)block;

@end

NS_ASSUME_NONNULL_END
