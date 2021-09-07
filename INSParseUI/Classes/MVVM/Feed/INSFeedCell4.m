//
//  INSFeedCell4.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import "INSFeedCell4.h"

@implementation INSFeedCell4

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mediaContentCount = 4;
        [self buildUI];
    }
    return self;
}

@end
