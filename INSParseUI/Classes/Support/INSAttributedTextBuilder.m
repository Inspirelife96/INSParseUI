//
//  INSAttributedTextBuilder.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/29.
//

#import "INSAttributedTextBuilder.h"

#import "ThemeManager+INS_AttributedText.h"

NSString *const attributedTextFormatFeed = @"%@ 由 %@ 发布";
NSString *const attributedTextFormatComment = @"%@ 由 %@ 评论";
NSString *const attributedTextFormatFollow = @"%@  ｜  %@";

@implementation INSAttributedTextBuilder

+ (NSAttributedString *)buildPostTimeInfo:(NSString *)postTimeInfo
                             fromUserName:(NSString *)fromUserName
                     attributedTextFormat:(NSString *)attributedTextFormat
                        tapUserNameAction:(void(^)(void))tapUserNameAction {
    NSString *reformedAttributedTextFormat = [NSString stringWithFormat:attributedTextFormat, postTimeInfo, @"%@"];
    
    return [INSAttributedTextBuilder _buildTapString:fromUserName attributedTextFormat:reformedAttributedTextFormat tapAction:^{
        tapUserNameAction();
    }];
}

+ (NSAttributedString *)buildReportWithtapAction:(void(^)(void))tapAction {
    NSString *reportString = @"🙋‍♂️";
    
    return [INSAttributedTextBuilder _buildTapString:reportString attributedTextFormat:@"%@" tapAction:^{
        tapAction();
    }];
}

+ (NSAttributedString *)buildFeedStatus:(NSNumber *)feedStatus tapAction:(void(^)(void))tapAction {
    NSString *reviewStatusString = @"🔒";

    if ([feedStatus isEqualToNumber:@1]) {
        reviewStatusString = @"🙆‍♂";
    } else if ([feedStatus isEqualToNumber:@2]) {
        reviewStatusString = @"🙅‍♂️";
    } else {
        //
    }

    return [INSAttributedTextBuilder _buildTapString:reviewStatusString attributedTextFormat:@"%@" tapAction:^{
        tapAction();
    }];
}

+ (NSAttributedString *)buildCommentStatus:(BOOL)isDeletable tapAction:(void(^)(void))tapAction {
    NSString *commentStatusString = @"🙋‍♂";
    if (isDeletable) {
        commentStatusString = @"🗑";
    }

    return [INSAttributedTextBuilder _buildTapString:commentStatusString attributedTextFormat:@"%@" tapAction:^{
        tapAction();
    }];
}

+ (NSAttributedString *)buildFollow:(NSInteger)follow followed:(NSInteger)followed tapFollowAction:(void(^)(void))tapFollowAction tapFollowedAction:(void(^)(void))tapFollowedAction {
    NSString *followString = [NSString stringWithFormat:@"关注 %ld", follow];
    NSString *followedString = [NSString stringWithFormat:@"粉丝 %ld", followed];
    
    return [INSAttributedTextBuilder _buildTap1String:followString Tap2String:followedString attributedTextFormat:attributedTextFormatFollow tap1Action:^{
        tapFollowAction();
    } tap2Action:^{
        tapFollowedAction();
    }];
}

+ (NSAttributedString *)_buildTapString:(NSString *)tapString
                   attributedTextFormat:(NSString *)attributedTextFormat
                              tapAction:(void(^)(void))tapAction  {
    NSString *text = [NSString stringWithFormat:attributedTextFormat, tapString];
        
    NSDictionary *attributes = @{NSFontAttributeName:[ThemeManager textFont], NSForegroundColorAttributeName: [ThemeManager textColor]};
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    NSRange tapStringRange = [[attributedText string] rangeOfString:tapString];
    
    [attributedText yy_setTextHighlightRange:tapStringRange color:[ThemeManager highlightTextColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        tapAction();
    }];
    
    [attributedText yy_setFont:[ThemeManager hightlightTextFont] range:tapStringRange];
    
    return attributedText;
}

+ (NSAttributedString *)_buildTap1String:(NSString *)tap1String Tap2String:(NSString *)tap2String attributedTextFormat:(NSString *)attributedTextFormat tap1Action:(void(^)(void))tap1Action tap2Action:(void(^)(void))tap2Action {
    NSString *text = [NSString stringWithFormat:attributedTextFormat, tap1String, tap2String];
    NSDictionary *attributes = @{NSFontAttributeName:[ThemeManager textFont], NSForegroundColorAttributeName: [ThemeManager textColor]};
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    NSRange tap1StringRange = [[attributedText string] rangeOfString:tap1String];
    
    [attributedText yy_setTextHighlightRange:tap1StringRange color:[ThemeManager highlightTextColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        tap1Action();
    }];
    
    [attributedText yy_setFont:[ThemeManager hightlightTextFont] range:tap1StringRange];
    
    NSRange tap2StringRange = [[attributedText string] rangeOfString:tap2String options:NSBackwardsSearch];
    [attributedText yy_setTextHighlightRange:tap2StringRange color:[ThemeManager highlightTextColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        tap2Action();
    }];
    
    [attributedText yy_setFont:[ThemeManager hightlightTextFont] range:tap2StringRange];

    return attributedText;
}

@end
