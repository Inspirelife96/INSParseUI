//
//  INSCommentCell.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import "INSCommentCell.h"

#import "INSCommentViewModel.h"

#import "INSAttributedTextBuilder.h"

#import "INSShadowView.h"
#import "INSCornerRadiusView.h"

#import "INSStatusView.h"

#import "UILabel+INS_SwiftTheme.h"

@interface INSCommentCell ()

@property (nonatomic, strong) INSShadowView *shadowView;
@property (nonatomic, strong) INSCornerRadiusView *cornerRadiusView;

@end

@implementation INSCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self buildUI];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.contentView addSubview:self.shadowView];
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(20.0f);
        make.left.equalTo(self.contentView).with.offset(20.0f);
        make.right.equalTo(self.contentView).with.offset(-20.0f);
        make.bottom.equalTo(self.contentView).with.offset(-20.0f);
    }];
    
    [self.shadowView addSubview:self.statusView];
    [self.shadowView addSubview:self.cornerRadiusView];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shadowView);
        make.right.equalTo(self.shadowView);
        make.bottom.equalTo(self.shadowView);
        make.height.mas_equalTo(44.0f);
    }];
    
    [self.cornerRadiusView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shadowView);
        make.right.equalTo(self.shadowView);
        make.bottom.equalTo(self.statusView.mas_top);
        make.top.equalTo(self.shadowView);
    }];
    
    [self.cornerRadiusView addSubview:self.contentLabel];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cornerRadiusView).with.offset(20.0f);
        make.right.equalTo(self.cornerRadiusView).with.offset(-20.0f);
        make.top.equalTo(self.cornerRadiusView).with.offset(12.0f);
        make.bottom.equalTo(self.cornerRadiusView).with.offset(-12);
    }];
}

- (void)configWithObjectVM:(INSObjectViewModel *)objectVM {
    _commentVM = (INSCommentViewModel *)objectVM;
    
    self.contentLabel.text = self.commentVM.content;
    
    self.statusView.infoLabel.attributedText = [self _buildInfoLabelAttributedText];
    self.statusView.statusLabel.attributedText = [self _buildStatusLabelAttributedText];
    
    self.statusView.infoLabel.textAlignment = NSTextAlignmentRight;
    self.statusView.statusLabel.textAlignment = NSTextAlignmentLeft;
}

- (NSAttributedString *)_buildInfoLabelAttributedText {
    NSString *postTimeInfo = self.commentVM.postTimeInfo;
    NSString *fromUserName = self.commentVM.fromUserName;
    
    return [INSAttributedTextBuilder buildPostTimeInfo:postTimeInfo fromUserName:fromUserName attributedTextFormat:attributedTextFormatComment  tapUserNameAction:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(interactWithUser:)]) {
            [self.delegate interactWithUser:self.commentVM.fromUser];
        }
    }];
}

- (NSAttributedString *)_buildStatusLabelAttributedText {
    return [INSAttributedTextBuilder buildCommentStatus:self.commentVM.isDeletable tapAction:^{
        if (self.commentVM.isDeletable) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(deleteComment:)]) {
                [self.delegate deleteComment:self.commentVM];
            }
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(reportComment:)]) {
                [self.delegate reportComment:self.commentVM];
            }
        }
    }];
}

#pragma mark Getter/Setter

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

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
//        _contentLabel.textColor = [KQStyle colorGrayDark];
        _contentLabel.numberOfLines = 0;
//        _contentLabel.alpha = 0.8;
//        _contentLabel.font = [KQStyle fontNormal];
        [_contentLabel ins_configLabelWithFontPath:@"INSCommentCell.contentLabel.font" colorPath:@"INSCommentCell.contentLabel.color"];
    }
    
    return _contentLabel;
}

- (INSStatusView *)statusView {
    if (!_statusView) {
        _statusView = [[INSStatusView alloc] initWithFrame:CGRectZero];
    }
    
    return _statusView;
}

@end
