//
//  INSCommentCell.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import "INSObjectCell.h"

@class INSStatusView;
@class INSCommentViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSCommentCell : INSObjectCell

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) INSStatusView *statusView;

@property (nonatomic, strong) INSCommentViewModel *commentVM;

@end

NS_ASSUME_NONNULL_END
