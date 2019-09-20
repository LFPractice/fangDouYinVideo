//
//  VideCollectionViewCell.m
//  FangDY
//
//  Created by 王林芳 on 2019/9/19.
//  Copyright © 2019 王林芳. All rights reserved.
//

#import "VideCollectionViewCell.h"
#import "Masonry.h"

@interface VideCollectionViewCell ()
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UILabel *label;
@end
@implementation VideCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI {
    [self.contentView setBackgroundColor:[UIColor blueColor]];
    
    UIView *centerView = [[UIView alloc]init];
    centerView.backgroundColor = [UIColor grayColor];
    
    self.centerView = centerView;
    [self.contentView addSubview:centerView];
    
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"hello world";
    label.textColor = [UIColor whiteColor];
    [self.contentView addSubview:label];
    self.label = label;
    
}

- (void)setIsFullScreen:(BOOL)isFullScreen {
    _isFullScreen = isFullScreen;
    
    self.label.text = [NSString stringWithFormat:@"hello world %ld",self.indexPath.row];
}

- (void)laySubviews {
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(-20);
        
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
    }];
}
@end
