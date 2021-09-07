//
//  INSFeedQueryViewModel.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import "INSFeedQueryViewModel.h"

#import "INSParseUIConstants.h"

@implementation INSFeedQueryViewModel

- (instancetype)initQueryFeedWithOrderBy:(NSString *)orderBy {
    if (self = [super init]) {
        [self configDefaultCellIdentifierArray];
        
        WEAKSELF
        self.queryBlock = ^NSArray<PFObject *> * _Nonnull(NSError *__autoreleasing  _Nullable * _Nullable error) {
            STRONGSELF
            return [INSParseQueryManager queryFeedWithCategory:@(1) tag:nil fromUser:nil orderBy:orderBy page:strongSelf.currentPage pageCount:self.objectsPerPage error:error];
        };
    }
    
    return self;
}

- (instancetype)initQueryFeedWithCategory:(NSNumber *)category fromUser:(PFUser *)fromUser {
    if (self = [super init]) {
        [self configDefaultCellIdentifierArray];
        
        WEAKSELF
        self.queryBlock = ^NSArray<PFObject *> * _Nonnull(NSError *__autoreleasing  _Nullable * _Nullable error) {
            STRONGSELF
            return [INSParseQueryManager queryFeedWithCategory:category tag:nil fromUser:fromUser orderBy:@"createdAt" page:strongSelf.currentPage pageCount:self.objectsPerPage error:error];
        };
    }
    
    return self;
}

- (void)configDefaultCellIdentifierArray {
    self.cellIdentifierArray = @[
        @"INSFeedCell",
        @"INSFeedCell0",
        @"INSFeedCell1",
        @"INSFeedCell2",
        @"INSFeedCell3",
        @"INSFeedCell4",
        @"INSFeedCell5",
        @"INSFeedCell6",
        @"INSFeedCell7",
        @"INSFeedCell8",
        @"INSFeedCell9",
    ];
}

@end
