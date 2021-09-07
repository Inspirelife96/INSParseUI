//
//  INSAddFeedViewController+MKDropdownMenuDataSource.m
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/7/3.
//

#import "INSAddFeedViewController+MKDropdownMenuDataSource.h"

@implementation INSAddFeedViewController (MKDropdownMenuDataSource)

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    return [self.categoryArray count];
}

- (CGFloat)dropdownMenu:(MKDropdownMenu *)dropdownMenu rowHeightForComponent:(NSInteger)component {
    return 44.0f;
}

- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForComponent:(NSInteger)component {
    return [[NSAttributedString alloc] initWithString:@"" attributes:nil];
}

- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *titleString = self.categoryArray[row];
    
    UIColor *attributedTitleForRowTextColor = [ThemeManager colorFor:@"INSDropdownMenuCell.dropdownMenu.attributedTitleForRowTextColor"];
    UIFont *attributedTitleForRowFont = [ThemeManager fontFor:@"INSDropdownMenuCell.dropdownMenu.attributedTitleForRowFont"];
    
    return [[NSAttributedString alloc] initWithString:titleString
                                           attributes:@{NSFontAttributeName: attributedTitleForRowFont,
                                                        NSForegroundColorAttributeName: attributedTitleForRowTextColor}];
}

- (UIColor *)dropdownMenu:(MKDropdownMenu *)dropdownMenu backgroundColorForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [ThemeManager colorFor:@"INSDropdownMenuCell.dropdownMenu.backgroundColorForRow"];
}

- (UIColor *)dropdownMenu:(MKDropdownMenu *)dropdownMenu backgroundColorForHighlightedRowsInComponent:(NSInteger)component {
    return [ThemeManager colorFor:@"INSDropdownMenuCell.dropdownMenu.backgroundColorForHighlightedRows"];
}

@end
