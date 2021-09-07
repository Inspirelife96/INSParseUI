//
//  INSActivityViewModel.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/6.
//

#import "INSActivityViewModel.h"

#import "INSFeedViewModel.h"
#import "INSCommentViewModel.h"
#import "INSLikeViewModel.h"

@implementation INSActivityViewModel

- (instancetype)initWithActivity:(INSActivity *)activity error:(NSError **)error {
    if (self = [super init]) {
        _activity = activity;
        
        _fromUser = activity.fromUser;
        [self.fromUser fetchIfNeeded:error];
        if (*error) {
            return nil;
        }
        
        _fromUserName = _fromUser.username;

        _type = activity.type;

//        if ([_type integerValue] == INSParseActivityTypeAddComment) {
//
//            INSComment *comment = activity.comment;
//            [comment fetchIfNeeded:error];
//            if (*error) {
//                return nil;
//            }
//
//            _commentVM = [[INSCommentViewModel alloc] initWithComment:comment recurrenceIfToComment:YES error:error];
//            if (*error) {
//                return nil;
//            }
//
//            _feedVM = _commentVM.feedVM;
//
//        } else if ([activity.type isEqualToString:@"like"]) {
//            INSLike *like = activity.like;
//            [like fetchIfNeeded:error];
//            if (*error) {
//                return nil;
//            }
//
//            _likeVM = [[INSLikeViewModel alloc] initWithLike:like error:error];
//            if (*error) {
//                return nil;
//            }
//
//            _feedVM = _likeVM.feedViewModel;
//
//        } else if ([self isArticleReviewActivity:self.activityType]) {
//
////            PFArticleObject *articleObject = activity.article;
////            [articleObject fetchIfNeeded];
////            _articleObjectVM = [[PFArticleObjectViewModel alloc] initWithArticleObject:articleObject];
//
//        } else if ([self isQuertionReviewActivity:self.activityType]) {
//
////            PFQuestionObject *questionObject = activity.question;
////            [questionObject fetchIfNeeded];
////            _questionObjectVM = [[PFQuestionObjectViewModel alloc] initWithQuestionObject:questionObject];
//
//        } else {
//            // Do nothing for Follow
//        }
    }
    
    return self;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    [super setIndexPath:indexPath];
    
//    self.commentObjectVM.indexPath = indexPath;
//    self.answerObjectVM.indexPath = indexPath;
//    self.likeOjbectVM.indexPath = indexPath;
//    self.markObjectVM.indexPath = indexPath;
//    self.articleObjectVM.indexPath = indexPath;
//    self.questionObjectVM.indexPath = indexPath;
}

- (BOOL)isQuertionReviewActivity:(NSString *)activityType {
    NSRange range = [activityType rangeOfString:@"questionReview"];
    if (range.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)isArticleReviewActivity:(NSString *)activityType {
    NSRange range = [activityType rangeOfString:@"articleReview"];
    if (range.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }

}

@end
