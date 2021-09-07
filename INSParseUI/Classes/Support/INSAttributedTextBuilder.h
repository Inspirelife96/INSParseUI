//
//  INSAttributedTextBuilder.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/29.
//

#import <Foundation/Foundation.h>

extern NSString *const attributedTextFormatFeed;
extern NSString *const attributedTextFormatComment;
extern NSString *const attributedTextFormatFollow;

NS_ASSUME_NONNULL_BEGIN

@interface INSAttributedTextBuilder : NSObject

+ (NSAttributedString *)buildPostTimeInfo:(NSString *)postTimeInfo
                             fromUserName:(NSString *)fromUserName
                     attributedTextFormat:(NSString *)attributedTextFormat
                        tapUserNameAction:(void(^)(void))tapUserNameAction;

+ (NSAttributedString *)buildReportWithtapAction:(void(^)(void))tapAction;

+ (NSAttributedString *)buildFeedStatus:(NSNumber *)feedStatus tapAction:(void(^)(void))tapAction;

+ (NSAttributedString *)buildCommentStatus:(BOOL)isDeletable tapAction:(void(^)(void))tapAction;

+ (NSAttributedString *)buildFollow:(NSInteger)follow followed:(NSInteger)followed tapFollowAction:(void(^)(void))tapFollowAction tapFollowedAction:(void(^)(void))tapFollowedAction;

@end

NS_ASSUME_NONNULL_END
