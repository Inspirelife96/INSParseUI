//
//  UILabel+INS_SwiftTheme.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/30.
//

#import "UILabel+INS_SwiftTheme.h"

@implementation UILabel (INS_SwiftTheme)

+ (UILabel *)ins_labelWithFontPath:(NSString *)fontPath colorPath:(NSString *)colorPath {
    UILabel *label = [[UILabel alloc] init];
    
    if (fontPath) {
        label.theme_font = [ThemeFontPicker pickerWithKeyPath:fontPath map:^UIFont * _Nullable(id _Nullable fontString) {
            NSArray *stringArray = [fontString componentsSeparatedByString:@","];
            return [UIFont fontWithName:stringArray[0] size:[stringArray[1] integerValue]];
        }];
    }
    
    if (colorPath) {
        label.theme_textColor = [ThemeColorPicker pickerWithKeyPath:colorPath];
    }
    
    return label;
}

- (void)ins_configLabelWithFontPath:(NSString *)fontPath colorPath:(NSString *)colorPath {
    if (fontPath) {
        self.theme_font = [ThemeFontPicker pickerWithKeyPath:fontPath map:^UIFont * _Nullable(id _Nullable fontString) {
            NSArray *stringArray = [fontString componentsSeparatedByString:@","];
            return [UIFont fontWithName:stringArray[0] size:[stringArray[1] integerValue]];
        }];
    }
    
    if (colorPath) {
        self.theme_textColor = [ThemeColorPicker pickerWithKeyPath:colorPath];
    }
}

@end
