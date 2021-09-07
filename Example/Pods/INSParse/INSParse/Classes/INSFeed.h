//
//  INSFeed.h
//  INSParse
//
//  Created by XueFeng Chen on 2021/6/22.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface INSFeed : PFObject <PFSubclassing>

// 标记
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *category;

// 核心字段：
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray<PFFileObject *> *mediaContents;
@property (nonatomic, strong) PFUser *fromUser;

// 来源和转发 （目前不考虑转发功能）
@property (nonatomic, assign) BOOL isOriginal;
@property (nonatomic, copy) NSString *forwardFrom; // 应该是objectId

// 统计字段：
@property (nonatomic, strong) NSNumber *commentCount;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *shareCount;

// 辅助
@property (nonatomic, strong) NSArray<NSString *> *tags;

// 扩展 可自行定义
@property (nonatomic, strong) id extend1;
@property (nonatomic, strong) id extend2;
@property (nonatomic, strong) id extend3;
@property (nonatomic, strong) id extend4;
@property (nonatomic, strong) id extend5;
@property (nonatomic, strong) id extend6;

@end

NS_ASSUME_NONNULL_END
