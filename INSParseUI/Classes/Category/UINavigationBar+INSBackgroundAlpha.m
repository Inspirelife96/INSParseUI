//
//  UINavigationBar+INSBackgroundAlpha.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import "UINavigationBar+INSBackgroundAlpha.h"

@implementation UINavigationBar (INSBackgroundAlpha)

- (void)ins_setNavigationBackgroundAlpha:(CGFloat)alpha {
    UIView *barBackgroundView = [[self subviews] objectAtIndex:0];
    barBackgroundView.alpha = alpha;
    
    UIView *barContentView = [[self subviews] objectAtIndex:1];
    
    NSArray *subViews = [barContentView subviews];
    
    [subViews enumerateObjectsUsingBlock:^(UIView *  _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([subView isMemberOfClass:[UILabel class]]) {
            subView.alpha = alpha;
        }
    }];
}

@end
