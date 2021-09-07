//
//  INSAddFeedViewController+UICollectionViewDataSource.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/3.
//

#import "INSAddFeedViewController+UICollectionViewDataSource.h"

@implementation INSAddFeedViewController (UICollectionViewDataSource)

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.addFeedVM numberOfItemsInSectionOfCollectionView];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    INSPickedPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([INSPickedPhotoCell class]) forIndexPath:indexPath];

    if (![self.addFeedVM isSelectedPhotoReachesMax] && indexPath.item == self.addFeedVM.selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"albumAddBtn.png"];
        cell.deleteButton.hidden = YES;
    } else {
        cell.imageView.image = self.addFeedVM.selectedPhotos[indexPath.item];
        cell.asset = self.addFeedVM.selectedAssets[indexPath.item];
        cell.deleteButton.hidden = NO;
    }

    cell.deleteButton.tag = indexPath.item;
    [cell.deleteButton addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)clickDeleteButton:(UIButton *)sender {
//    NSInteger numberOfItems = [self collectionView:self.collectionView numberOfItemsInSection:0];
//    if (numberOfItems <= self.addFeedVM.selectedPhotos.count) {
//        [self.addFeedVM.selectedPhotos removeObjectAtIndex:sender.tag];
//        [self.addFeedVM.selectedAssets removeObjectAtIndex:sender.tag];
//        [self.collectionView reloadData];
//        return;
//    }
    
    [self.addFeedVM.selectedPhotos removeObjectAtIndex:sender.tag];
    [self.addFeedVM.selectedAssets removeObjectAtIndex:sender.tag];
    [self.collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self.collectionView reloadData];
        [self.tableView reloadData];
    }];
}

@end
