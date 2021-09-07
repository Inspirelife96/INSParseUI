//
//  INSObjectViewModel.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import "INSObjectViewModel.h"

#import "INSFeedViewModel.h"
#import "INSCommentViewModel.h"
#import "INSLikeViewModel.h"

@implementation INSObjectViewModel

@synthesize cellIdentifier;

@synthesize indexPath;

+ (instancetype)createViewModel:(PFObject *)object error:(NSError **)error {
    if ([object isKindOfClass:[INSFeed class]]) {
        
        return [[INSFeedViewModel alloc] initWithFeed:(INSFeed *)object error:error];
        
    }
    
    if ([object isKindOfClass:[INSComment class]]) {
        
        return [[INSCommentViewModel alloc] initWithComment:(INSComment *)object recurrenceIfToComment:YES error:error];
    }
    
//    if ([object isKindOfClass:[INSFeed class]]) {
//
//        return [[INSFeedViewModel alloc] initWithArticleObject:(PFArticleObject *)object];
//
//    } else if ([object isKindOfClass:[PFCommentObject class]]) {
//
//        return [[PFCommentObjectViewModel alloc] initWithCommentObject:(PFCommentObject *)object];
//
//    } else if ([object isKindOfClass:[PFQuestionObject class]]) {
//
//        return [[PFQuestionObjectViewModel alloc] initWithQuestionObject:(PFQuestionObject *)object];
//
//    } else if ([object isKindOfClass:[PFAnswerObject class]]) {
//
//        return [[PFAnswerObjectViewModel alloc] initWithAnswerObject:(PFAnswerObject *)object];
//
//    } else if ([object isKindOfClass:[PFActivityObject class]]) {
//
//        return [[PFActivityObjectViewModel alloc] initWithActivityObject:(PFActivityObject *)object];
//
//    }
    
    
    
    return [[INSObjectViewModel alloc] init];
    
//    NSString *objectClassString = NSStringFromClass([object class]);
//
//    NSString *objectViewModelClassString = [NSString stringWithFormat:@"%@ViewModel", objectClassString];
    
    //return [[(NSClassFromString(objectViewModelClassString)) alloc] initWithObject:object];
    
    
    
//    if ([object isKindOfClass:[PFArticleObject class]]) {
//
//        return [[PFArticleObjectViewModel alloc] initWithArticleObject:(PFArticleObject *)object];
//
//    } else if ([object isKindOfClass:[PFCommentObject class]]) {
//
//        return [[PFCommentObjectViewModel alloc] initWithCommentObject:(PFCommentObject *)object];
//
//    } else if ([object isKindOfClass:[PFQuestionObject class]]) {
//
//        return [[PFQuestionObjectViewModel alloc] initWithQuestionObject:(PFQuestionObject *)object];
//
//    } else if ([object isKindOfClass:[PFAnswerObject class]]) {
//
//        return [[PFAnswerObjectViewModel alloc] initWithAnswerObject:(PFAnswerObject *)object];
//
//    } else if ([object isKindOfClass:[PFActivityObject class]]) {
//
//        return [[PFActivityObjectViewModel alloc] initWithActivityObject:(PFActivityObject *)object];
//
//    } else if ([object isKindOfClass:[PFTopicObject class]]) {
//
//        return [[PFTopicObjectViewModel alloc] initWithTopicObject:(PFTopicObject *)object];
//
//    } else if ([object isKindOfClass:[PFGuideObject class]]) {
//
//        return [[PFGuideObjectViewModel alloc] initWithGuideObject:(PFGuideObject *)object];
//
//    }
    

}

- (void)bindCellIdentifier:(NSArray<NSString *> *)registeredIdentifierArray {
    if (registeredIdentifierArray.count == 1) {
        self.cellIdentifier = registeredIdentifierArray[0];
    } else {
        self.cellIdentifier = @"INSObjectCell";
    }
}



@end
