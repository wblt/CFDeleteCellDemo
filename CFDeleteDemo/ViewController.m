//
//  ViewController.m
//  CFDeleteDemo
//
//  Created by TheMoon on 16/5/11.
//  Copyright © 2016年 CFJ. All rights reserved.
//

#import "ViewController.h"
#import "CFDeleteTableViewCell.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,CFDeleteTableViewCellDelete>

@property (nonatomic, strong) NSMutableArray *titles;


@end

@implementation ViewController {
    NSString *cellId;
    UITableView *cuTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = [@[@"0000000000", @"111111111111",@"2222222222",@"3333333333",@"4444444444",@"5555555555",@"6666666666",@"7777777777",@"8888888888",@"9999999999",@"0000000000", @"111111111111",@"2222222222",@"3333333333",@"4444444444",@"5555555555",@"6666666666",@"7777777777",@"8888888888",@"9999999999",@"0000000000", @"111111111111",@"2222222222",@"3333333333",@"4444444444",@"5555555555",@"6666666666",@"7777777777",@"8888888888",@"9999999999"] mutableCopy];
    
    [self initTableView];
    
}

- (void)initTableView {
    cellId = @"CFDeleteTableViewCell";
    cuTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    cuTableView.dataSource = self;
    cuTableView.delegate = self;
    [self.view addSubview:cuTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CFDeleteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CFDeleteTableViewCell" owner:self options:nil].lastObject;
    
        cell.delegate = self;
        
    }
    cell.testLabel.text = self.titles[indexPath.row];
    
    return cell;
}

#pragma mark - CFDeleteTableViewCell delegate
- (void)CFDeleteTableViewCell:(UITableViewCell *)cell {
    
    NSIndexPath *indexPath = [cuTableView indexPathForCell:cell];
    
    [self.titles removeObjectAtIndex:indexPath.row];
    
    [cuTableView reloadData];
    
}
@end
