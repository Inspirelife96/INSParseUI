//
//  INSFeedCell.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import "INSObjectCell.h"

@class INSFeedCoreContentView;
@class INSFeedStatisticsView;
@class INSStatusView;

@class INSFeedViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSFeedCell : INSObjectCell

@property (nonatomic, strong) INSFeedCoreContentView *feedCoreContentView;
@property (nonatomic, strong) INSStatusView *statusView;
@property (nonatomic, strong) INSFeedStatisticsView *feedStatisticsView;

@property (nonatomic, assign) NSInteger mediaContentCount;

@property (nonatomic, strong) INSFeedViewModel *feedVM;

- (void)buildUI;

@end

NS_ASSUME_NONNULL_END
