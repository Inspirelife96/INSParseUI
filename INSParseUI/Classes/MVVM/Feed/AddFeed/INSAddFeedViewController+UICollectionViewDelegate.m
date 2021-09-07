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
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = self.addFeedVM.selectedAssets; // 目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按

    // 2. 在这里设置imagePickerVc的外观
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    
    // 5. Single selection mode, valid when maxImagesCount = 1
    // 5. 单选模式,maxImagesCount为1时才生效

    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = self.view.jk_width - 2 * left;
    NSInteger top = (self.view.jk_height - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.scaleAspectFillCrop = YES;

    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置是否显示图片序号
    imagePickerVc.showSelectedIndex = YES;
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [self.collectionView reloadData];
        [self.tableView reloadData];
    }];
    
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

@end
