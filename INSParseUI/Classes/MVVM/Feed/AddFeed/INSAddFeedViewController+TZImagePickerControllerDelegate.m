//
//  INSAddFeedViewController+TZImagePickerControllerDelegate.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/3.
//

#import "INSAddFeedViewController+TZImagePickerControllerDelegate.h"

@implementation INSAddFeedViewController (TZImagePickerControllerDelegate)

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 你也可以设置autoDismiss属性为NO，选择器就不会自己dismis了
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    self.addFeedVM.selectedPhotos = [NSMutableArray arrayWithArray:photos];
    self.addFeedVM.selectedAssets = [NSMutableArray arrayWithArray:assets];
    self.addFeedVM.isSelectOriginalPhoto = isSelectOriginalPhoto;
    [self.collectionView reloadData];
}

// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(PHFetchResult *)result {
    return YES;
}

@end
