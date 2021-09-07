//
//  INSQueryViewModel.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import "INSQueryViewModel.h"

#import "INSParseUIConstants.h"

#import "INSObjectViewModel.h"

@implementation INSQueryViewModel

- (instancetype)init {
    if (self = [super init]) {
        _currentPage = 0;
        _objectsPerPage = 5;
        _lastLoadCount = 0;
        _totalLoadCount = 0;
        _objectVMArray = @[];
        
        _emptyLottie = @"kuqi_lottie";
        _emptyDescription = @"加载中";
        _verticalOffsetForEmptyLottie = 0.0f;
        
        _queryBlock = ^NSArray<PFObject *> * _Nonnull(NSError *__autoreleasing  _Nullable * _Nullable error) {
            return  @[];
        };
    }
    
    return self;
}

- (void)loadFirstPageInBackgroundSuccess:(nullable void (^)(void))success
                                 failure:(nullable void (^)(NSError *error))failure {
    _currentPage = 0;
    _lastLoadCount = 0;
    _totalLoadCount = 0;
    
    [self loadDataInBackgroundSuccess:^{
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadNextPageInBackgroundSuccess:(nullable void (^)(void))success
                                failure:(nullable void (^)(NSError *error))failure {
    _currentPage++;
    
    [self loadDataInBackgroundSuccess:^{
        success();
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)loadDataInBackgroundSuccess:(nullable void (^)(void))success
                            failure:(nullable void (^)(NSError *error))failure {
    WEAKSELF
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        STRONGSELF
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
        
        // 当前如果不是第一页，copy已经获取的数据
        if (self.currentPage != 0) {
            [mutableArray addObjectsFromArray:strongSelf.objectVMArray];
        }
        
        NSError *error = nil;

        // 执行查询，由子类自己定义需要查询的内容
        NSArray<PFObject *> *lastLoadArray = strongSelf.queryBlock(&error);
        
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.emptyDescription = @"加载失败";
                failure(error);
            });
        } else {
            // 成功的话
            // 将查询的数据转成ViewModel，追加到数组尾部
            for (NSInteger i = 0; i < lastLoadArray.count; i++) {
                PFObject *object = lastLoadArray[i];
                
                INSObjectViewModel *objectVM = [INSObjectViewModel createViewModel:object error:&error];
                
                // 出错则
                if (error) {
                    strongSelf.emptyDescription = @"加载失败";
                    failure(error);
                    return;
                } else {
                    [objectVM bindCellIdentifier:self.cellIdentifierArray];
                    [mutableArray addObject:objectVM];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新Table的数据源，必须放入主线程中。
                // 如果在子线程中更行，容易导致table刷新过程中，对应的数据源被更新，而导致crash。
                strongSelf.objectVMArray = [mutableArray copy];
                strongSelf.lastLoadCount = lastLoadArray.count;
                strongSelf.totalLoadCount = strongSelf.objectVMArray.count;
                
                // 如果是没有查询到任何内容，设置空内容
                if (strongSelf.totalLoadCount == 0) {
                    strongSelf.emptyDescription = @"没有发现任何内容";
                }

                success();
            });
        }
    });
}

@end
