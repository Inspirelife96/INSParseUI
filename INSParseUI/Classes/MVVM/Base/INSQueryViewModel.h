//
//  INSQueryViewModel.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import <Foundation/Foundation.h>

#import "INSObjectViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSArray<PFObject *> * _Nonnull (^QueryBlock)(NSError **error);

@interface INSQueryViewModel : NSObject

// 核心， 查询
@property (nonatomic, copy) QueryBlock queryBlock;

// cell数据模型
@property (nonatomic, strong) NSArray<INSObjectViewModel *> *objectVMArray;

// cell identifier
@property (nonatomic, strong) NSArray<NSString *> *cellIdentifierArray;

// 分页
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) NSUInteger objectsPerPage;

// 总计
@property (nonatomic, assign) NSUInteger lastLoadCount;
@property (nonatomic, assign) NSUInteger totalLoadCount;

// 空数据时的处理，Lottie支持
@property (nonatomic, strong) NSString *emptyLottie;
@property (nonatomic, strong) NSString *emptyDescription;
@property (nonatomic, assign) CGFloat verticalOffsetForEmptyLottie;

// 加载首页数据
- (void)loadFirstPageInBackgroundSuccess:(nullable void (^)(void))success
                                 failure:(nullable void (^)(NSError *error))failure;

// 加载下一页数据
- (void)loadNextPageInBackgroundSuccess:(nullable void (^)(void))success
                                failure:(nullable void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
