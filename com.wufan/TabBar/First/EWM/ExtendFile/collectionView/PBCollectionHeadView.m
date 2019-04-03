//
//  PBCollectionHeadView.m
//  com.wufan
//
//  Created by appleadmin on 2019/1/18.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "PBCollectionHeadView.h"

@implementation PBCollectionHeadView
+(NSString *)headerViewIdentifier{
    static NSString *headerIdentifier=@"headerViewIdentifier";
    return headerIdentifier;
}
+(instancetype)headerWithCollectionView:(UICollectionView *)collectionview forIndexPath:(NSIndexPath *)indexpath{
    PBCollectionHeadView *headrView=[collectionview dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[PBCollectionHeadView headerViewIdentifier] forIndexPath:indexpath];
    return headrView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UILabel *textLabel=[[UILabel alloc]init];
        CGFloat x=5;
        CGFloat y=5;
        CGFloat width=frame.size.width-10;
        CGFloat height=frame.size.height-10;
        textLabel.frame=CGRectMake(x, y, width, height);
        textLabel.numberOfLines=0;
        textLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:textLabel];
        self.textLabel=textLabel;
    }
    return self;
}
@end
