//
//  INSUserProfileViewController.m
//  Bolts
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import "INSUserProfileViewController.h"

#import "INSUserProfileHeaderView.h"

#import "INSUserProfileViewModel.h"


#import "INSFeedQueryViewModel.h"

#import "INSQueryViewController.h"

#import "HJTabViewControllerPlugin_HeaderScroll.h"
#import "HJTabViewControllerPlugin_TabViewBar.h"
#import "HJDefaultTabViewBar.h"

#import "UINavigationBar+INSBackgroundAlpha.h"

#import "UIViewController+INSLogin.h"
#import "UIViewController+INSLoginNotifications.h"

#import "INSParseErrorHandler.h"

@interface INSUserProfileViewController () <HJTabViewControllerDataSource, HJTabViewControllerDelagate, HJDefaultTabViewBarDelegate>

@property (nonatomic, strong) INSUserProfileHeaderView *userProfileHeaderView;
@property (nonatomic, strong) INSUserProfileViewModel *userProfileVM;

@property (nonatomic, strong) PFUser *user;

@property (nonatomic, assign) CGFloat contentPercentY;

@end

@implementation INSUserProfileViewController

- (instancetype)initWithUser:(PFUser *)user {
    if (self = [super init]) {
        _user = user;
        _contentPercentY = 0;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.tabDataSource = self;
    self.tabDelegate = self;
    
    [self.navigationController.navigationBar ins_setNavigationBackgroundAlpha:0];

    HJDefaultTabViewBar *tabViewBar = [HJDefaultTabViewBar new];
    tabViewBar.delegate = self;
    HJTabViewControllerPlugin_TabViewBar *tabViewBarPlugin = [[HJTabViewControllerPlugin_TabViewBar alloc] initWithTabViewBar:tabViewBar delegate:nil];
    [self enablePlugin:tabViewBarPlugin];
    
    [self enablePlugin:[HJTabViewControllerPlugin_HeaderScroll new]];
    
    [self updateUserProfileView];
    
    [self ins_registerLoginNotifications];
}

- (void)dealloc {
    [self ins_unregisterLoginNotifications];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.tabBarController.tabBar) {
        [self.tabBarController.tabBar setHidden:YES];
    }
    
    [self.navigationController.navigationBar ins_setNavigationBackgroundAlpha:self.contentPercentY];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar ins_setNavigationBackgroundAlpha:1];
}

- (void)loginStatusChanged {
    [self updateFollowStatus];
}

#pragma mark -

- (NSInteger)numberOfTabForTabViewBar:(HJDefaultTabViewBar *)tabViewBar {
    return [self numberOfViewControllerForTabViewController:self];
}

- (id)tabViewBar:(HJDefaultTabViewBar *)tabViewBar titleForIndex:(NSInteger)index {
    if (index == 0) {
        return @"他的推荐";
    } else {
        return @"他的提问";
    }
}

- (void)tabViewBar:(HJDefaultTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index {
    BOOL anim = labs(index - self.curIndex) > 1 ? NO: YES;
    [self scrollToIndex:index animated:anim];
}

#pragma mark -

- (void)tabViewController:(HJTabViewController *)tabViewController scrollViewVerticalScroll:(CGFloat)contentPercentY {
    UIViewController *topViewController = self.navigationController.topViewController;
    if (self == topViewController) {
        _contentPercentY = contentPercentY;
        [self.navigationController.navigationBar ins_setNavigationBackgroundAlpha:contentPercentY];
        
        if (contentPercentY > 0.2) {
            self.title = self.user.username;
        }
    } else {
        [self.navigationController.navigationBar ins_setNavigationBackgroundAlpha:1];
    }
}

- (NSInteger)numberOfViewControllerForTabViewController:(HJTabViewController *)tabViewController {
    return 2;
}

- (UIViewController *)tabViewController:(HJTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index {
    if (index == 0) {
        INSFeedQueryViewModel *feedQueryVM = [[INSFeedQueryViewModel alloc] initQueryFeedWithCategory:@(0) fromUser:self.user];
        
        INSQueryViewController *queryVC = [[INSQueryViewController alloc] initWithQueryVM:feedQueryVM];
        return queryVC;
    } else {
        INSFeedQueryViewModel *feedQueryVM = [[INSFeedQueryViewModel alloc] initQueryFeedWithCategory:@(1) fromUser:self.user];
        
        INSQueryViewController *queryVC = [[INSQueryViewController alloc] initWithQueryVM:feedQueryVM];
        return queryVC;
    }
}

- (UIView *)tabHeaderViewForTabViewController:(HJTabViewController *)tabViewController {
    return self.userProfileHeaderView;
}

- (CGFloat)tabHeaderBottomInsetForTabViewController:(HJTabViewController *)tabViewController {
    return HJTabViewBarDefaultHeight + CGRectGetMaxY(self.navigationController.navigationBar.frame);
}

- (UIEdgeInsets)containerInsetsForTabViewController:(HJTabViewController *)tabViewController {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)clickFollowButton:(id)sender {
    if (![self ins_isLogin]) {
        [self ins_login];
    } else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.view setUserInteractionEnabled:NO];
        
        [self.userProfileVM changeFollowedByCurrentUserStatus:^(BOOL succeeded, NSError * _Nullable error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.view setUserInteractionEnabled:YES];
            if (!succeeded) {
                [INSParseErrorHandler handleParseError:error];
            } else {
                [self.userProfileHeaderView configWithUserProfileVM:self.userProfileVM];
                [self updateFollowStatus];
            }
        }];
    }
}

- (void)updateFollowStatus {
    if ([self ins_isLogin] && ![[PFUser currentUser].username isEqualToString:self.user.username]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(clickFollowButton:)];
        if (self.userProfileVM.isFollowedByCurrentUser) {
            [self.navigationItem.rightBarButtonItem setTitle:@"取消关注"];
        } else {
            [self.navigationItem.rightBarButtonItem setTitle:@"关注"];
        }
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)updateUserProfileView {
    [self.userProfileHeaderView configWithUserProfileVM:self.userProfileVM];
}

- (INSUserProfileHeaderView *)userProfileHeaderView {
    if (!_userProfileHeaderView) {
        _userProfileHeaderView = [[INSUserProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen jk_width], 300)];
    }
    
    return _userProfileHeaderView;
}

- (INSUserProfileViewModel *)userProfileVM {
    if (!_userProfileVM) {
        _userProfileVM = [[INSUserProfileViewModel alloc] initWithUser:self.user withBlock:^(BOOL succeeded, NSError * _Nullable error) {
            [self updateUserProfileView];
            [self updateFollowStatus];
        }];
    }

    return _userProfileVM;
}

@end
