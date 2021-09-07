//
//  INSComment.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import "INSComment.h"

#import <Parse/PFObject+Subclass.h>

#import "INSParseTableDefines.h"

@implementation INSComment

@dynamic category;

@dynamic toFeed;
@dynamic toComment;
@dynamic content;
@dynamic fromUser;

+ (NSString *)parseClassName {
    return kCommentClassKey;
}

@end
