//
//  INSAddFeedViewController+INSSwitchCellDelegate.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/3.
//

#import "INSAddFeedViewController+INSSwitchCellDelegate.h"

@implementation INSAddFeedViewController (INSSwitchCellDelegate)

- (void)switchCell:(INSSwitchCell *)settingSwitchCell valueChanged:(UISwitch *)switchButton {
    self.addFeedVM.isOriginal = [switchButton isOn];
}

@end
