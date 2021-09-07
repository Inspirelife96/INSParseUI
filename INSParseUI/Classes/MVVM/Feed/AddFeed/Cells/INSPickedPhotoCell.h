//
//  INSPickedPhotoCell.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSPickedPhotoCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, strong) id asset;

@end

NS_ASSUME_NONNULL_END
