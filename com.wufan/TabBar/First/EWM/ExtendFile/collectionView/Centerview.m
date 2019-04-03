//
//  Centerview.m
//  com.wufan
//
//  Created by appleadmin on 2019/1/17.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "Centerview.h"
@interface Centerview()
@property NSArray *dateArr;
@property (nonatomic) UICollectionView *collectView;
@end
@implementation Centerview


-(instancetype)initWithTitle:(NSArray *)arr view:(UIViewController *)vc{
    if (self = [super init]) {
        self.dateArr=arr;
        self.backgroundColor=[UIColor redColor];
//        [self initCollection:vc];
    }
    return self;
}

@end
