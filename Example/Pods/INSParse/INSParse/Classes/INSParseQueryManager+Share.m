//
//  INSParseQueryManager+Share.m
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import "INSParseQueryManager+Share.h"

#import "INSParseTableDefines.h"
#import "INSShare.h"
#import "INSActivity.h"

#import "INSParseQueryManager+Activity.h"

@implementation INSParseQueryManager (Share)

+ (BOOL)addShareWithCategory:(NSNumber *)category
                        Feed:(INSFeed *)feed
                  toPlatform:(NSString *)toPlatform
                    fromUser:(PFUser *)fromUser
                       error:(NSError **)error {
    INSShare *share = [[INSShare alloc] init];
    share.category = category;
    share.feed = feed;
    share.toPlatform = toPlatform;
    share.fromUser = fromUser;
    
    BOOL succeeded = [share save:error];
    
    if (succeeded) {
        return [INSParseQueryManager addShareActivity:share error:error];
    } else {
        return succeeded;
    }
}

@end
