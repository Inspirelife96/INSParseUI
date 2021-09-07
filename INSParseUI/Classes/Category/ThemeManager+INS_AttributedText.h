//
//  ThemeManager+INS_AttributedText.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/29.
//

#import <SwiftTheme/SwiftTheme-umbrella.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThemeManager (INS_AttributedText)

+ (UIColor *)textColor;
+ (UIColor *)highlightTextColor;
+ (UIFont *)textFont;
+ (UIFont *)hightlightTextFont;

@end

NS_ASSUME_NONNULL_END
