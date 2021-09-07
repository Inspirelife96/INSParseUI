//
//  INSFollowInfo.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSFollowInfo : PFObject <PFSubclassing>

@property (nonatomic, strong) NSNumber *followCount;
@property (nonatomic, strong) NSNumber *followedCount;
@property (nonatomic, strong) PFUser *user;

@end

NS_ASSUME_NONNULL_END
