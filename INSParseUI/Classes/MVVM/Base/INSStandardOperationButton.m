//
//  INSStandardOperationButton.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/29.
//

#import "INSStandardOperationButton.h"

@implementation INSStandardOperationButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self buildUI];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    self.titleLabel.theme_font = [ThemeFontPicker pickerWithKeyPath:@"StandardOperationButton.textFont" map:^UIFont * _Nullable(id _Nullable fontString) {
        NSArray *stringArray = [fontString componentsSeparatedByString:@","];
        return [UIFont fontWithName:stringArray[0] size:[stringArray[1] integerValue]];
    }];
    [self theme_setTitleColor:[ThemeColorPicker pickerWithKeyPath:@"StandardOperationButton.titleColor"] forState:UIControlStateNormal];
    [self jk_setImagePosition:LXMImagePositionLeft spacing:4.0f];
}

@end
