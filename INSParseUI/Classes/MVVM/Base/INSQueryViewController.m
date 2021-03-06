//
//  INSQueryViewController.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/26.
//

#import "INSQueryViewController.h"

#import "INSObjectCell.h"

#import "INSQueryViewModel.h"

#import "INSParseUIConstants.h"

#import "INSParseErrorHandler.h"

@interface INSQueryViewController ()

@end

@implementation INSQueryViewController

- (instancetype)initWithQueryVM:(INSQueryViewModel *)queryVM {
    if (self = [super init]) {
        self.queryVM = queryVM;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    CGFloat tabbarHeight = 0.0;
    if (self.tabBarController && !self.tabBarController.tabBar.isHidden) {
        tabbarHeight = self.tabBarController.tabBar.bounds.size.height;
    }
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
//
//        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
//        make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
//        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
//        make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
    }];
    
    WEAKSELF
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        STRONGSELF
        [strongSelf loadFirstPage];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        STRONGSELF;
        [strongSelf loadNextPage];
    }];
    
    [self loadFirstPage];
}

#pragma mark - Tab Content for KQTabViewController

- (UIScrollView *)tabContentScrollView {
   return self.tableView;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewAutomaticDimension;
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.queryVM.objectVMArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    INSObjectViewModel *objectVM = self.queryVM.objectVMArray[indexPath.row];
    // ???????????????????????????
    objectVM.indexPath = indexPath;
    
    INSObjectCell *cell = [tableView dequeueReusableCellWithIdentifier:objectVM.cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    [cell configWithObjectVM:objectVM];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - DZNEmptyDataSetSource

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    //return [self kq_prepareLotties:self.queryVM.emptyLottie description:self.queryVM.emptyDescription];
    return nil;
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return self.queryVM.verticalOffsetForEmptyLottie;
}

#pragma mark - Public Methods

- (void)loadFirstPage {
    [self updateUIBeforeLoad];
    
    [self.queryVM loadFirstPageInBackgroundSuccess:^{
        [self updateUIAfterLoad:nil];
    } failure:^(NSError * _Nonnull error) {
        [self updateUIAfterLoad:error];
    }];
    
}

- (void)loadNextPage {
    [self updateUIBeforeLoad];
    
    [self.queryVM loadNextPageInBackgroundSuccess:^{
        [self updateUIAfterLoad:nil];
    } failure:^(NSError * _Nonnull error) {
        [self updateUIAfterLoad:error];
    }];
}

#pragma mark - Private Methods

- (void)updateUIBeforeLoad {
    // ???????????????
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // ????????????
    [self.view setUserInteractionEnabled:NO];
    
    // ??????TabBar?????????
    if (self.tabBarController && self.tabBarController.tabBar.isHidden == NO) {
        [self.tabBarController.view setUserInteractionEnabled:NO];
    }
}

- (void)updateUIAfterLoad:(NSError *)error {
    // ???????????????
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    // ????????????????????????
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    // ????????????????????????????????????????????????????????????????????????????????????????????????????????????
    // ??????????????????????????????????????????????????????
    if (!error) {

    }
    
    if (error) {
        [INSParseErrorHandler handleParseError:error];
    } else {
        // ????????????????????????????????????????????????????????????????????????????????????????????????????????????
        // ??????????????????????????????????????????????????????
        if (self.queryVM.lastLoadCount < self.queryVM.objectsPerPage) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        // ???????????????
        [self.tableView reloadData];
    }
    
    // ??????????????????
    [self.view setUserInteractionEnabled:YES];
    
    // ??????????????????TabBar
    if (self.tabBarController && self.tabBarController.tabBar.isHidden == NO) {
        [self.tabBarController.view setUserInteractionEnabled:YES];
    }
}

#pragma mark - Getter/Setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.theme_backgroundColor = [ThemeColorPicker pickerWithKeyPath:@"UITableView.backgroundColor"];
    }
    
    return _tableView;
}

- (void)setQueryVM:(INSQueryViewModel *)queryVM {
    _queryVM = queryVM;
    
    [queryVM.cellIdentifierArray enumerateObjectsUsingBlock:^(NSString * _Nonnull cellIdentifier, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tableView registerClass:NSClassFromString(cellIdentifier) forCellReuseIdentifier:cellIdentifier];
    }];
}

@end
