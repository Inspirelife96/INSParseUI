//
//  INSAddFeedViewController.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/1.
//

#import "INSAddFeedViewController.h"

#import "INSTextViewCellViewModel.h"

#import "INSCategory.h"

@interface INSAddFeedViewController() 

@end

@implementation INSAddFeedViewController

#pragma mark ViewController Lifecyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发帖";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(publish:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    
    self.view.theme_backgroundColor = [ThemeColorPicker pickerWithKeyPath:@"UIView.backgroundColor"];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 先判断SelectedTagsCell是否激活
    // 在判断当前显示的tag是否和模型里的一致，不一致则重新加载下tableView
    if (self.addFeedVM.enableSelectedTagsCell) {
        if (![self.addFeedVM.selectedTags isEqualToArray:self.selectedTagsCell.tagView.selectedTags]) {
            [self.tableView reloadData];
        }
    }
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionDescriptionArray[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = self.cellArray[indexPath.section];
    
    if (cell == self.selectedTagsCell) {
        [self.selectedTagsCell configCellWithTags:[self.addFeedVM.selectedTags copy] selectedTags:[self.addFeedVM.selectedTags copy]];
    }
    
    if (cell == self.categoryCell) {
        self.categoryCell.categoryLabel.text = self.categoryArray[[self.addFeedVM.category integerValue]];
    }
    
    if (cell == self.isOriginalCell) {
        [self.isOriginalCell updateCellWithSwitchStatus:self.addFeedVM.isOriginal];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = self.cellArray[indexPath.section];
    if (cell == self.selectedTagsCell) {
        INSTagsViewController *tagVC = [[INSTagsViewController alloc] initWithSelectedTagArray:self.addFeedVM.selectedTags];
        [self.navigationController pushViewController:tagVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = self.cellArray[indexPath.section];
    
    if (cell == self.categoryCell) {
        return 44.0f;
    }
    
    if (cell == self.mediaContentsCell) {
        return [self.addFeedVM heightForMediaContentsCell];
    }
    
    if (cell == self.isOriginalCell) {
        return 44.0f;
    }
    
    if (cell == self.selectedTagsCell) {
        return [self.addFeedVM heightForSelectedTagsCell];
    }
    
    return UITableViewAutomaticDimension;
}

#pragma mark UI Actions

- (void)publish:(UIButton *)sender {
    NSString *errorMessage = @"";
    if (![self.addFeedVM isAbleToPublish:&errorMessage]) {
        [self ins_alertErrorWithTitle:@"发布内容不符合标准" subTitle:errorMessage];
    } else {
        [self.view setUserInteractionEnabled:NO];
        [self.navigationController.navigationBar setUserInteractionEnabled:NO];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        WEAKSELF
        [self.addFeedVM addFeedInBackground:^(BOOL succeeded, NSError * _Nullable error) {
            STRONGSELF
            [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
            [strongSelf.navigationController.navigationBar setUserInteractionEnabled:YES];
            [strongSelf.view setUserInteractionEnabled:YES];
            if (!succeeded) {
                [INSParseErrorHandler handleParseError:error];
            } else {
                SCLAlertView *alertView = [[SCLAlertView alloc] init];
                [alertView addButton:@"了解" actionBlock:^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationFeedAdded object:strongSelf];
                    [strongSelf dismissViewControllerAnimated:YES completion:nil];
                }];
                
                [alertView ins_showInfoOnMostTopViewControllerWithTitle:@"发布成功！" subTitle:@"请注意，发布的内容目前仅发布者自己可见，在管理员审核通过后才可公开可见。" closeButtonTitle:nil duration:0.0];
            }
        }];
    }
}

- (void)cancel:(UIButton *)sender {
    if ([self.addFeedVM needWarningWhenCancel]) {
        SCLAlertView *alertView = [[SCLAlertView alloc] init];
        [alertView addButton:@"放弃" actionBlock:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alertView ins_showWarningOnMostTopViewControllerWithTitle:@"放弃上传？" subTitle:@"已填写的内容将会被废弃！" closeButtonTitle:@"取消" duration:0.0];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark Getter/Setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
    }
    
    return _tableView;
}

- (INSTextViewCell *)titleCell {
    if (!_titleCell) {
        _titleCell = [[INSTextViewCell alloc] init];
        _titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _titleCell.delegate = self;
        _titleCell.autoHeightTextView.text = @"";
    }
    
    return _titleCell;
}

- (INSTextViewCell *)contentCell {
    if (!_contentCell) {
        _contentCell = [[INSTextViewCell alloc] init];
        _contentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _contentCell.delegate = self;
        _contentCell.autoHeightTextView.text = @"";
    }
    
    return _contentCell;
}

- (INSTextViewCell *)forwardFromCell {
    if (!_forwardFromCell) {
        _forwardFromCell = [[INSTextViewCell alloc] init];
        _forwardFromCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _forwardFromCell.delegate = self;
        _forwardFromCell.autoHeightTextView.text = @"";
    }
    
    return _forwardFromCell;
}

- (INSTagsCell *)selectedTagsCell {
    if (!_selectedTagsCell) {
        _selectedTagsCell = [[INSTagsCell alloc] init];
        _selectedTagsCell.tagView.userInteractionEnabled = NO;
    }
    
    return _selectedTagsCell;
}

- (INSDropdownMenuCell *)categoryCell {
    if (!_categoryCell) {
        _categoryCell = [[INSDropdownMenuCell alloc] init];
        _categoryCell.dropdownMenu.delegate = self;
        _categoryCell.dropdownMenu.dataSource = self;
    }
    
    return _categoryCell;
}

- (INSSwitchCell *)isOriginalCell {
    if (!_isOriginalCell) {
        _isOriginalCell = [[INSSwitchCell alloc] init];
        _isOriginalCell.delegate = self;
    }
    
    return _isOriginalCell;
}

- (UITableViewCell *)mediaContentsCell {
    if (!_mediaContentsCell) {
        _mediaContentsCell = [[UITableViewCell alloc] init];
        _mediaContentsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [_mediaContentsCell.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_mediaContentsCell.contentView).with.offset(12.0f);
            make.bottom.equalTo(_mediaContentsCell.contentView).with.offset(-12.0f);
            make.left.equalTo(_mediaContentsCell.contentView).with.offset(20.0f);
            make.right.equalTo(_mediaContentsCell.contentView).with.offset(-20.0f);
        }];
    }
    
    return _mediaContentsCell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_collectionView registerClass:[INSPickedPhotoCell class] forCellWithReuseIdentifier:NSStringFromClass([INSPickedPhotoCell class])];
    }
    
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(self.addFeedVM.collectionViewItemWidth, self.addFeedVM.collectionViewItemWidth);
        _layout.minimumInteritemSpacing = self.addFeedVM.collectionViewItemMargin;
        _layout.minimumLineSpacing = self.addFeedVM.collectionViewItemMargin;
    }
    
    return _layout;
}

