//
//  INSTagsViewController.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/2.
//

#import "INSTagsViewController.h"

#import "INSTagsCell.h"
#import "JCTagListView.h"

#import "INSTag.h"

@interface INSTagsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <INSTagsCell *> *tagsCellArray;
@property (nonatomic, strong) NSArray <NSNumber *> *tagsCellHeightArray;

@property (nonatomic, strong) NSMutableArray *selectedTagArray;

@property (nonatomic, strong) JCTagListView *tagListView;

@end

@implementation INSTagsViewController

#pragma mark UIViewcontroller LifeCycle

- (instancetype)initWithSelectedTagArray:(NSMutableArray *)selectedTagArray {
    if (self = [super init]) {
        _selectedTagArray = selectedTagArray;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"标签";
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.selectedTagArray removeAllObjects];

    [self.tagsCellArray enumerateObjectsUsingBlock:^(INSTagsCell * _Nonnull tagsCell, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.selectedTagArray addObjectsFromArray:tagsCell.tagView.selectedTags];
    }];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [INSTag tagsGroupNameArray][section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[INSTag tagsGroupNameArray] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    INSTagsCell *cell = self.tagsCellArray[indexPath.section];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.tagsCellHeightArray[indexPath.section] floatValue];
}


#pragma mark Getter/Setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen jk_width], [UIScreen jk_height]) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.allowsSelection = NO;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [_tableView registerClass:[INSTagsCell class] forCellReuseIdentifier:NSStringFromClass([INSTagsCell class])];
    }
    
    return _tableView;
}

- (NSArray <INSTagsCell *> *)tagsCellArray {
    if (!_tagsCellArray) {
        NSArray *tagsNameArray = [INSTag tagsNameArray];
        
        NSMutableArray *tempTagsCellArray = [[NSMutableArray alloc] init];
        
        for (NSInteger i = 0; i < tagsNameArray.count; i++) {
            INSTagsCell *tagsCell = [[INSTagsCell alloc] init];
            
            // 获得这个Cell需要展示的tags
            NSArray *tags = tagsNameArray[i];
            
            // 和已经选择的标签做交，获得这个Cell中被选中的tags
            NSMutableSet *set1 = [NSMutableSet setWithArray:tags];
            NSMutableSet *set2 = [NSMutableSet setWithArray:self.selectedTagArray];
            [set2 intersectSet:set1];
            NSArray *selectedTags = [set2 allObjects];
            
            [tagsCell configCellWithTags:tags selectedTags:[selectedTags mutableCopy]];
            
            [tempTagsCellArray addObject:tagsCell];
        }
        
        _tagsCellArray = [tempTagsCellArray copy];
    }
    
    return _tagsCellArray;
}

- (NSArray <NSNumber *> *)tagsCellHeightArray {
    if (!_tagsCellHeightArray) {
        CGFloat cellPadding = 10.0f;

        NSArray *tagsNameArray = [INSTag tagsNameArray];
        
        NSMutableArray *tempTagsCellHeightArray = [[NSMutableArray alloc] init];
                
        for (NSInteger i = 0; i < tagsNameArray.count; i++) {
            NSArray *tags = tagsNameArray[i];
            self.tagListView.tags = tags;
            [tempTagsCellHeightArray addObject:@(self.tagListView.contentHeight + cellPadding * 2)];
        }
        
        _tagsCellHeightArray = [tempTagsCellHeightArray copy];
    }
    
    return _tagsCellHeightArray;
}

- (JCTagListView *)tagListView {
    if (!_tagListView) {
        _tagListView = [[JCTagListView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 24.0f, 0)];
    }
    
    return _tagListView;
}

@end
