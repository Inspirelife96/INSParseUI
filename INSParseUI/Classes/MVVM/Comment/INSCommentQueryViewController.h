//
//  INSCommentQueryViewController.h
//  Bolts
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import "INSQueryViewController.h"

#import "CLBottomCommentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface INSCommentQueryViewController : INSQueryViewController <CLBottomCommentViewDelegate>

@property (nonatomic, strong) CLBottomCommentView *bottomCommentView;

@end

NS_ASSUME_NONNULL_END
