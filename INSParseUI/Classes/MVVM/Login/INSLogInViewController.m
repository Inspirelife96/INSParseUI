//
//  INSLogInViewController.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/30.
//

#import "INSLogInViewController.h"

#import <AuthenticationServices/AuthenticationServices.h>

#import "INSLogInViewProtocol.h"

#import "INSLogInView.h"
#import "INSCloseButton.h"

#import "INSLogInViewModel.h"

#import "UIViewController+INS_AlertView.h"
#import "SCLAlertView+ShowOnMostTopViewController.h"

#import "INSParseUIConstants.h"

#import "UIViewController+INS_OpenLinkInSafari.h"

@interface INSLogInViewController () <ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding, INSLogInViewProtocol>

@property (nonatomic, strong) INSLogInView *loginView;
@property (nonatomic, strong) INSCloseButton *closeButton;

@property (nonatomic, strong) INSLogInViewModel *loginVM;

@property (nonatomic, strong) UIImage *iconImage;


@end

@implementation INSLogInViewController

- (instancetype)initWithIconImage:(UIImage *)iconImage {
    if (self = [super init]) {
        _iconImage = iconImage;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.closeButton];

    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.right.equalTo(self.view).with.offset(-20.0f);
        make.width.mas_equalTo(28.0f);
        make.height.mas_equalTo(28.0f);
    }];
}

#pragma mark Actions

// 关闭按钮
- (void)clickCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 使用苹果账户登录，按照苹果的Login with Apple ID流程
-(void)loginWithAppleID API_AVAILABLE(ios(13.0)) {
    ASAuthorizationAppleIDProvider *provider = [[ASAuthorizationAppleIDProvider alloc]init];
    ASAuthorizationAppleIDRequest * request = [provider createRequest];
    request.requestedScopes = @[ASAuthorizationScopeFullName,ASAuthorizationScopeEmail];
    ASAuthorizationController *authorizationController= [[ASAuthorizationController alloc]initWithAuthorizationRequests:@[request]];
    authorizationController.delegate = self;
    authorizationController.presentationContextProvider = self;
    [authorizationController performRequests];
}

// 使用酷奇账户登录
- (void)login {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.customViewColor = [ThemeManager colorFor:@"SCLAlertView.customViewColor"];
    alert.shouldDismissOnTapOutside = YES;
    
    SCLTextView *userNameField = [alert addTextField:@"用户名"];
    userNameField.keyboardType = UIKeyboardTypeDefault;
    
    SCLTextView *passwordField = [alert addTextField:@"密码"];
    passwordField.keyboardType = UIKeyboardTypeDefault;
    passwordField.secureTextEntry = YES;
    
    [alert addButton:@"登陆" validationBlock:^BOOL{
        self.loginVM.userName = userNameField.text;
        self.loginVM.password = passwordField.text;
        
        NSString *errorMessage = @"";
        
        if (![self.loginVM checkUserName:&errorMessage]) {
            [self ins_alertErrorWithTitle:@"出错了!" subTitle:errorMessage];
            [userNameField becomeFirstResponder];
            return NO;
        }
        
        if (![self.loginVM checkPassword:&errorMessage]) {
            [self ins_alertErrorWithTitle:@"出错了!" subTitle:errorMessage];
            [passwordField becomeFirstResponder];
            return NO;
        }
        
        return YES;
    } actionBlock:^{
        [SVProgressHUD showWithStatus:@"正在登录..."];

        [self.view setUserInteractionEnabled:NO];
        
        [self.loginVM loginInBackground:^(BOOL succeeded, NSString *messageTitle, NSString *messageSubTitle) {
            [SVProgressHUD dismiss];
            
            [self.view setUserInteractionEnabled:YES];

            if (succeeded) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLogin object:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
                
                PFUser *user = [PFUser currentUser];
                NSLog(@"%@", user);
            } else {
                [self ins_alertErrorWithTitle:messageTitle subTitle:messageSubTitle];
            }
        }];
    }];
    
    [alert ins_showEditOnMostTopViewControllerWithTitle:@"登陆" subTitle:@"请输入用户名密码" closeButtonTitle:@"取消" duration:0];
}

- (void)signUp {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.customViewColor = [ThemeManager colorFor:@"SCLAlertView.customViewColor"];
    alert.shouldDismissOnTapOutside = YES;
    
    SCLTextView *userNameField = [alert addTextField:@"用户名"];
    userNameField.keyboardType = UIKeyboardTypeDefault;
    
    SCLTextView *passwordField = [alert addTextField:@"密码"];
    passwordField.keyboardType = UIKeyboardTypeDefault;
    passwordField.secureTextEntry = YES;

    SCLTextView *emailField = [alert addTextField:@"邮箱"];
    emailField.keyboardType = UIKeyboardTypeEmailAddress;

    [alert addButton:@"注册" validationBlock:^BOOL{

        self.loginVM.userName = userNameField.text;
        self.loginVM.password = passwordField.text;
        self.loginVM.email = emailField.text;
        
        NSString *errorMessage = @"";
        
        if (![self.loginVM checkUserName:&errorMessage]) {
            [self ins_alertErrorWithTitle:@"出错了!" subTitle:errorMessage];
            [userNameField becomeFirstResponder];
            return NO;
        }
        
        if (![self.loginVM checkPassword:&errorMessage]) {
            [self ins_alertErrorWithTitle:@"出错了!" subTitle:errorMessage];
            [passwordField becomeFirstResponder];
            return NO;
        }
        
        if (![self.loginVM checkEmail:&errorMessage]) {
            [self ins_alertErrorWithTitle:@"出错了!" subTitle:errorMessage];
            [emailField becomeFirstResponder];
            return NO;
        }
        
        return YES;
    } actionBlock:^{
        [SVProgressHUD showWithStatus:@"正在注册..."];
        [self.view setUserInteractionEnabled:NO];
        
        [self.loginVM signUpInBackground:^(BOOL succeeded, NSString *messageTitle, NSString *messageSubTitle) {
            [SVProgressHUD dismiss];
            [self.view setUserInteractionEnabled:YES];

            if (succeeded) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLogin object:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self ins_alertErrorWithTitle:messageTitle subTitle:messageSubTitle];
            }
        }];
    }];
    
    [alert addButton:@"用户协议" actionBlock:^{
        [self ins_openLinkInSafari:@"https://www.jianshu.com/p/68f48d391c5c"];
    }];
    
    [alert ins_showEditOnMostTopViewControllerWithTitle:@"注册" subTitle:@"注册即视为同意库奇面试用户协议" closeButtonTitle:@"取消" duration:0];
}

