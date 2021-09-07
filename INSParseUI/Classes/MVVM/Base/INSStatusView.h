//
//  INSStatusView.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import <UIKit/UIKit.h>

#import <YYText/YYLabel.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSStatusView : UIView

@property (nonatomic, strong) YYLabel *infoLabel;
@property (nonatomic, strong) YYLabel *statusLabel;

- (CGFloat)estimatedHeight;

@end

NS_ASSUME_NONNULL_END
