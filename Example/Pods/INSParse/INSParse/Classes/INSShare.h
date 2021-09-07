//
//  INSShare.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@class INSFeed;

@interface INSShare : PFObject <PFSubclassing>

@property (nonatomic, strong) NSNumber *category;

@property (nonatomic, strong) INSFeed *feed;
@property (nonatomic, copy) NSString *toPlatform;
@property (nonatomic, strong) PFUser *fromUser;

@end

NS_ASSUME_NONNULL_END
