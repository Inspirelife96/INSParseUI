//
//  INSObjectViewModel.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import <Foundation/Foundation.h>

#import "INSCellViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface INSObjectViewModel : NSObject <INSCellViewModelProtocol>

+ (instancetype)createViewModel:(PFObject *)object error:(NSError **)error;

//- (instancetype)initWithObject:(PFObject *)object;

@end

NS_ASSUME_NONNULL_END
