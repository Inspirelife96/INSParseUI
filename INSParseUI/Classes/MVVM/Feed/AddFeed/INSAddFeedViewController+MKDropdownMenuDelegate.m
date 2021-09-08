//
//  INSAddFeedViewController+MKDropdownMenuDelegate.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/3.
//

#import "INSAddFeedViewController+MKDropdownMenuDelegate.h"

@implementation INSAddFeedViewController (MKDropdownMenuDelegate)

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [dropdownMenu closeAllComponentsAnimated:YES];
        
        self.addFeedVM.category = @(row);
        
        
        [self.tableView reloadData];
    });
}

@end