- (void)resetPassword {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.customViewColor = [ThemeManager colorFor:@"SCLAlertView.customViewColor"];
    alert.shouldDismissOnTapOutside = YES;
    
    SCLTextView *emailField = [alert addTextField:@"邮箱"];
    emailField.keyboardType = UIKeyboardTypeEmailAddress;
    
    [alert addButton:@"发送" validationBlock:^BOOL{
        self.loginVM.email = emailField.text;
        NSString *errorMessage = @"";
        if (![self.loginVM checkEmail:&errorMessage]) {
            [self ins_alertErrorWithTitle:@"出错了!" subTitle:errorMessage];
            return NO;
        }

        return YES;
    } actionBlock:^{
        [SVProgressHUD showWithStatus:@"正在处理中..."];
        [self.view setUserInteractionEnabled:NO];
        
        WEAKSELF
        [self.loginVM requestPasswordResetForEmailInBackground:^(BOOL succeeded, NSString *messageTitle, NSString *messageSubTitle) {
            STRONGSELF
            [SVProgressHUD dismiss];
            [self.view setUserInteractionEnabled:YES];

            if (succeeded) {
                [strongSelf ins_alertInfoWithTitle:messageTitle subTitle:messageSubTitle];
            } else {
                [strongSelf ins_alertErrorWithTitle:messageTitle subTitle:messageSubTitle];
            }
        }];
    }];
    
    [alert ins_showEditOnMostTopViewControllerWithTitle:@"找回密码" subTitle:@"请输入您的账号关联的邮箱" closeButtonTitle:@"取消" duration:0];
}

#pragma mark ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding

-(ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller
API_AVAILABLE(ios(13.0)){
    return  self.view.window;
}

-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization
API_AVAILABLE(ios(13.0)){
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        ASAuthorizationAppleIDCredential * credential = authorization.credential;
        NSString *state = credential.state;
        NSString * userID = credential.user;
        NSPersonNameComponents *fullName = credential.fullName;
        NSString * email = credential.email;
        // refresh token
        NSString * authorizationCode = [[NSString alloc]initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding];
        // access token
        NSString * identityToken = [[NSString alloc]initWithData:credential.identityToken encoding:NSUTF8StringEncoding];
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        NSLog(@"state: %@", state);
        NSLog(@"userID: %@", userID);
        NSLog(@"fullName: %@", fullName);
        NSLog(@"email: %@", email);
        NSLog(@"authorizationCode: %@", authorizationCode);
        NSLog(@"identityToken: %@", identityToken);
        NSLog(@"realUserStatus: %@", @(realUserStatus));
        
        NSDictionary *authData = @{
            @"id":userID,
            @"token":identityToken
        };
        
        self.loginVM.authType = @"apple";
        self.loginVM.authData = authData;
        self.loginVM.userName = fullName.familyName;
        self.loginVM.email = email;
        
        [SVProgressHUD showWithStatus:@"正在登陆..."];

        [self.view setUserInteractionEnabled:NO];
        
        [self.loginVM loginWithAppleAuthDataInBackground:^(BOOL succeeded, NSString *messageTitle, NSString *messageSubTitle) {
            [SVProgressHUD dismiss];
            [self.view setUserInteractionEnabled:YES];

            if (succeeded) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLogin object:nil];
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self ins_alertErrorWithTitle:messageTitle subTitle:messageSubTitle];
            }
        }];
    }
}

- (BOOL)restoreAuthenticationWithAuthData:(nullable NSDictionary<NSString *, NSString *> *)authData {
    NSLog(@"authData = %@", authData);
    return YES;
}

#pragma mark- 授权失败的回调
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    NSString *errorMessage = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMessage = @"用户取消了授权请求";
            break;
        case ASAuthorizationErrorFailed:
            errorMessage = @"授权请求失败";
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMessage = @"授权请求响应无效";
            break;
        case ASAuthorizationErrorNotHandled:
            errorMessage = @"未能处理授权请求";
            break;
        case ASAuthorizationErrorUnknown:
            errorMessage = @"授权请求失败未知原因";
            break;
    }
    
    [self ins_alertErrorWithTitle:@"授权失败" subTitle:errorMessage];
}


#pragma mark Getter/Setter

- (INSCloseButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[INSCloseButton alloc] init];
        [_closeButton addTarget:self action:@selector(clickCloseButton:) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setUserInteractionEnabled:YES];
    }
    
    return _closeButton;
}

- (INSLogInView *)loginView {
    if (!_loginView) {
        _loginView = [[INSLogInView alloc] init];
        _loginView.delegate = self;
    }
    
    return _loginView;
}

- (INSLogInViewModel *)loginVM {
    if (!_loginVM) {
        _loginVM = [[INSLogInViewModel alloc] init];
    }
    
    return _loginVM;
}

@end
