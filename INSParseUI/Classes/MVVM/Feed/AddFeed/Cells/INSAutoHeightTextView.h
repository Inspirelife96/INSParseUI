//
//  INSAutoHeightTextView.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSAutoHeightTextView : UITextView

@property (nonatomic, copy) NSString* placeholder;
@property (nonatomic, assign) NSInteger maxNumberOfLines;

@property (nonatomic, copy) void(^textHeightChangeBlock)(NSString *text, CGFloat textHeight);

@end

NS_ASSUME_NONNULL_END
