//
//  UILabel+INS_SwiftTheme.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (INS_SwiftTheme)

+ (UILabel *)ins_labelWithFontPath:(NSString *)fontPath colorPath:(NSString *)colorPath;

- (void)ins_configLabelWithFontPath:(NSString *)fontPath colorPath:(NSString *)colorPath;

@end

NS_ASSUME_NONNULL_END