- (NSArray *)cellArray {
    if (!_cellArray) {
        _cellArray = @[];
    }
    
    return _cellArray;
}

- (NSArray *)sectionDescriptionArray {
    if (!_sectionDescriptionArray) {
        _sectionDescriptionArray = @[];
    }
    
    return _sectionDescriptionArray;
}

- (NSArray *)categoryArray {
    if (!_categoryArray) {
        _categoryArray = [INSCategory categoryNameArray];
    }
    
    return _categoryArray;
}

// 根据VM来组装应该显示的Cell
- (void)setAddFeedVM:(INSAddFeedViewModel *)addFeedVM {
    _addFeedVM = addFeedVM;
    
    NSMutableArray *mutalbeCellArray = [[NSMutableArray alloc] init];
    NSMutableArray *mutableSectionDescriptionArray = [[NSMutableArray alloc] init];
    
    if (addFeedVM.enableCategoryCell) {
        [mutalbeCellArray addObject:self.categoryCell];
        [mutableSectionDescriptionArray addObject:self.addFeedVM.categoryCellDescription];
    }
    
    if (addFeedVM.enableTitleCell) {
        [mutalbeCellArray addObject:self.titleCell];
        [mutableSectionDescriptionArray addObject:self.addFeedVM.titleCellVM.cellDescription];
        [self.titleCell configWithTextViewCellVM:self.addFeedVM.titleCellVM];
    }
    
    if (addFeedVM.enableContentCell) {
        [mutalbeCellArray addObject:self.contentCell];
        [mutableSectionDescriptionArray addObject:self.addFeedVM.contentCellVM.cellDescription];
        [self.contentCell configWithTextViewCellVM:self.addFeedVM.contentCellVM];
    }
    
    if (addFeedVM.enableForwardFromCell) {
        [mutalbeCellArray addObject:self.forwardFromCell];
        [mutableSectionDescriptionArray addObject:self.addFeedVM.forwardFromCellVM.cellDescription];
        [self.forwardFromCell configWithTextViewCellVM:self.addFeedVM.forwardFromCellVM];
    }
    
    if (addFeedVM.enableIsOriginalCell) {
        [mutalbeCellArray addObject:self.isOriginalCell];
        [mutableSectionDescriptionArray addObject:self.addFeedVM.isOriginalCellDescription];
        self.isOriginalCell.textLabel.text = self.addFeedVM.isOriginalCellTitle;
        [self.isOriginalCell updateCellWithSwitchStatus:self.addFeedVM.isOriginal];
    }
    
    if (addFeedVM.enableMediaContentsCell) {
        [mutalbeCellArray addObject:self.mediaContentsCell];
        [mutableSectionDescriptionArray addObject:self.addFeedVM.mediaContentsCellDescription];
    }
    
    if (addFeedVM.enableSelectedTagsCell) {
        [mutalbeCellArray addObject:self.selectedTagsCell];
        [mutableSectionDescriptionArray addObject:self.addFeedVM.selectedTagsCellDescription];
        self.selectedTagsCell.placeholderLabel.text = self.addFeedVM.selectedTagsCellPlaceHolder;
    }
    
    self.cellArray = [mutalbeCellArray copy];
    self.sectionDescriptionArray = [mutableSectionDescriptionArray copy];
    
    [self.tableView reloadData];
}

@end
