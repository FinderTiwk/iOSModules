//
//  XKSSettingViewController.m
//  XKSSettingModule
//
//  Created by _Finder丶Tiwk on 16/6/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XKSSettingViewController.h"
#import "GoodsShelfCell.h"

@interface XKSSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray *cellIDArray;

@end

@implementation XKSSettingViewController

- (NSArray *)cellIDArray{
    if (!_cellIDArray) {
        _cellIDArray = @[@"GoodsShelfCell",@"IPConfigCell"];
    }
    return _cellIDArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
}


- (IBAction)dismissAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellIDArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIDArray[indexPath.row]];
    return cell;
}



@end
