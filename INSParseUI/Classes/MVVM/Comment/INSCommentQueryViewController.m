//
//  INSCommentQueryViewController.m
//  Bolts
//
//  Created by XueFeng Chen on 2021/7/5.
//

#import "INSCommentQueryViewController.h"

#import "CLTextView.h"

#import "NSString+JKTrims.h"

#import "UIViewController+INS_AlertView.h"

#import "INSCommentQueryViewModel.h"

@interface INSCommentQueryViewController ()

@end

@implementation INSCommentQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([PFUser currentUser]) {
        [self.view addSubview:self.bottomCommentView];
        
        [self.bottomCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.height.mas_equalTo (46.0f);
        }];
        
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.bottomCommentView.mas_top);
        }];
    } else {
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }];
    }
}

- (void)cl_textViewDidChange:(CLTextView *)textView {
    if (textView.commentTextView.text.length > 0) {
        NSString *originalString = [NSString stringWithFormat:@"[草稿]%@",textView.commentTextView.text];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:originalString];
        [attriString addAttributes:@{NSForegroundColorAttributeName: kColorNavigationBar} range:NSMakeRange(0, 4)];
        [attriString addAttributes:@{NSForegroundColorAttributeName: kColorTextMain} range:NSMakeRange(4, attriString.length - 4)];
        
        self.bottomCommentView.editTextField.attributedText = attriString;
    }
}

- (void)cl_textViewDidEndEditing:(CLTextView *)textView {
    NSString *text = [textView.commentTextView.text jk_trimmingWhitespace];
    
    if ([text isEqualToString:@""]) {
        [self ins_alertErrorWithTitle:@"无法上传" subTitle:@"上传内容不能为空"];
    } else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.tableView setUserInteractionEnabled:NO];
        
        WEAKSELF
        INSCommentQueryViewModel *commentQueryVM = (INSCommentQueryViewModel *)self.queryVM;
        [commentQueryVM addComment:text withBlock:^(BOOL succeeded, NSError * _Nullable error) {
            STRONGSELF
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [strongSelf.tableView setUserInteractionEnabled:YES];
            if (!succeeded) {
                [strongSelf ins_alertErrorWithTitle:@"内容上传失败" subTitle:@"请检查您的网络，并稍后再试。"];
            } else {
                [strongSelf.bottomCommentView clearComment];
                [strongSelf loadFirstPage];
            }
        }];
    }

}

- (CLBottomCommentView *)bottomCommentView {
    if (!_bottomCommentView) {
        _bottomCommentView = [[CLBottomCommentView alloc] init];
        _bottomCommentView.delegate = self;
        _bottomCommentView.clTextView.delegate = self;
        _bottomCommentView.clTextView.maxNumberWords = 1024;
    }
    return _bottomCommentView;
}

@end
