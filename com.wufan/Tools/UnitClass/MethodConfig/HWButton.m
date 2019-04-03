//
//  HWButton.m
//  
//
//  Created by appleadmin on 2019/1/14.
//
//
#import "HWButton.h"

@implementation HWButton
/**
 利用uiLbael自动换行的特性，设置label与button的约束控制button向下延伸
 @return 返回一个随文字变化长宽的按钮
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        UILabel *label=[[UILabel alloc]init];
        self.label=label;
        label.textColor=[UIColor blackColor];
      
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        //设定到达多长才换行
        label.preferredMaxLayoutWidth = [[UIScreen mainScreen]bounds].size.width;
        [self addSubview:label];        label.translatesAutoresizingMaskIntoConstraints=NO;
        NSLayoutConstraint *labelTop=[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:5];
        [self addConstraint:labelTop];
        NSLayoutConstraint *labelLeft=[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:5];
        [self addConstraint:labelLeft];
        NSLayoutConstraint *labelBottom=[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-5];
        [self addConstraint:labelBottom];
        NSLayoutConstraint *labelRight=[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-5];
        [self addConstraint:labelRight];
    }
    return self;
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    self.label.text=title;
}
-(UILabel *)titleLabel{
    return self.label;
}
-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state{
    self.label.textColor=color;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
