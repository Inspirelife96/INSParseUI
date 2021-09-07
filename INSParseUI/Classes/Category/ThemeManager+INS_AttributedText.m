//
//  ThemeManager+INS_AttributedText.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/29.
//

#import "ThemeManager+INS_AttributedText.h"

@implementation ThemeManager (INS_AttributedText)

+ (UIColor *)textColor {
    NSString *colorString = [ThemeManager _valueForKey:@"textColor"];
    return [UIColor jk_colorWithHexString:colorString];
}

+ (UIColor *)highlightTextColor {
    NSString *colorString = [ThemeManager _valueForKey:@"highlightTextColor"];
    return [UIColor jk_colorWithHexString:colorString];
}

+ (UIFont *)textFont {
    NSString *fontString = [ThemeManager _valueForKey:@"textFont"];
    NSArray *array = [fontString componentsSeparatedByString:@","];
    return [UIFont fontWithName:array[0] size:[array[1] integerValue]];
}

+ (UIFont *)hightlightTextFont {
    NSString *fontString = [ThemeManager _valueForKey:@"highlightTextFont"];
    NSArray *array = [fontString componentsSeparatedByString:@","];
    return [UIFont fontWithName:array[0] size:[array[1] integerValue]];
}

+ (NSString *)_valueForKey:(NSString *)key {
    NSDictionary *themeDict = [ThemeManager currentTheme];
    NSDictionary *attributedTextDict = themeDict[@"AttributedText"];
    return attributedTextDict[key];
}

@end
