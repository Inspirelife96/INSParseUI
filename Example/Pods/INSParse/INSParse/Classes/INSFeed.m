//
//  INSFeed.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import "INSFeed.h"

#import <Parse/PFObject+Subclass.h>

#import "INSParseTableDefines.h"

@implementation INSFeed

@dynamic status;
@dynamic category;

@dynamic title;
@dynamic content;
@dynamic mediaContents;
@dynamic fromUser;

@dynamic isOriginal;
@dynamic forwardFrom;

@dynamic commentCount;
@dynamic likeCount;
@dynamic shareCount;

@dynamic tags;

@dynamic extend1;
@dynamic extend2;
@dynamic extend3;
@dynamic extend4;
@dynamic extend5;
@dynamic extend6;

+ (NSString *)parseClassName {
    return kFeedClassKey;
}

@end
