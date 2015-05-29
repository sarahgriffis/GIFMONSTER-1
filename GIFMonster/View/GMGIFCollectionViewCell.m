//
//  GMGIFCollectionViewCell.m
//  GIFMonster
//
//  Created by Sarah Griffis on 5/20/15.
//  Copyright (c) 2015 PaperlessPost. All rights reserved.
//


#import "GMGIFCollectionViewCell.h"
#import "UIColor+GIFMonsterColors.h"
#import "GMConstants.h"


@interface GMGIFCollectionViewCell()

@property (nonatomic, strong, readwrite) FLAnimatedImageView *animatedImageView;

@end

@implementation GMGIFCollectionViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    //for now we want to force the image to be 300/300
    //TODO: Make this dynamic using ratio category
    self.animatedImageView.frame = CGRectMake((self.bounds.size.width / 2) - (kImageSize.width / 2), 70, kImageSize.width, kImageSize.height);
//    self.animatedImageView.center = self.contentView.center;
}

#pragma mark - Lazy Loading
- (FLAnimatedImageView *)animatedImageView
{
    if (!_animatedImageView) {
        _animatedImageView = [FLAnimatedImageView new];
        _animatedImageView.backgroundColor = [UIColor gifsendbuttonbackgroundGreen];
        [self.contentView addSubview:_animatedImageView];
    }
    return _animatedImageView;
}

@end