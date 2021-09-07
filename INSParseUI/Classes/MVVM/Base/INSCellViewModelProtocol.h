//
//  INSCellViewModelProtocol.h
//  INSParseUI
//
//  Created by XueFeng Chen on 2021/6/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol INSCellViewModelProtocol <NSObject>

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, strong) NSIndexPath *indexPath;

- (void)bindCellIdentifier:(NSArray<NSString *> *)registeredCellIdentifierArray;
//- (void)bindCellIdentifierArray:(NSArray<NSString *> *)cellIdentifierArray;

@end

NS_ASSUME_NONNULL_END
