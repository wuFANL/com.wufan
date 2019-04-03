//
//  mjCell.m
//  com.wufan
//
//  Created by appleadmin on 2019/4/2.
//  Copyright © 2019年 wufan. All rights reserved.
//

#import "mjCell.h"

@implementation mjCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imageview=[[UIImageView alloc]init];
        [self.contentView addSubview:_imageview];
        [_imageview makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.mas_equalTo(cell.contentView).offset(5);
            make.centerX.mas_equalTo(self.contentView);
//            make.width.mas_equalTo(50);
//            make.height.mas_equalTo(40);
        }];
        
        _title=[[UILabel alloc]init];
        [_title setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_title];
        [_title makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.mas_equalTo(cell.contentView).offset(5);
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(-10);
            make.height.mas_equalTo(20);
        }];
         }
         return self;
    
}
@end
