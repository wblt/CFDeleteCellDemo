//
//  CFDeleteTableViewCell.m
//  CFDeleteDemo
//
//  Created by TheMoon on 16/5/11.
//  Copyright © 2016年 CFJ. All rights reserved.
//

#import "CFDeleteTableViewCell.h"


@interface CFDeleteTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *moveView;


@end


@implementation CFDeleteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOperationButtonClickedNotification:) name:@"SDTimeLineCellOperationButtonClickedNotification" object:nil];
    
    //添加左滑手势
    UISwipeGestureRecognizer *swipLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    swipLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.moveView addGestureRecognizer:swipLeft];
    //添加右滑手势
    UISwipeGestureRecognizer *swipRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    swipRight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.moveView addGestureRecognizer:swipRight];
    
    _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 50, 30)];
    _testLabel.text = @"fdfdfd";
    [self.contentView addSubview:_testLabel];
}


- (void)swip:(UISwipeGestureRecognizer *)swipe{
   
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self postOperationButtonClickedNotification];
        
        [self openMenu];
        
    }else if (swipe.direction == UISwipeGestureRecognizerDirectionRight){
        // 关闭
        [self closeMenu];
    }
}

- (IBAction)deleteAction:(UIButton *)sender {
    if(sender.tag == 666){
        // 取消
        [self closeMenu];
        
    }else if (sender.tag == 777){
        // 删除
        if ([self.delegate respondsToSelector:@selector(CFDeleteTableViewCell:)]) {
            [self.delegate CFDeleteTableViewCell:self];
        }
    }
}

- (void)openMenu{
    if (self.isOpen) {
        return;
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.moveView.center = CGPointMake(self.moveView.center.x - 130, self.moveView.center.y);
    }completion:^(BOOL finished) {
        if(finished){
            self.isOpen = YES;
        }
    }];
}

/**关闭左滑菜单*/
-(void)closeMenu
{
    if(!_isOpen) {
        return;
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.moveView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, self.moveView.center.y);
    }completion:^(BOOL finished) {
        if (finished) {
            self.isOpen = NO;
        }
    }];
   
}

- (void)receiveOperationButtonClickedNotification:(NSNotification *)notification
{

    UIView *btn = [notification object];
    if (btn != _moveView && _isOpen) {
        [self closeMenu];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self postOperationButtonClickedNotification];
    if (_isOpen) {
        [self closeMenu];
    }
}

- (void)postOperationButtonClickedNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SDTimeLineCellOperationButtonClickedNotification" object:_moveView];
}
@end
