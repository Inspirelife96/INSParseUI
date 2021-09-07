//
//  INSParseQueryManager+Report.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager+Report.h"

#import "INSParseTableDefines.h"

#import "INSReport.h"
#import "INSFeed.h"
#import "INSComment.h"

@implementation INSParseQueryManager (Report)

+ (BOOL)addReportFromUser:(PFUser *)fromUser feed:(INSFeed *)feed comment:(INSComment *)comment reason:(INSParseReportReason)reason error:(NSError **)error {
    INSReport *report = [[INSReport alloc] init];
    report.fromUser = fromUser;
    
    if (feed) {
        report.feed = feed;
        report.type = @(INSParseReportTypeFeed);
    }
    
    if (comment) {
        report.comment = comment;
        report.type = @(INSParseReportTypeComment);
    }
    
    report.reason = @(reason);
    
    return [report save:error];
}

@end
