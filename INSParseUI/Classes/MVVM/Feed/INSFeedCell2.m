//
//  INSFeedCell2.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import "INSFeedCell2.h"

@implementation INSFeedCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mediaContentCount = 2;
        [self buildUI];
    }
    return self;
}

@end
