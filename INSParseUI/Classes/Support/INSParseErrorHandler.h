//
//  INSParseErrorHandler.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSParseErrorHandler : NSObject

+ (void)handleParseError:(NSError *)error;

+ (NSString *)errorMessage:(PFErrorCode)errorCode;

@end

NS_ASSUME_NONNULL_END
