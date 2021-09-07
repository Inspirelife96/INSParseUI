//
//  INSQueryViewController.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import <UIKit/UIKit.h>

#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

#import "INSUserInteractionProtocol.h"

@class INSQueryViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSQueryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, INSUserInteractionProtocol>

// UI全交给一个tableView
@property (nonatomic, strong) UITableView *tableView;

// tableView的核心数据源
@property (nonatomic, strong) INSQueryViewModel *queryVM;

// queryVM必须设置
- (instancetype)initWithQueryVM:(INSQueryViewModel *)queryVM;

// 加载首页
- (void)loadFirstPage;

// 加载下一页
- (void)loadNextPage;

@end

NS_ASSUME_NONNULL_END
