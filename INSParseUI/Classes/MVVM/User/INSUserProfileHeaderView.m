//
//  INSUserProfileHeaderView.m
//  Bolts
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import "INSUserProfileHeaderView.h"

#import "INSUserProfileViewModel.h"

#import "UILabel+INS_SwiftTheme.h"

#import "INSAttributedTextBuilder.h"

@interface INSUserProfileHeaderView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIButton *profileButton;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) YYLabel *followInfoLabel;

@property (nonatomic, strong) INSUserProfileViewModel *userProfileVM;

@end

@implementation INSUserProfileHeaderView

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
    self.backgroundColor = [UIColor whiteColor];
    //self.theme_backgroundColor = [ThemeColorPicker pickerWithKeyPath:@"INSUserProfileHeaderView.backgroundColor"];

    [self addSubview:self.backgroundImageView];

    [self addSubview:self.profileButton];
    [self addSubview:self.usernameLabel];
    [self addSubview:self.followInfoLabel];

    [self.profileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(20.0f);
        make.top.equalTo(self.backgroundImageView.mas_bottom).with.offset(-25.0f);
        make.width.mas_equalTo(75.0f);
        make.height.mas_equalTo(75.0f);
    }];

    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.profileButton.mas_right).with.offset(8.0f);
        make.top.equalTo(self.backgroundImageView.mas_bottom).with.offset(6.0f);
        make.right.equalTo(self.backgroundImageView).with.offset(-20.0f);
        make.height.mas_equalTo(20.0f);
    }];

    [self.followInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.profileButton.mas_right).with.offset(8.0f);
        make.top.equalTo(self.usernameLabel.mas_bottom).with.offset(4.0f);
        make.right.equalTo(self.backgroundImageView).with.offset(-20.0f);
        make.height.mas_equalTo(20.0f);
    }];
}

- (void)configWithUserProfileVM:(INSUserProfileViewModel *)userProfileVM {
    _userProfileVM = userProfileVM;

    self.usernameLabel.text = userProfileVM.userName;

    self.backgroundImageView.image = [UIImage imageNamed:userProfileVM.backgroundImageLink];

    if([self.userProfileVM.profileImageLink jk_isValidUrl]) {
        NSURL *imageUrl = [NSURL URLWithString:self.userProfileVM.profileImageLink];
        [self.profileButton sd_setImageWithURL:imageUrl forState:UIControlStateNormal];
    } else {
        [self.profileButton setImage:[UIImage imageNamed:self.userProfileVM.profileImageLink] forState:UIControlStateNormal];
    }

    if([self.userProfileVM.backgroundImageLink jk_isValidUrl]) {
        NSURL *backgroundImageUrl = [NSURL URLWithString:self.userProfileVM.backgroundImageLink];
        [self.backgroundImageView sd_setImageWithURL:backgroundImageUrl];
    } else {
        [self.backgroundImageView setImage:[UIImage imageNamed:self.userProfileVM.backgroundImageLink]];
    }

    self.followInfoLabel.attributedText = [INSAttributedTextBuilder buildFollow:userProfileVM.followCount followed:userProfileVM.followedCount tapFollowAction:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickFollow:)]) {
            [self.delegate clickFollow:userProfileVM.user];
        }
    } tapFollowedAction:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickFollowed:)]) {
            [self.delegate clickFollowed:userProfileVM.user];
        }
    }];
}

- (void)clickProfileImageButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickProfileImageButton:)]) {
        [self.delegate clickProfileImageButton:sender];
    }
}

#pragma makr Getter/Setter

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen jk_width], 200)];
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;

        [_backgroundImageView setUserInteractionEnabled:YES];
    }

    return _backgroundImageView;
}

- (UIButton *)profileButton {
    if (!_profileButton) {
        _profileButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _profileButton.layer.cornerRadius = 37.50f;
        _profileButton.layer.masksToBounds = YES;

        [_profileButton setAdjustsImageWhenHighlighted:NO];

        [_profileButton addTarget:self action:@selector(clickProfileImageButton:) forControlEvents:UIControlEventTouchUpInside];
    }

    return _profileButton;
}

- (UILabel *)usernameLabel {
    if (!_usernameLabel) {
        _usernameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _usernameLabel.font = [KQStyle boldFontBig];
//        _usernameLabel.textColor = [KQStyle colorBlack];
        _usernameLabel.textAlignment = NSTextAlignmentLeft;
        [_usernameLabel ins_configLabelWithFontPath:@"INSUerProfileHeaderView.usernameLabel.font" colorPath:@"INSUerProfileHeaderView.usernameLabel.color"];
    }

    return _usernameLabel;
}

- (YYLabel *)followInfoLabel {
    if (!_followInfoLabel) {
        _followInfoLabel = [[YYLabel alloc] init];
        _followInfoLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    }

    return _followInfoLabel;
}

@end
