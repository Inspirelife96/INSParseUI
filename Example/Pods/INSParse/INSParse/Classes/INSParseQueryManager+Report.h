//
//  INSParseQueryManager+Report.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager.h"

#import "INSParseTableDefines.h"

@class INSFeed;
@class INSComment;

NS_ASSUME_NONNULL_BEGIN

@interface INSParseQueryManager (Report)

+ (BOOL)addReportFromUser:(PFUser *)fromUser feed:(INSFeed *)feed comment:(INSComment *)comment reason:(INSParseReportReason)reason error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
