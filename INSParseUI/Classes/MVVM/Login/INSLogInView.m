//
//  INSLogInView.m
//  Bolts
//
//  Created by XueFeng Chen on 2021/6/30.
//

#import "INSLogInView.h"

#import "INSLogInBackgroundView.h"
#import "INSCloseButton.h"

#import "UIButton+INS_SwiftTheme.h"
#import "UILabel+INS_SwiftTheme.h"

#import <AuthenticationServices/AuthenticationServices.h>

@interface INSLogInView ()

@property (nonatomic, strong) INSLogInBackgroundView *loginBackgroundView;

@property (nonatomic, strong) ASAuthorizationAppleIDButton *loginWithAppleIDButton;
@property (nonatomic, strong) UILabel *orLabel;

@end

@implementation INSLogInView

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
    [self addSubview:self.loginBackgroundView];
    [self addSubview:self.loginWithAppleIDButton];
    [self addSubview:self.orLabel];
    [self addSubview:self.loginButton];
    [self addSubview:self.signUpButton];
    [self addSubview:self.resetPasswordButton];
    
    [self.loginBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    [self.loginWithAppleIDButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).with.offset(80.0f);
        make.height.mas_equalTo(40.0f);
        make.width.mas_equalTo(ceil([UIScreen jk_width] * 0.618));
    }];

    [self.orLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginWithAppleIDButton.mas_bottom).with.offset(20.0f);
        make.left.equalTo(self.loginWithAppleIDButton);
        make.right.equalTo(self.loginWithAppleIDButton);
        make.height.mas_equalTo(30.0f);
    }];

    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orLabel.mas_bottom);
        make.left.equalTo(self.loginWithAppleIDButton);
        make.right.equalTo(self.loginWithAppleIDButton);
        make.height.mas_equalTo(40.0f);
    }];

    [self.signUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_safeAreaLayoutGuideBottom).with.offset(-32.0f);
        make.left.equalTo(self).with.offset(16.0f);
        make.width.mas_equalTo([UIScreen jk_width]/2.0f);
        make.height.mas_equalTo(24.0f);
    }];

    [self.resetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.signUpButton);
        make.right.equalTo(self).with.offset(-16.0f);
        make.width.mas_equalTo(self.signUpButton);
        make.height.mas_equalTo(self.signUpButton);
    }];
}

#pragma mark UI Actions

// 使用苹果账户登录，按照苹果的Login with Apple ID流程
-(void)clickSignInWithAppleButton API_AVAILABLE(ios(13.0)) {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginWithAppleID)]) {
        [self.delegate loginWithAppleID];
    }
}

- (void)clickLogInButton {
    if (self.delegate && [self.delegate respondsToSelector:@selector(login)]) {
        [self.delegate login];
    }
}

- (void)clickSignUpButton {
    if (self.delegate && [self.delegate respondsToSelector:@selector(signUp)]) {
        [self.delegate signUp];
    }
}

- (void)clickResetPasswordButton {
    if (self.delegate && [self.delegate respondsToSelector:@selector(resetPassword)]) {
        [self.delegate resetPassword];
    }
}

#pragma mark Getter/Setter

- (INSLogInBackgroundView *)loginBackgroundView {
    if (!_loginBackgroundView) {
        _loginBackgroundView = [[INSLogInBackgroundView alloc] init];
    }
    
    return _loginBackgroundView;
}

- (ASAuthorizationAppleIDButton *)loginWithAppleIDButton  API_AVAILABLE(ios(13.0)){
    if (!_loginWithAppleIDButton) {
        if (@available(iOS 13.0, *)) {
            ASAuthorizationAppleIDButtonStyle appleIDButtonStyle = [[ThemeManager numberFor:@"INSLogInView.LogInWithAppleIDButton.style"] integerValue];
            
            _loginWithAppleIDButton = [[ASAuthorizationAppleIDButton alloc]initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeSignIn authorizationButtonStyle:appleIDButtonStyle];
            
            [_loginWithAppleIDButton addTarget:self action:@selector(clickSignInWithAppleButton) forControlEvents:UIControlEventTouchUpInside];
        } else {
            // Fallback on earlier versions
        }
    }
    
    return _loginWithAppleIDButton;
}

- (UILabel *)orLabel {
    if (!_orLabel) {
        _orLabel = [UILabel ins_labelWithFontPath:@"INSLogInView.OrLabel.textFont" colorPath:@"INSLogInView.OrLabel.textColor"];
        _orLabel.text = @" —— 或者 —— ";
        _orLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _orLabel;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [UIButton ins_buttonWithFontPath:@"INSLogInView.LogInButton.textFont" colorPath:@"INSLogInView.LogInButton.textColor"];
        [_loginButton setTitle:@"使用库奇账号登陆" forState:UIControlStateNormal];
        [_loginButton addTarget:self action:@selector(clickLogInButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _loginButton;
}

- (UIButton *)signUpButton {
    if (!_signUpButton) {
        _signUpButton = [UIButton ins_buttonWithFontPath:@"INSLogInView.SignUpButton.textFont" colorPath:@"INSLogInView.SignUpButton.textColor"];
        _signUpButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_signUpButton setTitle:@"注册库奇账号" forState:UIControlStateNormal];
        [_signUpButton addTarget:self action:@selector(clickSignUpButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _signUpButton;
}

- (UIButton *)resetPasswordButton {
    if (!_resetPasswordButton) {
        _resetPasswordButton = [UIButton ins_buttonWithFontPath:@"INSLogInView.ResetPasswordButton.textFont" colorPath:@"INSLogInView.ResetPasswordButton.textColor"];
        _resetPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_resetPasswordButton setTitle:@"忘记库奇账号密码?" forState:UIControlStateNormal];
        [_resetPasswordButton addTarget:self action:@selector(clickResetPasswordButton) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _resetPasswordButton;
}

@end
