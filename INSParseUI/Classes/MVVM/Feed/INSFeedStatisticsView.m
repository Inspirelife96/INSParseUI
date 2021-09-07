//
//  INSFeedStatisticsView.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import "INSFeedStatisticsView.h"

#import "INSFeedViewModel.h"
#import "INSStandardOperationButton.h"
#import "INSSeperateLineView.h"

@interface INSFeedStatisticsView ()

@property (nonatomic, strong) INSSeperateLineView *seperateLineView1;
@property (nonatomic, strong) INSSeperateLineView *seperateLineView2;
@property (nonatomic, strong) INSSeperateLineView *seperateLineView3;

@end

@implementation INSFeedStatisticsView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self buildUI];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    //self.backgroundColor = [KQStyle backgroundColorForStatisticsView];
    
    [self addSubview:self.commentCountButton];
    [self addSubview:self.likeCountButton];
    [self addSubview:self.tagCountButton];
    [self addSubview:self.shareCountButton];
    [self addSubview:self.seperateLineView1];
    [self addSubview:self.seperateLineView2];
    [self addSubview:self.seperateLineView3];
    
    [self.commentCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self);
        make.width.mas_equalTo(self.mas_width).multipliedBy(1.0/4.0);
        make.height.mas_equalTo(21);
    }];
    
    [self.seperateLineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.commentCountButton.mas_right);
        make.width.mas_equalTo(0.5f);
        make.height.mas_equalTo(21);
    }];
    
    [self.likeCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.commentCountButton.mas_right);
        make.width.mas_equalTo(self.mas_width).multipliedBy(1.0/4.0);
        make.height.mas_equalTo(21);
    }];
    
    [self.seperateLineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.likeCountButton.mas_right);
        make.width.mas_equalTo(0.5f);
        make.height.mas_equalTo(21);
    }];
    
    [self.tagCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.likeCountButton.mas_right);
        make.width.mas_equalTo(self.mas_width).multipliedBy(1.0/4.0);
        make.height.mas_equalTo(21);
    }];
    
    [self.seperateLineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.tagCountButton.mas_right);
        make.width.mas_equalTo(0.5f);
        make.height.mas_equalTo(21);
    }];
    
    [self.shareCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.tagCountButton.mas_right);
        make.width.mas_equalTo(self.mas_width).multipliedBy(1.0/4.0);
        make.height.mas_equalTo(21);
    }];
}

- (void)configWithFeedVM:(INSFeedViewModel *)feedVM {
    _feedVM = feedVM;
    
    NSString *commentString = [NSString stringWithFormat:@"评论(%ld)", self.feedVM.commentCount];
    [self.commentCountButton setTitle:commentString forState:UIControlStateNormal];
    
    NSString *likeString = [NSString stringWithFormat:@"喜欢(%ld)", self.feedVM.likeCount];
    [self.likeCountButton setTitle:likeString forState:UIControlStateNormal];
    
    
    if (self.feedVM.isLikedByCurrentUser) {
        [self.likeCountButton setImage:[UIImage imageNamed:@"social_like_active"] forState:UIControlStateNormal];
    } else {
        [self.likeCountButton setImage:[UIImage imageNamed:@"social_like"] forState:UIControlStateNormal];
    }
    
    NSString *tagString = [NSString stringWithFormat:@"标签(%ld)", self.feedVM.tagCount];
    [self.tagCountButton setTitle:tagString forState:UIControlStateNormal];
    
    NSString *shareString = [NSString stringWithFormat:@"分享(%ld)", self.feedVM.shareCount];
    [self.shareCountButton setTitle:shareString forState:UIControlStateNormal];
}

- (void)clickCommentCountButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(commentFeed:)]) {
        [self.delegate commentFeed:self.feedVM.feed];
    }
}

- (void)clickLikeCountButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(likeFeed:)]) {
        [self.delegate likeFeed:self.feedVM.feed];
    }
}

- (void)clickTagCountButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tagFeed:)]) {
        [self.delegate tagFeed:self.feedVM.feed];
    }
}

- (void)clickShareCountButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareFeed:)]) {
        [self.delegate shareFeed:self.feedVM.feed];
    }
}

//- (UIButton *)_statisticsButton {
//    UIButton *button = [[UIButton alloc] init];
//
//    //button.titleLabel.font = [KQStyle fontSmall];
//    //[button setTitleColor:[KQStyle colorGrayDark] forState:UIControlStateNormal];
//    //[button jk_setImagePosition:LXMImagePositionLeft spacing:4.0f];
//
//    return button;
//}

- (INSStandardOperationButton *)commentCountButton {
    if (!_commentCountButton) {
        _commentCountButton = [[INSStandardOperationButton alloc] init];
        [_commentCountButton addTarget:self action:@selector(clickCommentCountButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _commentCountButton;
}

- (INSStandardOperationButton *)likeCountButton {
    if (!_likeCountButton) {
        _likeCountButton = [[INSStandardOperationButton alloc] init];
        [_likeCountButton addTarget:self action:@selector(clickLikeCountButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _likeCountButton;
}

- (INSStandardOperationButton *)tagCountButton {
    if (!_tagCountButton) {
        _tagCountButton = [[INSStandardOperationButton alloc] init];
        [_tagCountButton addTarget:self action:@selector(clickTagCountButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _tagCountButton;
}

- (INSStandardOperationButton *)shareCountButton {
    if (!_shareCountButton) {
        _shareCountButton = [[INSStandardOperationButton alloc] init];
        [_shareCountButton addTarget:self action:@selector(clickShareCountButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _shareCountButton;
}

- (INSSeperateLineView *)seperateLineView1 {
    if (!_seperateLineView1) {
        _seperateLineView1 = [[INSSeperateLineView alloc] init];
    }
    
    return _seperateLineView1;
}

- (INSSeperateLineView *)seperateLineView2 {
    if (!_seperateLineView2) {
        _seperateLineView2 = [[INSSeperateLineView alloc] init];
    }
    
    return _seperateLineView2;
}

- (INSSeperateLineView *)seperateLineView3 {
    if (!_seperateLineView3) {
        _seperateLineView3 = [[INSSeperateLineView alloc] init];
    }

    return _seperateLineView3;
}

- (CGFloat)estimatedHeight {
    return 44.0f;
}

@end
