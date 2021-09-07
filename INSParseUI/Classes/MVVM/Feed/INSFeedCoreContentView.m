//
//  INSFeedCoreContentView.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import "INSFeedCoreContentView.h"

#import "INSFeedViewModel.h"

@interface INSFeedCoreContentView ()

@property (nonatomic, strong) INSFeedViewModel *feedVM;

@property (nonatomic, assign) NSInteger mediaContentCount;

@end

@implementation INSFeedCoreContentView

- (instancetype)initWithMediaContentCount:(NSInteger)mediaContentCount {
    if (self = [super init]) {
        _mediaContentCount = mediaContentCount;
        [self buildUI];
    }
    
    return self;
}

- (void)buildUI {
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.mediaContentsView];
    
    [self.mediaContentsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(20.0f);
        make.right.equalTo(self).with.offset(-20.0f);
        make.bottom.equalTo(self);
        make.height.mas_equalTo([self _mediaContentsViewHeight]);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(12.0f);
        make.left.equalTo(self).with.offset(20.0f);
        make.right.equalTo(self).with.offset(-20.0f);
        //make.bottom.equalTo(self.contentLabel.mas_top).with.offset(-8.0f);
        make.height.mas_greaterThanOrEqualTo(1.0f);
        //make.height.mas_greaterThanOrEqualTo(1.0);
    }];
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(8.0f);
        make.left.equalTo(self).with.offset(20.0f);
        make.right.equalTo(self).with.offset(-20.0f);
        make.bottom.equalTo(self.mediaContentsView.mas_top);
    }];
    
    //[self.contentLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    
//    [self layoutIfNeeded];
    
    if (self.mediaContentButtonArray.count > 0) {
        NSArray *photoLayout = [self _mediaContentsViewLayout];
        
        CGFloat meidaContentHeight = [self _mediaContentHeight];
        CGFloat mediaContentEdge = [self _mediaContentEdge];

        CGFloat line0MediaContentHeight = meidaContentHeight;
        CGFloat line1MediaContentHeight = 0;
        CGFloat line2MediaContentHeight = 0;

        NSInteger line0Count = 0;
        if (photoLayout.count > 0) {
            line0Count = [photoLayout[0] integerValue];
        }
        
        NSInteger line1Count = 0;
        if (photoLayout.count > 1) {
            line1Count = [photoLayout[1] integerValue];
            line0MediaContentHeight = ceil((meidaContentHeight - mediaContentEdge)/2);
            line1MediaContentHeight = line0MediaContentHeight;
        }

        NSInteger line2Count = 0;
        if (photoLayout.count > 2) {
            line2Count = [photoLayout[2] integerValue];
            line0MediaContentHeight = ceil((meidaContentHeight - 2 * mediaContentEdge)/3);
            line1MediaContentHeight = line0MediaContentHeight;
            line2MediaContentHeight = line0MediaContentHeight;
        }

        CGFloat line0MeidaContentWidth = [self _mediaContentWidth:line0Count];
        CGFloat line1MeidaContentWidth = [self _mediaContentWidth:line1Count];
        CGFloat line2MeidaContentWidth = [self _mediaContentWidth:line2Count];

        [self.mediaContentButtonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull mediaContentButton, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.mediaContentsView addSubview:mediaContentButton];

            if (idx < line0Count) {
                [mediaContentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mediaContentsView).with.offset(idx * line0MeidaContentWidth + idx * mediaContentEdge);
                    make.top.equalTo(self.mediaContentsView).with.offset(8.0f);
                    make.width.mas_equalTo(line0MeidaContentWidth);
                    make.height.mas_equalTo(line0MediaContentHeight);
                }];
            } else if (idx < (line0Count + line1Count)) {
                [mediaContentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mediaContentsView).with.offset((idx - line0Count) * line1MeidaContentWidth + (idx - line0Count) * 5);
                    make.top.equalTo(self.mediaContentsView).with.offset(meidaContentHeight + mediaContentEdge + 8.0f);
                    make.width.mas_equalTo(line1MeidaContentWidth);
                    make.height.mas_equalTo(line1MediaContentHeight);
                }];
            } else {
                [mediaContentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mediaContentsView).with.offset((idx - line1Count - line0Count) * line2MeidaContentWidth + (idx - line1Count - line0Count) * 5);
                    make.top.equalTo(self.mediaContentsView).with.offset(meidaContentHeight * 2 + mediaContentEdge * 2 + 8.0f);
                    make.width.mas_equalTo(line2MeidaContentWidth);
                    make.height.mas_equalTo(line2MediaContentHeight);
                }];
            }
        }];
    }
}

//// tell UIKit that you are using AutoLayout
//+ (BOOL)requiresConstraintBasedLayout {
//    return YES;
//}
//
//// this is Apple's recommended place for adding/updating constraints
//- (void)updateConstraints {
//
//
//
//    //according to apple super should be called at end of method
//    [super updateConstraints];
//}

- (void)configWithFeedVM:(INSFeedViewModel *)feedVM {
    NSAssert(feedVM.mediaContentUrlStringArray.count == self.mediaContentCount, @"Cell和VM不匹配");
    
    _feedVM = feedVM;
    
    self.titleLabel.text = self.feedVM.title;
    self.contentLabel.text = self.feedVM.content;
    
    [self.mediaContentButtonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull mediaContentButton, NSUInteger idx, BOOL * _Nonnull stop) {
        NSURL *url = [NSURL URLWithString:self.feedVM.mediaContentUrlStringArray[idx]];
        [mediaContentButton sd_setImageWithURL:url forState:UIControlStateNormal placeholderImage:nil];
    }];
}

