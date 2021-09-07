//
//  INSAutoHeightTextView.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/1.
//

#import "INSAutoHeightTextView.h"

@interface INSAutoHeightTextView ()

@property (nonatomic, strong) UILabel* placeholderLabel;

@property (nonatomic, assign) NSInteger textHeight;
@property (nonatomic, assign) NSInteger maxHeight;

@end

@implementation INSAutoHeightTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.maxNumberOfLines = 5;
        [self buildUI];
    }

    return self;
}

- (void)buildUI {
    self.showsHorizontalScrollIndicator = NO;
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.enablesReturnKeyAutomatically = YES;
    
    self.theme_font = [ThemeFontPicker pickerWithKeyPath:@"INSAutoHeightTextView.font" map:^UIFont * _Nullable(id _Nullable fontString) {
        NSArray *stringArray = [fontString componentsSeparatedByString:@","];
        return [UIFont fontWithName:stringArray[0] size:[stringArray[1] integerValue]];
    }];
    
    [self addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.left.equalTo(self).with.offset(5.0);
        make.height.mas_equalTo(36.0f);
    }];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueChanged) name:UITextViewTextDidChangeNotification object:self];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textValueChanged {
    self.placeholderLabel.hidden = (self.text.length != 0);
    
    NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    // 高度不一样，就改变了高度
    if (self.textHeight != height) {
        
        // 最大高度，可以滚动
        self.scrollEnabled = (height > self.maxHeight) && (self.maxHeight > 0);
        self.textHeight = height;
        
        if (height > self.maxHeight) {
            height = self.maxHeight;
        }
        
        if (self.textHeightChangeBlock) {
            self.textHeightChangeBlock(self.text, height);
            [self.superview layoutIfNeeded];
        }
    }
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.theme_textColor = [ThemeColorPicker pickerWithKeyPath:@"INSAutoHeightTextView.placeholderLabel.textColor"];
        _placeholderLabel.theme_font = [ThemeFontPicker pickerWithKeyPath:@"INSAutoHeightTextView.placeholderLabel.font" map:^UIFont * _Nullable(id _Nullable fontString) {
            NSArray *stringArray = [fontString componentsSeparatedByString:@","];
            return [UIFont fontWithName:stringArray[0] size:[stringArray[1] integerValue]];
        }];
    }
    
    return _placeholderLabel;
}

- (void)setmaxNumberOfLines:(NSInteger)maxNumberOfLines{
    _maxNumberOfLines = maxNumberOfLines;
    self.maxHeight = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
}

- (void)setTextHeightChangeBlock:(void (^)(NSString *, CGFloat))textHeightChangeBlock{
    _textHeightChangeBlock = textHeightChangeBlock;
    [self textValueChanged];
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
}

@end
