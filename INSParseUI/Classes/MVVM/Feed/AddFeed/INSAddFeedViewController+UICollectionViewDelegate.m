//
//  INSAddFeedViewController+UICollectionViewDelegate.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/3.
//

#import "INSAddFeedViewController+UICollectionViewDelegate.h"

@implementation INSAddFeedViewController (UICollectionViewDelegate)

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (![self.addFeedVM isSelectedPhotoReachesMax] && indexPath.item == self.addFeedVM.selectedPhotos.count) {
        [self _pushTZImagePickerController];
    } else {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:self.addFeedVM.selectedAssets selectedPhotos:self.addFeedVM.selectedPhotos index:indexPath.item];
        imagePickerVc.maxImagesCount = self.addFeedVM.maxSelectedPhotoCount;
        imagePickerVc.allowPickingGif = NO;
        imagePickerVc.autoSelectCurrentWhenDone = NO;
        imagePickerVc.allowPickingOriginalPhoto = NO;
        imagePickerVc.allowPickingMultipleVideo = NO;
        imagePickerVc.showSelectedIndex = YES;
        imagePickerVc.isSelectOriginalPhoto = self.addFeedVM.isSelectOriginalPhoto;
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            self.addFeedVM.selectedPhotos = [NSMutableArray arrayWithArray:photos];
            self.addFeedVM.selectedAssets = [NSMutableArray arrayWithArray:assets];
            self.addFeedVM.isSelectOriginalPhoto = isSelectOriginalPhoto;
            [self.collectionView reloadData];
        }];
        
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

- (void)_pushTZImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.addFeedVM.maxSelectedPhotoCount columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.isSelectOriginalPhoto = self.addFeedVM.isSelectOriginalPhoto;
    
    if (self.addFeedVM.maxSelectedPhotoCount > 1) {
        // 1.???????????????????????????????????????
        imagePickerVc.selectedAssets = self.addFeedVM.selectedAssets; // ?????????????????????????????????
    }
    imagePickerVc.allowTakePicture = YES; // ???????????????????????????
    imagePickerVc.allowTakeVideo = NO;   // ???????????????????????????

    // 2. ???????????????imagePickerVc?????????
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    // 3. ??????????????????????????????/??????/??????
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO; // ????????????????????????
    
    // 4. ?????????????????????????????????
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    
    // 5. Single selection mode, valid when maxImagesCount = 1
    // 5. ????????????,maxImagesCount???1????????????

    // ??????????????????????????????
    NSInteger left = 30;
    NSInteger widthHeight = self.view.jk_width - 2 * left;
    NSInteger top = (self.view.jk_height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.scaleAspectFillCrop = YES;

    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // ??????????????????????????????
    imagePickerVc.showSelectedIndex = YES;
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [self.collectionView reloadData];
        [self.tableView reloadData];
    }];
    
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

@end
