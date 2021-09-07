//
//  INSActivityViewModel.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/6.
//

#import "INSObjectViewModel.h"

@class INSActivity;
@class INSFeedViewModel;
@class INSCommentViewModel;
@class INSLikeViewModel;
@class INSShareViewModel;
@class INSFollowViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSActivityViewModel : INSObjectViewModel

@property (nonatomic, strong) INSActivity *activity;

@property (nonatomic, strong) PFUser *fromUser;
@property (nonatomic, strong) NSNumber *type;

@property (nonatomic, strong) NSString *fromUserName;

@property (nonatomic, strong) INSFeedViewModel *feedVM;
@property (nonatomic, strong) INSCommentViewModel *commentVM;
@property (nonatomic, strong) INSLikeViewModel *likeVM;
@property (nonatomic, strong) INSShareViewModel *shareVM;
@property (nonatomic, strong) INSFollowViewModel *followVM;

- (instancetype)initWithActivity:(INSActivity *)activity error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
