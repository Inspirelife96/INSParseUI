//
//  INSFollow.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import "INSFollow.h"

#import <Parse/PFObject+Subclass.h>

#import "INSParseTableDefines.h"

@implementation INSFollow

@dynamic fromUser;
@dynamic toUser;

+ (NSString *)parseClassName {
    return kFollowClassKey;
}

@end
