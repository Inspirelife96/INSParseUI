//
//  INSAddFeedViewController.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/1.
//

#import <UIKit/UIKit.h>

#import "INSTagsViewController.h"

#import "INSTextViewCell.h"
#import "INSTagsCell.h"
#import "JCTagListView.h"
#import "INSPickedPhotoCell.h"
#import "INSSwitchCell.h"
#import "INSDropdownMenuCell.h"

#import "INSAddFeedViewModel.h"

#import "SCLAlertView+ShowOnMostTopViewController.h"

#import "UIViewController+INS_AlertView.h"

#import "INSParseErrorHandler.h"

#import "INSParseUIConstants.h"
#import "INSAutoHeightTextView.h"

#import <TZImagePickerController/TZImagePickerController.h>


NS_ASSUME_NONNULL_BEGIN

@interface INSAddFeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, INSTextViewCellDelegate ,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,TZImagePickerControllerDelegate, UINavigationControllerDelegate, MKDropdownMenuDataSource, MKDropdownMenuDelegate, INSSwitchCellDelegate>

@property (nonatomic, strong) INSAddFeedViewModel *addFeedVM;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) INSDropdownMenuCell *categoryCell;
@property (nonatomic, strong) INSTextViewCell *titleCell;
@property (nonatomic, strong) INSTextViewCell *contentCell;
@property (nonatomic, strong) INSTextViewCell *forwardFromCell;
@property (nonatomic, strong) INSSwitchCell *isOriginalCell;
@property (nonatomic, strong) UITableViewCell *mediaContentsCell;
@property (nonatomic, strong) INSTagsCell *selectedTagsCell;

@property (nonatomic, strong) NSArray *cellArray;
@property (nonatomic, strong) NSArray *sectionDescriptionArray;
@property (nonatomic, strong) NSArray *categoryArray;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;

@end

NS_ASSUME_NONNULL_END
