//
//  INSActivity.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@class INSFeed;
@class INSComment;
@class INSLike;
@class INSShare;
@class INSFollow;

@interface INSActivity : PFObject <PFSubclassing>

@property (nonatomic, strong) PFUser *fromUser;
@property (nonatomic, strong) PFUser *toUser;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) INSFeed *feed;
@property (nonatomic, strong) INSComment *comment;
@property (nonatomic, strong) INSLike *like;
@property (nonatomic, strong) INSShare *share;
@property (nonatomic, strong) INSFollow *follow;

@end

NS_ASSUME_NONNULL_END
