//
//  PBViewController.m
//  com.wufan
//
//  Created by appleadmin on 2019/1/17.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "PBViewController.h"
#import "HWButton.h"

@interface PBViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@end
@implementation PBViewController
#define MS(MyWeakSelf)  __weak __typeof(&*self)MyWeakSelf = self;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
    [self createCenterView];
    // Do any additional setup after loading the view.
}
//-(instancetype)init{
//
////    self.view.backgroundColor=[UIColor grayColor];
//
//    return self;
//}
-(void)back{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)createCenterView{
    CGFloat x=0;
    CGFloat y=20;
    CGFloat width=self.view.frame.size.width;
    CGFloat height=self.view.frame.size.height-20;
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;//滑动方向
//    头部高度
//    layout.headerReferenceSize=CGSizeMake(100, 40);
////    底部高度
//    layout.footerReferenceSize=CGSizeMake(100, 40);
    CGRect frame=CGRectMake(x, y, width, height);
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    collectionView.delegate=self;
    collectionView.dataSource=self;
    collectionView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:collectionView];
    //MS->弱引用的cell
        MS(MS);
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(MS.view.mas_centerX);
            make.centerY.mas_equalTo(MS.view.mas_centerY);
         make.size.mas_equalTo(CGSizeMake((KScree_Width/5)*4, (KScree_Hight/5)*4));
        }];
    self.collectionView=collectionView;
    
    [collectionView registerClass:[PbCollectionViewCell class] forCellWithReuseIdentifier:[PbCollectionViewCell cellIdentifier]];
    
    [collectionView registerClass:[PBCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[PBCollectionHeadView headerViewIdentifier]];
    
    [collectionView registerClass:[PBCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[PBCollectionFooterView footerViewIdentifier]];
    
//    删除按钮
    UIButton *btn=[[UIButton alloc]init];
    btn.backgroundColor=[UIColor grayColor];
    btn.titleLabel.adjustsFontSizeToFitWidth=YES;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 15.f;
    btn.layer.masksToBounds = YES;
    [btn setImage:[UIImage imageNamed:@"close_pb"] forState:UIControlStateNormal]; btn.imageView.contentMode=UIViewContentModeScaleAspectFill;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(collectionView.mas_bottom);
    make.centerX.mas_equalTo(collectionView.mas_centerX);
        make.size.lessThanOrEqualTo(CGSizeMake(30, 30));
    }];
}
-(void)initCollection:(UIViewController *)vc{
    
}
#pragma mark -- UICollectionViewDataSource
//
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PbCollectionViewCell *cell=[PbCollectionViewCell cellWithCollection:collectionView forIndexPath:indexPath];
    cell.backgroundColor=[UIColor redColor];
//    cell.textLabel.text=[NSString stringWithFormat:@"cell %2ld",(long)indexPath.row];
    switch (indexPath.row) {
        case 0:
             [cell addImageInContentView1];
            break;
        case 1:
            [cell addImageInContentView2];
            break;
        case 2:
            [cell addImageInContentView3];
            break;
        default:
            break;
    }
    NSLog(@"isssssss%ld",(long)indexPath.row);
    return cell;
}

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        PBCollectionHeadView *headview=[PBCollectionHeadView headerWithCollectionView:collectionView forIndexPath:indexPath];
//        headview.backgroundColor=[UIColor orangeColor];
//        headview.textLabel.text=[NSString stringWithFormat:@"head %ld",(long)indexPath.section];
//        return headview;
//    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
//        PBCollectionFooterView *footview=[PBCollectionFooterView footerViewWithCollectionView:collectionView forIndexPath:indexPath];
//        footview.backgroundColor=[UIColor yellowColor];
//        footview.textLabel.text=[NSString stringWithFormat:@"foot %ld",(long)indexPath.section];
//        return footview;
//    }
//    return nil;
//}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //    return self.dateArr.count;
    return 3;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1000;
}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return  CGSizeMake(30, 30);
//}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark -- UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击选择了第%ld组第%ld个方块",indexPath.section,indexPath.row);
}
//选中取消了会调用
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消了第%ld组第%ld个方块",indexPath.section,indexPath.row);
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}
@end
