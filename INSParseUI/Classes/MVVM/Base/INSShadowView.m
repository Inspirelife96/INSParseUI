//
//  INSShadowView.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/29.
//

#import "INSShadowView.h"

@implementation INSShadowView

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
    self.theme_backgroundColor = [ThemeColorPicker pickerWithKeyPath:@"ShadowView.backgroundColor"];
    self.layer.shadowOpacity = 1.0f;
    self.layer.theme_shadowColor = [ThemeCGColorPicker pickerWithKeyPath:@"ShadowView.shadowColor"];
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = 20.0f;
    self.layer.cornerRadius = 20.0f;
}

@end
