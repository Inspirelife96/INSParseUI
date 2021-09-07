//
//  INSReport.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import <Parse/Parse.h>

@class INSFeed;
@class INSComment;

NS_ASSUME_NONNULL_BEGIN

@interface INSReport : PFObject <PFSubclassing>

@property (nonatomic, strong) PFUser *fromUser;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSNumber *reason;
@property (nonatomic, strong) INSFeed *feed;
@property (nonatomic, strong) INSComment *comment;

@end

NS_ASSUME_NONNULL_END
