//
//  XKSHomeViewController.m
//  XKSHomeModule
//
//  Created by _Finder丶Tiwk on 16/6/8.
//  Copyright © 2016年 _Finder丶Tiwk. All rights reserved.
//

#import "XKSHomeViewController.h"
#import "XKSGoodsCell.h"

#import <XKSLoginModule/XKSLoginServices.h>

@interface XKSHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,strong) NSArray<NSDictionary *> *goodsArray;

@end

@implementation XKSHomeViewController

- (NSArray<NSDictionary *> *)goodsArray{
    if (!_goodsArray) {
        
        NSMutableArray *testArray = [NSMutableArray array];
        
        NSString *imageName;
        NSString *title;
        for (NSUInteger index = 0; index < 17; index ++) {
            int rand = arc4random()%3;
            
            if (rand == 0) {
                imageName = @"cell_camera";
            }else if (rand == 1){
                imageName = @"cell_itv";
            }else if (rand == 2){
                imageName = @"cell_telephone";
            }
            title = [NSString stringWithFormat:@"商品00%td",index];
            [testArray addObject:@{@"image":imageName,@"title":title}];
        }
        _goodsArray = testArray;
    }
    return _goodsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)logoutAction:(UIButton *)sender {
    [XKSLoginServices logout];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"XKSGoodsCell";
    XKSGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    NSDictionary *dic = self.goodsArray[indexPath.row];
    [cell setImageName:dic[@"image"] title:dic[@"title"]];
    
    UIView *selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.374 green:0.834 blue:1.000 alpha:1.000];
    cell.selectedBackgroundView = selectedBackgroundView;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


@end
