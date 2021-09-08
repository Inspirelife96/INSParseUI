//
//  INSLike.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import "INSLike.h"

#import <Parse/PFObject+Subclass.h>

#import "INSParseTableDefines.h"

@implementation INSLike

@dynamic category;

@dynamic type;
@dynamic toFeed;
@dynamic toComment;
@dynamic fromUser;

+ (NSString *)parseClassName {
    return kLikeClassKey;
}

@end
