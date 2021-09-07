//
//  INSFeedStatisticsView.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import <UIKit/UIKit.h>

#import "INSUserInteractionProtocol.h"

@class INSFeedViewModel;
@class INSStandardOperationButton;

NS_ASSUME_NONNULL_BEGIN

@interface INSFeedStatisticsView : UIView

@property (nonatomic, strong) INSStandardOperationButton *commentCountButton;
@property (nonatomic, strong) INSStandardOperationButton *likeCountButton;
@property (nonatomic, strong) INSStandardOperationButton *tagCountButton;
@property (nonatomic, strong) INSStandardOperationButton *shareCountButton;

@property (nonatomic, strong) INSFeedViewModel *feedVM;

//@property (nonatomic, strong) id interactionVM;
 
@property (nonatomic, weak) id<INSUserInteractionProtocol> delegate;

- (void)configWithFeedVM:(INSFeedViewModel *)feedVM;

- (CGFloat)estimatedHeight;

@end

NS_ASSUME_NONNULL_END
