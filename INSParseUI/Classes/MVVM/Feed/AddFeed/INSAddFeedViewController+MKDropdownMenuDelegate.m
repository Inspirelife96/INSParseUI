//
//  INSAddFeedViewController+MKDropdownMenuDelegate.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/3.
//

#import "INSAddFeedViewController+MKDropdownMenuDelegate.h"

@implementation INSAddFeedViewController (MKDropdownMenuDelegate)

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    delay(0.15, ^{
        [dropdownMenu closeAllComponentsAnimated:YES];
        
        self.addFeedVM.category = @(row);
        
        
        [self.tableView reloadData];

    });
}

@end
