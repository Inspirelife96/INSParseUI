//
//  INSFeedCell7.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/27.
//

#import "INSFeedCell7.h"

@implementation INSFeedCell7

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mediaContentCount = 7;
        [self buildUI];
    }
    return self;
}

@end
