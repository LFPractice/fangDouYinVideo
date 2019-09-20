//
//  VideCollectionViewCell.h
//  FangDY
//
//  Created by 王林芳 on 2019/9/19.
//  Copyright © 2019 王林芳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideCollectionViewCell : UICollectionViewCell
@property (nonatomic, assign) BOOL isFullScreen;
- (void)laySubviews;
@end

NS_ASSUME_NONNULL_END
