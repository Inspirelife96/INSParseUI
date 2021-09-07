//
//  INSShare.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import "INSShare.h"

#import <Parse/PFObject+Subclass.h>

#import "INSParseTableDefines.h"

@implementation INSShare

@dynamic category;

@dynamic feed;
@dynamic toPlatform;
@dynamic fromUser;

+ (NSString *)parseClassName {
    return kShareClassKey;
}

@end
