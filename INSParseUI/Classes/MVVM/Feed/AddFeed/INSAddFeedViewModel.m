//
//  INSAddFeedViewModel.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/2.
//

#import "INSAddFeedViewModel.h"

#import "JCTagListView.h"

#import "UIImage+INS_Compress.h"

#import "INSTextViewCellViewModel.h"

@interface INSAddFeedViewModel ()

// 理论上View是不应该出现在ViewModel里面的，但这个是用来计算高度的，并不用于展示，所以就放这里了
@property (nonatomic, strong) JCTagListView *tagListView;

@end

@implementation INSAddFeedViewModel

- (instancetype)init {
    if (self = [super init]) {
        _category = @(0);
        _title = @"";
        _content = @"";
        _forwardFrom = nil;
        _isOriginal = YES;
        
        _selectedPhotos = [[NSMutableArray alloc] init];
        _selectedAssets = [[NSMutableArray alloc] init];
        _maxSelectedPhotoCount = 9;
        _isSelectOriginalPhoto = NO;

        _collectionViewItemWidth = ceil(([UIScreen jk_width] - 40.0f - 25.0f)/4.0f);
        _collectionViewItemMargin = 5.0f;
                
        _selectedTags = [[NSMutableArray alloc] init];
        
        _enableCategoryCell = YES;
        _enableTitleCell = YES;
        _enableContentCell = YES;
        _enableForwardFromCell = YES;
        _enableIsOriginalCell = YES;
        _enableMediaContentsCell = YES;
        _enableSelectedTagsCell = YES;
        
        _titleCellVM = [[INSTextViewCellViewModel alloc] initWithCellDescription:@"标题(不超过100字)"
                                                                     placeHolder:@""
                                                                  maxNumberWords:100
                                                                maxNumberOfLines:1000];

        _contentCellVM = [[INSTextViewCellViewModel alloc] initWithCellDescription:@"内容(不超过1000字)"
                                                                       placeHolder:@""
                                                                    maxNumberWords:1000
                                                                  maxNumberOfLines:1000];

        _forwardFromCellVM = [[INSTextViewCellViewModel alloc] initWithCellDescription:@"原文链接(不超过250字)"
                                                                           placeHolder:@"请确认是由https://或http://开始的链接并能正确访问"
                                                                        maxNumberWords:250
                                                                      maxNumberOfLines:1000];

        
        _categoryCellDescription = @"请选择板块";
        _isOriginalCellDescription = @"";
        _mediaContentsCellDescription = @"图片（不超过9张）";
        _selectedTagsCellDescription = @"标签（建议选择1-3个）";
        
        _selectedTagsCellPlaceHolder = @"请点击进入标签选择界面";
        
        _isOriginalCellTitle = @"是否是原创";
    }
    
    return self;
}

- (NSInteger)numberOfItemsInSectionOfCollectionView {
    if ([self isSelectedPhotoReachesMax]) {
        return self.selectedPhotos.count;
    } else {
        return (self.selectedPhotos.count + 1);
    }
}

- (BOOL)isSelectedPhotoReachesMax {
    if (self.selectedPhotos.count >= self.maxSelectedPhotoCount) {
        return YES;
    } else {
        return NO;
    }
}

- (CGFloat)heightForMediaContentsCell {
    //高度计算方法：
    // - 上下边距 2 * 12.0f
    // - 根据屏幕宽度计算每个图片的高度([UIScreen jk_width] - 40.0f - 25.0f)/4.0f) * 需要几行(1 + (self.selectedPhotos.count)/4)
    // - 超过一行，则需要追加行距 (self.selectedPhotos.count)/4 * 5.0f
    return 2 * 12.0f + (([UIScreen jk_width] - 40.0f - 25.0f)/4.0f) * (1 + (self.selectedPhotos.count)/4) + (self.selectedPhotos.count)/4 * 5.0f;
}

- (CGFloat)heightForSelectedTagsCell {
    if (self.selectedTags.count > 0) {
        self.tagListView.tags = self.selectedTags;
        return self.tagListView.contentHeight + 8.0f * 2;
    } else {
        return 32.0 + 8.0f * 2;
    }
}

- (BOOL)isAbleToPublish:(NSString **)errorMessage {
    if ((self.enableTitleCell) && ([self.title isEqualToString:@""])) {
        *errorMessage = @"请输入标题";
        return NO;
    }
    
    if ((self.enableContentCell) && ([self.content isEqualToString:@""])) {
        *errorMessage = @"请输入内容";
        return NO;
    }
    
//    if ((self.enableContentCell) && (![self.forwardFrom isEqualToString:@""] && ![self.forwardFrom jk_isEmailAddress])) {
//        *errorMessage = @"请输入正确的地址，以https://或http://开始";
//        return NO;
//    }
    
    return YES;
}

- (BOOL)needWarningWhenCancel {
    if (![self.title isEqualToString:@""]
        || ![self.content isEqualToString:@""]
//        || ![self.forwardFrom isEqualToString:@""]
        || self.selectedPhotos.count > 0
        || self.selectedTags.count > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)addFeedInBackground:(INSBooleanResultBlock)block {
    dispatch_queue_t dispatchQueue = dispatch_queue_create("inspirelife.queue.add.feed", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t dispatchGroup = dispatch_group_create();

    NSMutableArray *fileObjectArray = [[NSMutableArray alloc] init];
    //NSMutableArray *thumbnailObjectArray = [[NSMutableArray alloc] init];
    __block BOOL succeeded = YES;
    __block NSError *error = nil;

    // 上传所有的照片，如果有一张上传失败，则失败
    [self.selectedPhotos enumerateObjectsUsingBlock:^(UIImage * _Nonnull photoImage, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_group_async(dispatchGroup, dispatchQueue, ^{
            NSData *imageData = [photoImage ins_compressToByte:(100 * 1024)];
            PFFileObject *fileObject = [PFFileObject fileObjectWithName:@"image.jpg" data:imageData];
            [fileObject save:&error];
            if (!error) {
                [fileObjectArray addObject:fileObject];
            } else {
                succeeded = NO;
            }
        });
    }];

    // 只有全部照片上传成功后，才可以上传提问
    dispatch_group_notify(dispatchGroup, dispatchQueue, ^{
        if (succeeded) {
            succeeded = [INSParseQueryManager addFeedWithStatus:@(INSParseRecordStatusPrivate)
                                                       category:self.category
                                                          title:self.title
                                                        content:self.content
                                                  mediaContents:fileObjectArray
                                                       fromUser:[PFUser currentUser]
                                                     isOriginal:self.isOriginal
                                                    forwardFrom:self.forwardFrom
                                                   commentCount:@(0)
                                                      likeCount:@(0)
                                                     shareCount:@(0)
                                                           tags:self.selectedTags
                                                        article:nil
                                                          error:&error];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(succeeded, error);
        });
    });
}

- (JCTagListView *)tagListView {
    if (!_tagListView) {
        _tagListView = [[JCTagListView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen jk_width] - 24.0f, 0)];
    }
    
    return _tagListView;
}

@end
