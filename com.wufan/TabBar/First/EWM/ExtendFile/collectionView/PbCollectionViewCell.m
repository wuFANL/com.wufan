//
//  PbCollectionViewCell.m
//  com.wufan
//
//  Created by appleadmin on 2019/1/18.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "PbCollectionViewCell.h"

@implementation PbCollectionViewCell
+(NSString *)cellIdentifier{
    static NSString *cellIdentifier=@"CollectionViewCellIdentifier";
    return cellIdentifier;
    
}
+(instancetype)cellWithCollection:(UICollectionView *)collectionview forIndexPath:(NSIndexPath *)indexPath{
    //从缓存池中找视图对象，如果找不到就alloc/initwith创建
    PbCollectionViewCell *cell=[collectionview dequeueReusableCellWithReuseIdentifier:[PbCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    return cell;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UILabel *textLabel=[[UILabel alloc]init];
        CGFloat x=5;
        CGFloat y=5;
        CGFloat width=frame.size.width;
        CGFloat height=frame.size.height;
//        textLabel.frame=CGRectMake(x, y, width, height);
//        textLabel.font=[UIFont systemFontOfSize:15.f];
//        [self.contentView addSubview:textLabel];
//        self.textLabel=textLabel;
    }
    return self;
}
-(void)addImageInContentView1{
    UIImageView *view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kn-1"]];
    [self.contentView addSubview:view];
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(3, 3, 2, 2));
        make.centerY.mas_equalTo(self.contentView);
    }];
}
-(void)addImageInContentView2{
    UIImageView *view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kn-2"]];
    [self.contentView addSubview:view];
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(3, 3, 2, 2));
        make.centerY.mas_equalTo(self.contentView);
    }];
}
-(void)addImageInContentView3{
    UIImageView *view=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kn-3"]];
    [self.contentView addSubview:view];
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).insets(UIEdgeInsetsMake(3, 3, 2, 2));
        make.centerY.mas_equalTo(self.contentView);
    }];
}
@end
