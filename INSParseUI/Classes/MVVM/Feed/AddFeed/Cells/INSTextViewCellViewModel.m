//
//  INSTextViewCellViewModel.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/3.
//

#import "INSTextViewCellViewModel.h"

@implementation INSTextViewCellViewModel

- (instancetype)initWithCellDescription:(NSString *)cellDescription placeHolder:(NSString *)placeHolder maxNumberWords:(NSInteger)maxNumberWords maxNumberOfLines:(NSInteger)maxNumberOfLines {
    if (self = [super init]) {
        _cellDescription = cellDescription;
        _placeHolder = placeHolder;
        _maxNumberWords = maxNumberWords;
        _maxNumberOfLines = maxNumberOfLines;
    }
    
    return self;
}

@end
