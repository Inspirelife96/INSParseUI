//
//  INSPickedPhotoCell.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/1.
//

#import "INSPickedPhotoCell.h"

@implementation INSPickedPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];

        [self addSubview:self.deleteButton];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView);
            make.right.equalTo(self.imageView);
            make.width.mas_equalTo(20.0f);
            make.height.mas_equalTo(20.0f);
        }];
    }
    return self;
}

- (void)setAsset:(PHAsset *)asset {
    _asset = asset;
}

- (void)setRow:(NSInteger)row {
    _row = row;
    self.deleteButton.tag = row;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _imageView;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"pickedPhotoCellDelete"] forState:UIControlStateNormal];
        _deleteButton.alpha = 0.6;
    }
    
    return _deleteButton;
}

@end
