//
//  VideoController.m
//  FangDY
//
//  Created by 王林芳 on 2019/9/19.
//  Copyright © 2019 王林芳. All rights reserved.
//

#import "VideoController.h"
#import "VideCollectionViewCell.h"
@interface VideoController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *videoCollectionView;
@property (nonatomic, assign) CGRect orignFrame;
@property (nonatomic, strong) UIView *fatherView;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end

@implementation VideoController

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.videoCollectionView];
    
}
#pragma mark - target-action
#pragma mark - assist method
- (void)setIsFullScreen:(BOOL)isFullScreen {
    if (_isFullScreen == isFullScreen) {
        return;
    }
    _isFullScreen = isFullScreen;
    if (_isFullScreen) {
        // 全屏模式
        self.orignFrame = self.videoCollectionView.frame;
        self.fatherView = self.view;
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:self.videoCollectionView];
        
        CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        [UIView animateWithDuration:0.5 animations:^{
            
            self.videoCollectionView.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.videoCollectionView.frame = frame;
            
        } completion:^(BOOL finished) {
            
        }];
        
    } else {
        // 非全屏
        [UIView animateWithDuration:0.5 animations:^{
            
            self.videoCollectionView.transform = CGAffineTransformIdentity;
            self.videoCollectionView.frame = self.orignFrame;
            
            [self.fatherView addSubview:self.videoCollectionView];
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    [self.videoCollectionView reloadData];
    
    [self.videoCollectionView layoutIfNeeded];
    
    [self.videoCollectionView scrollToItemAtIndexPath:self.currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}
#pragma mark - delegate
#pragma mark ------ UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideCollectionViewCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.isFullScreen = self.isFullScreen;
    [cell laySubviews];
    return cell;
}
#pragma mark ------ UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndexPath = indexPath;
    self.isFullScreen = !self.isFullScreen;
}
#pragma mark - private
#pragma mark - lazy load
- (UICollectionView *)videoCollectionView {
    if (!_videoCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        _videoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300) collectionViewLayout:flowLayout];
        _videoCollectionView.delegate = self;
        _videoCollectionView.dataSource = self;
        _videoCollectionView.showsHorizontalScrollIndicator = NO;
        _videoCollectionView.pagingEnabled = YES;
        _videoCollectionView.backgroundColor = [UIColor clearColor];
        [_videoCollectionView registerClass:[VideCollectionViewCell class]
                 forCellWithReuseIdentifier:@"VideCollectionViewCell"];
    }
    return _videoCollectionView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isFullScreen) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }else {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


@end
