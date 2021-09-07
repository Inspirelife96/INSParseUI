//
//  UIButton+INS_SwiftTheme.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/30.
//

#import "UIButton+INS_SwiftTheme.h"

@implementation UIButton (INS_SwiftTheme)

+ (UIButton *)ins_buttonWithFontPath:(NSString *)fontPath colorPath:(NSString *)colorPath {
    UIButton *button = [[UIButton alloc] init];
    
    NSDictionary *dict = [ThemeManager currentTheme];
    
    button.titleLabel.theme_font = [ThemeFontPicker pickerWithKeyPath:fontPath map:^UIFont * _Nullable(id _Nullable fontString) {
        NSArray *stringArray = [fontString componentsSeparatedByString:@","];
        return [UIFont fontWithName:stringArray[0] size:[stringArray[1] integerValue]];
    }];
    [button theme_setTitleColor:[ThemeColorPicker pickerWithKeyPath:colorPath] forState:UIControlStateNormal];
    
    return button;
}


@end
