//
//  INSFeedQueryViewModel.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import "INSQueryViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface INSFeedQueryViewModel : INSQueryViewModel

- (instancetype)initQueryFeedWithOrderBy:(NSString *)orderBy;

- (instancetype)initQueryFeedWithCategory:(NSNumber *)category fromUser:(PFUser *)fromUser;

@end

NS_ASSUME_NONNULL_END
