//
//  INSLikeViewModel.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import <Foundation/Foundation.h>

#import "INSFeedViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface INSLikeViewModel : NSObject

// 持有
@property (nonatomic, strong) INSLike *like;

// 需要Fetch
@property (nonatomic, strong) INSFeed *toFeed;
@property (nonatomic, strong) PFUser *fromUser;

// Fetch之后需要VM化的
@property (nonatomic, strong) INSFeedViewModel *feedVM;

// UI展示相关
// 核心数据
@property (nonatomic, strong) NSString *fromUserName;

- (instancetype)initWithLike:(INSLike *)like error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
