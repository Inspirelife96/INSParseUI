//
//  INSAddFeedViewModel.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/2.
//

#import <Foundation/Foundation.h>

#import "INSParseUIConstants.h"

@class INSTextViewCellViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSAddFeedViewModel : NSObject

@property (nonatomic, copy) NSNumber *category;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) INSFeed *forwardFrom;
@property (nonatomic, assign) BOOL isOriginal;

// media contents, 目前只支持图片
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) NSMutableArray *selectedAssets;
@property (nonatomic, assign) NSInteger maxSelectedPhotoCount;
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;

// 选择的标签
@property (nonatomic, strong) NSMutableArray *selectedTags;

// media contents的布局，由于和高度相关，所以需要在这里配置
@property (nonatomic, assign) CGFloat collectionViewItemWidth;
@property (nonatomic, assign) CGFloat collectionViewItemMargin;

@property (nonatomic, assign) BOOL enableCategoryCell;
@property (nonatomic, assign) BOOL enableTitleCell;
@property (nonatomic, assign) BOOL enableContentCell;
@property (nonatomic, assign) BOOL enableForwardFromCell;
@property (nonatomic, assign) BOOL enableIsOriginalCell;
@property (nonatomic, assign) BOOL enableMediaContentsCell;
@property (nonatomic, assign) BOOL enableSelectedTagsCell;

@property (nonatomic, strong) INSTextViewCellViewModel *titleCellVM;
@property (nonatomic, strong) INSTextViewCellViewModel *contentCellVM;
@property (nonatomic, strong) INSTextViewCellViewModel *forwardFromCellVM;;

@property (nonatomic, copy) NSString *categoryCellDescription;
@property (nonatomic, copy) NSString *isOriginalCellDescription;
@property (nonatomic, copy) NSString *mediaContentsCellDescription;
@property (nonatomic, copy) NSString *selectedTagsCellDescription;

@property (nonatomic, copy) NSString *isOriginalCellPlaceHolder;
@property (nonatomic, copy) NSString *selectedTagsCellPlaceHolder;

@property (nonatomic, copy) NSString *isOriginalCellTitle;

- (NSInteger)numberOfItemsInSectionOfCollectionView;

- (BOOL)isSelectedPhotoReachesMax;

- (CGFloat)heightForSelectedTagsCell;

- (CGFloat)heightForMediaContentsCell;

- (BOOL)isAbleToPublish:(NSString **)errorMessage;

- (BOOL)needWarningWhenCancel;

- (void)addFeedInBackground:(INSBooleanResultBlock)block;

@end

NS_ASSUME_NONNULL_END
