//
//  INSObjectCell.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import <UIKit/UIKit.h>
#import "INSUserInteractionProtocol.h"

@class INSObjectViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface INSObjectCell : UITableViewCell

@property (nonatomic, weak) id<INSUserInteractionProtocol> delegate;

- (void)configWithObjectVM:(INSObjectViewModel *)objectVM;

@end

NS_ASSUME_NONNULL_END
