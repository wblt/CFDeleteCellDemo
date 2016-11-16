//
//  CFDeleteTableViewCell.h
//  CFDeleteDemo
//
//  Created by TheMoon on 16/5/11.
//  Copyright © 2016年 CFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CFDeleteTableViewCell;

@protocol CFDeleteTableViewCellDelete <NSObject>

@optional


- (void)CFDeleteTableViewCell:(UITableViewCell *)cell;


@end

typedef void(^swipeBlock) ();
typedef void(^deleteBlock) (UITableViewCell *cell);
typedef void(^cancleBlock) ();


@interface CFDeleteTableViewCell : UITableViewCell

@property (nonatomic,assign) id<CFDeleteTableViewCellDelete> delegate;

@property (nonatomic,strong) UILabel *testLabel;


@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, copy)swipeBlock mySwipeBlock;
@property (nonatomic, copy)deleteBlock myDeleteBlock;
-(void)closeMenu;
@end
