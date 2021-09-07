#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "INSActivity.h"
#import "INSComment.h"
#import "INSFeed.h"
#import "INSFollow.h"
#import "INSFollowInfo.h"
#import "INSLike.h"
#import "INSParseQueryManager+Activity.h"
#import "INSParseQueryManager+Comment.h"
#import "INSParseQueryManager+Feed.h"
#import "INSParseQueryManager+Follow.h"
#import "INSParseQueryManager+Like.h"
#import "INSParseQueryManager+Report.h"
#import "INSParseQueryManager+Share.h"
#import "INSParseQueryManager+User.h"
#import "INSParseQueryManager.h"
#import "INSParseTableDefines.h"
#import "INSReport.h"
#import "INSShare.h"

FOUNDATION_EXPORT double INSParseVersionNumber;
FOUNDATION_EXPORT const unsigned char INSParseVersionString[];

