//
//  INSStatusView.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import "INSStatusView.h"

@implementation INSStatusView

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
    //self.backgroundColor = ClearColor;
    
    
    [self addSubview:self.infoLabel];
    [self addSubview:self.statusLabel];
    
    [self.statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-12.0f);
        make.right.equalTo(self).with.offset(-20.0f);
        make.width.mas_equalTo(21.0f);
        make.height.mas_equalTo(21.0f).priorityHigh();
    }];

    [self.infoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-12.0f);
        make.left.equalTo(self).with.offset(20.0f);
        make.right.mas_equalTo(self.statusLabel.mas_left).with.offset(-20.0f);
        make.height.mas_equalTo(21.0f);
    }];
}

- (YYLabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[YYLabel alloc] init];
        _infoLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    }
    
    return _infoLabel;
}

- (YYLabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[YYLabel alloc] init];
        _statusLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    }
    
    return _statusLabel;
}

- (CGFloat)estimatedHeight {
    return 44.0f;
}

@end
