//
//  INSFeedCoreContentView.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class INSFeedViewModel;

@interface INSFeedCoreContentView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *mediaContentsView;
@property (nonatomic, strong) NSMutableArray <UIButton *> *mediaContentButtonArray;

@property (nonatomic, weak) id delegate;

- (instancetype)initWithMediaContentCount:(NSInteger)mediaContentCount;

- (void)configWithFeedVM:(INSFeedViewModel *)feedVM;

- (CGFloat)estimatedHeight;

@end

NS_ASSUME_NONNULL_END
