//
//  INSQueryViewController+User.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import "INSQueryViewController+User.h"

#import "INSUserProfileViewController.h"

@implementation INSQueryViewController (User)

- (void)interactWithUser:(PFUser *)user {
    INSUserProfileViewController *userProfileVC = [[INSUserProfileViewController alloc] initWithUser:user];
    [self.navigationController pushViewController:userProfileVC animated:YES];
}

@end
