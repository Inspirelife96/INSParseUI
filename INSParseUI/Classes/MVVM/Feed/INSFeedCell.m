//
//  INSFeedCell.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import "INSFeedCell.h"

#import "INSFeedCoreContentView.h"
#import "INSStatusView.h"
#import "INSFeedStatisticsView.h"
#import "INSShadowView.h"
#import "INSCornerRadiusView.h"
#import "INSAttributedTextBuilder.h"
#import "INSFeedViewModel.h"

@interface INSFeedCell ()

@property (nonatomic, strong) INSShadowView *shadowView;
@property (nonatomic, strong) INSCornerRadiusView *cornerRadiusView;

@end


@implementation INSFeedCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    [self buildUI];
//}
//
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        self.mediaContentCount = 0;
//        [self buildUI];
//    }
//    return self;
//}
//
//- (instancetype)init {
//    if (self = [super init]) {
//        self.mediaContentCount = 0;
//        [self buildUI];
//    }
//    
//    return self;
//}

- (void)buildUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    [self.contentView addSubview:self.shadowView];
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(20.0f);
        make.left.equalTo(self.contentView).with.offset(20.0f);
        make.right.equalTo(self.contentView).with.offset(-20.0f);
        make.bottom.equalTo(self.contentView).with.offset(-20.0f);
    }];
    
    [self.shadowView addSubview:self.feedStatisticsView];
    [self.shadowView addSubview:self.cornerRadiusView];
    [self.feedStatisticsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shadowView);
        make.right.equalTo(self.shadowView);
        make.bottom.equalTo(self.shadowView);
        make.height.mas_equalTo(44.0f);
    }];
    
    [self.cornerRadiusView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shadowView);
        make.right.equalTo(self.shadowView);
        make.bottom.equalTo(self.feedStatisticsView.mas_top);
        make.top.equalTo(self.shadowView);
    }];
    
    [self.cornerRadiusView addSubview:self.statusView];
    [self.cornerRadiusView addSubview:self.feedCoreContentView];
    
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cornerRadiusView);
        make.right.equalTo(self.cornerRadiusView);
        make.bottom.equalTo(self.cornerRadiusView);
        make.height.mas_equalTo(44.0f);
    }];
    
    [self.feedCoreContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cornerRadiusView);
        make.right.equalTo(self.cornerRadiusView);
        make.top.equalTo(self.cornerRadiusView);
        make.bottom.equalTo(self.statusView.mas_top);
    }];
}

- (void)configWithObjectVM:(INSObjectViewModel *)objectVM {
    _feedVM = (INSFeedViewModel *)objectVM;
    
    [self.feedCoreContentView configWithFeedVM:self.feedVM];
    [self.feedStatisticsView configWithFeedVM:self.feedVM];
    
    self.statusView.infoLabel.attributedText = [self _buildInfoLabelAttributedText];
    self.statusView.statusLabel.attributedText = [self _buildStatusLabelAttributedText];
    
    // status 设置
}

- (NSAttributedString *)_buildInfoLabelAttributedText {
    NSString *postTimeInfo = self.feedVM.postTimeInfo;
    NSString *fromUserName = self.feedVM.fromUserName;
    
    return [INSAttributedTextBuilder buildPostTimeInfo:postTimeInfo fromUserName:fromUserName attributedTextFormat:attributedTextFormatFeed  tapUserNameAction:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(interactWithUser:)]) {
            [self.delegate interactWithUser:self.feedVM.fromUser];
        }
    }];
}

- (NSAttributedString *)_buildStatusLabelAttributedText {
    if ([PFUser currentUser] && [[PFUser currentUser].objectId isEqualToString:self.feedVM.fromUser.objectId]) {
        return [INSAttributedTextBuilder buildFeedStatus:self.feedVM.status tapAction:^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(reviewFeed:)]) {
                [self.delegate reviewFeed:self.feedVM];
            }
        }];
    } else {
        return [INSAttributedTextBuilder buildReportWithtapAction:^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(reportFeed:)]) {
                [self.delegate reportFeed:self.feedVM];
            }
        }];
    }
}

#pragma mark Getter/Setter

- (INSFeedCoreContentView *)feedCoreContentView {
    if (!_feedCoreContentView) {
        _feedCoreContentView = [[INSFeedCoreContentView alloc] initWithMediaContentCount:self.mediaContentCount];
        //_feedCoreContentView.backgroundColor = [UIColor redColor];
    }
    
    return _feedCoreContentView;
}

- (INSStatusView *)statusView {
    if (!_statusView) {
        _statusView = [[INSStatusView alloc] initWithFrame:CGRectZero];
        //_statusView.backgroundColor = [UIColor purpleColor];
    }
    
    return _statusView;
}

- (INSFeedStatisticsView *)feedStatisticsView {
    if (!_feedStatisticsView) {
        _feedStatisticsView = [[INSFeedStatisticsView alloc] initWithFrame:CGRectZero];
        //_feedStatisticsView.backgroundColor = [UIColor darkGrayColor];
    }
    
    return _feedStatisticsView;
}

- (INSShadowView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[INSShadowView alloc] initWithFrame:CGRectZero];
    }
    
    return _shadowView;
}

- (INSCornerRadiusView *)cornerRadiusView {
    if (!_cornerRadiusView) {
        _cornerRadiusView = [[INSCornerRadiusView alloc] initWithFrame:CGRectZero];
    }
    
    return _cornerRadiusView;
}

- (void)setDelegate:(id)delegate {
    [super setDelegate:delegate];
    
    self.feedCoreContentView.delegate = delegate;
    self.feedStatisticsView.delegate = delegate;
}

- (CGFloat)estimatedHeight {
    CGFloat feedCoreContentViewHeight = [self.feedCoreContentView estimatedHeight];
    CGFloat statusViewHeight = [self.statusView estimatedHeight];
    CGFloat feedStatisticsViewHeight = [self.feedStatisticsView estimatedHeight];

    return 20.0f + feedCoreContentViewHeight + statusViewHeight + feedStatisticsViewHeight + 20.0f;
}

@end
