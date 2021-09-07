//
//  INSParseQueryManager+Share.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager.h"

@class INSFeed;

NS_ASSUME_NONNULL_BEGIN

@interface INSParseQueryManager (Share)

// Share表添加

// Share表的内容不做删除，不激活Activity。

+ (BOOL)addShareWithCategory:(NSNumber *)category
                        Feed:(INSFeed *)Feed
                  toPlatform:(NSString *)toPlatform
                    fromUser:(PFUser *)fromUser
                       error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
