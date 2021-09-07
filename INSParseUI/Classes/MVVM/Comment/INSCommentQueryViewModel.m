//
//  INSCommentQueryViewModel.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import "INSCommentQueryViewModel.h"

#import "INSParseUIConstants.h"

@interface INSCommentQueryViewModel ()

@property (nonatomic, strong) INSFeed *feed;

@end

@implementation INSCommentQueryViewModel

- (instancetype)initWithFeed:(INSFeed *)feed {
    if (self = [super init]) {
        self.cellIdentifierArray = @[@"INSCommentCell"];
        _feed = feed;
        
        WEAKSELF
        self.queryBlock = ^NSArray<PFObject *> * _Nonnull(NSError *__autoreleasing  _Nullable * _Nullable error) {
            STRONGSELF
            return [INSParseQueryManager queryCommentWithCategory:@(-1) toFeed:strongSelf.feed fromUser:nil page:0 pageCount:5 error:error];
        };
    }
    
    return self;
}

- (void)addComment:(NSString *)content withBlock:(INSBooleanResultBlock)block {
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        STRONGSELF
        BOOL succeeded = NO;
        NSError *error = nil;
        
        succeeded = [INSParseQueryManager addCommentWithCategory:self.feed.category toFeed:self.feed toComment:nil content:content fromUser:[PFUser currentUser] error:&error];

        dispatch_async(dispatch_get_main_queue(), ^{
            block(succeeded, error);
        });
    });
}

@end
