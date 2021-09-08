//
//  INSArticle.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/8/28.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSArticle : PFObject <PFSubclassing>

@property (nonatomic, strong) PFFileObject *contentFile;
@property (nonatomic, strong) NSString *originalLink;

@end

NS_ASSUME_NONNULL_END
