//
//  INSSwitchCell.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class INSSwitchCell;

@protocol INSSwitchCellDelegate <NSObject>

@optional
- (void)switchCell:(INSSwitchCell *)settingSwitchCell valueChanged:(UISwitch *)switchButton;

@end

@interface INSSwitchCell : UITableViewCell

@property (nonatomic, strong) UISwitch *switchButton;
@property (nonatomic, weak) id<INSSwitchCellDelegate> delegate;

- (void)updateCellWithSwitchStatus:(BOOL)switchStatus;

@end

NS_ASSUME_NONNULL_END
