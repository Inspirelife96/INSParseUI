//
//  INSAddFeedViewController+INSTextViewCellDelegate.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/3.
//

#import "INSAddFeedViewController+INSTextViewCellDelegate.h"

@implementation INSAddFeedViewController (INSTextViewCellDelegate)

#pragma mark LSTextViewCellDelegate

-(void)textViewCell:(INSTextViewCell *)cell textChange:(NSString *)text{
    if (cell == self.titleCell) {
        self.addFeedVM.title = text;
    }
    
    if (cell == self.contentCell) {
        self.addFeedVM.content = text;
    }
    
    if (cell == self.forwardFromCell) {
        self.addFeedVM.forwardFrom = text;
    }
}

-(void)textViewCell:(INSTextViewCell*)cell textHeightChange:(NSString*)text{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

@end
