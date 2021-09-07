//
//  INSTextViewCell.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/1.
//

#import "INSTextViewCell.h"

#import "INSAutoHeightTextView.h"

#import "UILabel+INS_SwiftTheme.h"

#import "INSParseUIConstants.h"

#import "INSTextViewCellViewModel.h"

@implementation INSTextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self buildUI];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    [self.contentView addSubview:self.autoHeightTextView];
    [self.contentView addSubview:self.textNumberLabel];
    
    [self.textNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(12);
        make.right.equalTo(self.contentView).with.offset(-12);
        make.bottom.equalTo(self.contentView).with.offset(-8);
        make.height.mas_equalTo(21.0f);
    }];
    
    //顶部的约束优先级最高，那么会先改变约束优先级高的，这样避免了底部在输入的换行自适应是的上下跳动问题
    [self.autoHeightTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(8).priority(999);
        make.height.mas_greaterThanOrEqualTo(@(36)).priority(888);
        make.bottom.equalTo(self.textNumberLabel.mas_top).offset(-8).priority(777);
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
    }];
    
    WEAKSELF
    self.autoHeightTextView.textHeightChangeBlock = ^(NSString *text, CGFloat textHeight) {
        
        [weakSelf.autoHeightTextView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(@(textHeight > 36 ? textHeight : 36)).priority(888);
        }];
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(textViewCell:textHeightChange:)]) {
            [weakSelf.delegate textViewCell:weakSelf textHeightChange:text];
        }
        
        [weakSelf layoutIfNeeded];
    };
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView{
    
    // 输入的时候字符限制
    // 判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断
    UITextRange *selectedRange = textView.markedTextRange;
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    
    if (position) {
        return;
    }
    
    //当前输入字数
    self.textNumberLabel.text = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)textView.text.length, self.maxNumberWords];
    self.textNumberLabel.theme_textColor = [ThemeColorPicker pickerWithKeyPath:@"INSTextViewCell.textNumberLabel.textColor"];
    
    if (textView.text.length > self.maxNumberWords) {
        textView.text = [textView.text substringToIndex:self.maxNumberWords];
        self.textNumberLabel.text = [NSString stringWithFormat:@"%ld/%ld", self.maxNumberWords, self.maxNumberWords];
        self.textNumberLabel.theme_textColor = [ThemeColorPicker pickerWithKeyPath:@"INSTextViewCell.textNumberLabel.textColorWhenReachesMax"];;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewCell:textChange:)]) {
        [self.delegate textViewCell:self textChange:self.autoHeightTextView.text];
    }
}

- (void)configWithTextViewCellVM:(INSTextViewCellViewModel *)textViewCellVM {
    self.autoHeightTextView.placeholder = textViewCellVM.placeHolder;
    self.autoHeightTextView.maxNumberOfLines = textViewCellVM.maxNumberOfLines;
    self.maxNumberWords = textViewCellVM.maxNumberWords;
}

#pragma mark Getter/Setter

- (INSAutoHeightTextView *)autoHeightTextView{
    if (!_autoHeightTextView) {
        _autoHeightTextView = [[INSAutoHeightTextView alloc] initWithFrame:CGRectZero];
        _autoHeightTextView.delegate = self;
    }
    
    return _autoHeightTextView;
}

- (UILabel *)textNumberLabel {
    if (!_textNumberLabel) {
        _textNumberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_textNumberLabel ins_configLabelWithFontPath:@"INSTextViewCell.textNumberLabel.font" colorPath:@"INSTextViewCell.textNumberLabel.textColor"];
        _textNumberLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _textNumberLabel;
}

- (void)setMaxNumberWords:(NSInteger)maxNumberWords {
    _maxNumberWords = maxNumberWords;
    self.textNumberLabel.text = [NSString stringWithFormat:@"0/%ld", self.maxNumberWords];
}

@end