- (void)clickMediaContentButton:(UIButton *)button {
    NSMutableArray *datas = [NSMutableArray array];
    
    [self.feedVM.mediaContentUrlStringArray enumerateObjectsUsingBlock:^(NSString * _Nonnull mediaContentUrlString, NSUInteger idx, BOOL * _Nonnull stop) {
        YBIBImageData *data = [[YBIBImageData alloc] init];
        data.imageURL = [NSURL URLWithString:mediaContentUrlString];
        [datas addObject:data];
    }];
        
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = button.tag;
    // 只有一个保存操作的时候，可以直接右上角显示保存按钮
    browser.defaultToolViewHandler.topView.operationType = YBIBTopViewOperationTypeSave;
    
    [browser showToView:[[UIApplication sharedApplication] windows][0]];
}

- (CGFloat)_lineWidth {
    return ([UIScreen jk_width] - 20.0f * 2 - 20.0f * 2);
}

- (CGFloat)_mediaContentEdge {
    return 5.0;
}

- (CGFloat)_mediaContentHeight {
    return [self _lineWidth];
    //return ceil(([self _lineWidth] - [self _mediaContentEdge] * 2)/3.0);
}

- (CGFloat)_mediaContentWidth:(NSInteger)numbersInLine {
    if (numbersInLine == 0) {
        return 0.0f;
    } else {
        return ceil(([self _lineWidth] - [self _mediaContentEdge] * (numbersInLine - 1))/numbersInLine);
    }
}

- (CGFloat)_mediaContentsViewHeight {
    NSUInteger lineNumber = [self _mediaContentsViewLayout].count;
    CGFloat mediaContentHeight = [self _mediaContentHeight];
    
    if (lineNumber == 0) {
        return 0.0f;
    } else {
        return (mediaContentHeight * lineNumber + 5.0f * (lineNumber - 1) + 8.0f + 8.0f);
    }
}

- (NSArray *)_mediaContentsViewLayout {
    NSAssert((self.mediaContentCount >= 0) && (self.mediaContentCount <= 9), @"mediaContentCount number is incorrect");
    if (self.mediaContentCount == 0) {
        return @[];
    } else if (self.mediaContentCount == 1) {
        return @[@1];
    } else if (self.mediaContentCount == 2) {
        return @[@1, @1];
    } else if (self.mediaContentCount == 3) {
        return @[@2, @1];
    } else if (self.mediaContentCount == 4) {
        return @[@2, @2];
    } else if (self.mediaContentCount == 5) {
        return @[@3, @2];
    } else if (self.mediaContentCount == 6) {
        return @[@2, @2, @2];
    } else if (self.mediaContentCount == 7) {
        return @[@3, @3, @1];
    } else if (self.mediaContentCount == 8) {
        return @[@3, @3, @2];
    } else {
        return @[@3, @3, @3];
    }
}


#pragma mark Getter/Setter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        
        _titleLabel.theme_font = [ThemeFontPicker pickerWithKeyPath:@"Title.textFont" map:^UIFont * _Nullable(id _Nullable map) {
            NSString *fontString = (NSString *)map;
            NSArray *stringArray = [fontString componentsSeparatedByString:@","];
            return [UIFont fontWithName:stringArray[0] size:[stringArray[1] integerValue]];
        }];
        
        _titleLabel.theme_textColor = [ThemeColorPicker pickerWithKeyPath:@"Title.textColor"];
    }
    
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.theme_font = [ThemeFontPicker pickerWithKeyPath:@"Body.textFont" map:^UIFont * _Nullable(id _Nullable map) {
            NSString *fontString = (NSString *)map;
            NSArray *stringArray = [fontString componentsSeparatedByString:@","];
            return [UIFont fontWithName:stringArray[0] size:[stringArray[1] integerValue]];
        }];
        
        NSLog(@"%@",  [ThemeColorPicker pickerWithKeyPath:@"Title.textColor"]);
        
        _contentLabel.theme_textColor = [ThemeColorPicker pickerWithKeyPath:@"Title.textColor"];
    }
    
    return _contentLabel;
}

- (NSMutableArray <UIButton *> *)mediaContentButtonArray {
    if (!_mediaContentButtonArray) {
        _mediaContentButtonArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < self.mediaContentCount; i++) {
            UIButton *mediaContentButton = [[UIButton alloc] init];
            mediaContentButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
            [mediaContentButton addTarget:self action:@selector(clickMediaContentButton:) forControlEvents:UIControlEventTouchUpInside];
            mediaContentButton.tag = i;
            
            [_mediaContentButtonArray addObject:mediaContentButton];
        }
    }
    
    return _mediaContentButtonArray;
}

- (UIView *)mediaContentsView {
    if (!_mediaContentsView) {
        _mediaContentsView = [[UIView alloc] init];
    }
    
    return _mediaContentsView;
}

- (CGFloat)_titleLabelHeight {
    return [self _calculateLabelHeightWithContent:self.feedVM.title];
}

- (CGFloat)_contentLabelHeight {
    return [self _calculateLabelHeightWithContent:self.feedVM.content];
}

- (CGFloat)_calculateLabelHeightWithContent:(NSString *)content {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = content;
    
    return [label sizeThatFits:CGSizeMake([self _lineWidth], MAXFLOAT)].height;
}

- (CGFloat)estimatedHeight {
    CGFloat titleLabelHeight = [self _titleLabelHeight];
    CGFloat contentLabelHeight = [self _contentLabelHeight];
    CGFloat mediaContentsViewHeight = [self _mediaContentsViewHeight];
    
    return 8.0f + titleLabelHeight + 8.0f + contentLabelHeight + mediaContentsViewHeight + 8.0f;
}


@end
