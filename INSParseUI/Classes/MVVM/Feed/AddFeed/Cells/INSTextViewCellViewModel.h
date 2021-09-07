//
//  INSTextViewCellViewModel.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSTextViewCellViewModel : NSObject

@property (nonatomic, copy) NSString *cellDescription;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, assign) NSInteger maxNumberWords;
@property (nonatomic, assign) NSInteger maxNumberOfLines;

- (instancetype)initWithCellDescription:(NSString *)cellDescription placeHolder:(NSString *)placeHolder maxNumberWords:(NSInteger)maxNumberWords maxNumberOfLines:(NSInteger)maxNumberOfLines;

@end

NS_ASSUME_NONNULL_END
