//
//  INSFollowInfo.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import "INSFollowInfo.h"

#import "INSParseTableDefines.h"

@implementation INSFollowInfo

@dynamic followCount;
@dynamic followedCount;
@dynamic user;

+ (NSString *)parseClassName {
    return kFollowInfoClassKey;
}

@end
