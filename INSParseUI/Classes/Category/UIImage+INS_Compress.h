//
//  UIImage+INS_Compress.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/7/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (INS_Compress)

- (NSData *)ins_compressToByte:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
