//
//  INSSwitchCell.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/2.
//

#import "INSSwitchCell.h"

#import "UILabel+INS_SwiftTheme.h"

@implementation INSSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self buildUI];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryView = self.switchButton;
    
    [self.textLabel ins_configLabelWithFontPath:@"INSSwitchCell.textLabel.font" colorPath:@"INSSwitchCell.textLabel.textColor"];
    [self.detailTextLabel ins_configLabelWithFontPath:@"INSSwitchCell.detailTextLabel.font" colorPath:@"INSSwitchCell.detailTextLabel.textColor"];
}

- (void)updateCellWithSwitchStatus:(BOOL)switchStatus {
    [self.switchButton setOn:switchStatus];
}

- (void)switchButtonValueChanged:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(switchCell:valueChanged:)]){
        [self.delegate switchCell:self valueChanged:sender];
    }
}

#pragma mark Getter/Setter

- (UISwitch *)switchButton {
    if (!_switchButton) {
        _switchButton = [[UISwitch alloc] init];
        [_switchButton setTheme_onTintColor:[ThemeColorPicker pickerWithKeyPath:@"INSSwitchCell.switchButton.onTintColor"]];
        [_switchButton addTarget:self action:@selector(switchButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _switchButton;
}

@end
