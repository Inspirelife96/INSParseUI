//
//  INSActivity.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import "INSActivity.h"

#import <Parse/PFObject+Subclass.h>

#import "INSParseTableDefines.h"

@implementation INSActivity

@dynamic fromUser;
@dynamic toUser;
@dynamic type;
@dynamic feed;
@dynamic comment;
@dynamic like;
@dynamic share;
@dynamic follow;

+ (NSString *)parseClassName {
    return kActivityClassKey;
}

@end
