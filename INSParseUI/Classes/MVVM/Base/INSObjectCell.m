//
//  INSObjectCell.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import "INSObjectCell.h"

@implementation INSObjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.theme_backgroundColor = [ThemeColorPicker pickerWithKeyPath:@"UITableViewCell.backgroundColor"];
        self.contentView.theme_backgroundColor = [ThemeColorPicker pickerWithKeyPath:@"UITableViewCell.contentView.backgroundColor"];

    }
    return self;
}

@end
