//
//  INSTextViewCell.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/1.
//

#import <UIKit/UIKit.h>

@class INSAutoHeightTextView;
@class INSTextViewCell;
@class INSTextViewCellViewModel;

NS_ASSUME_NONNULL_BEGIN

@protocol INSTextViewCellDelegate <NSObject>

@optional
-(void)textViewCell:(INSTextViewCell*)cell textHeightChange:(NSString*)text;
-(void)textViewCell:(INSTextViewCell*)cell textChange:(NSString*)text;

@end

@interface INSTextViewCell : UITableViewCell <UITextViewDelegate>

@property (nonatomic, strong) INSAutoHeightTextView *autoHeightTextView;
@property (nonatomic, strong) UILabel *textNumberLabel;

@property (nonatomic, assign) NSInteger maxNumberWords;

@property (nonatomic, weak) id<INSTextViewCellDelegate> delegate;

- (void)configWithTextViewCellVM:(INSTextViewCellViewModel *)textViewCellVM;

@end

NS_ASSUME_NONNULL_END
