//
//  INSReport.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSReport.h"

#import <Parse/PFObject+Subclass.h>

#import "INSParseTableDefines.h"

@implementation INSReport

@dynamic fromUser;
@dynamic type;
@dynamic reason;
@dynamic feed;
@dynamic comment;

+ (NSString *)parseClassName {
    return kReportClassKey;
}

@end

