//
//  GMGIFCollectionViewCell.m
//  GIFMonster
//
//  Created by Sarah Griffis on 5/20/15.
//  Copyright (c) 2015 PaperlessPost. All rights reserved.
//


#import "GMGIFCollectionViewCell.h"
#import "UIColor+GIFMonsterColors.h"

@interface GMGIFCollectionViewCell()

@property (nonatomic, strong, readwrite) UIImageView *animatedImageView;

@end

@implementation GMGIFCollectionViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    //for now we want to force the image to be 300/300
    //TODO: Make this dynamic using ratio category
    self.animatedImageView.frame = CGRectMake(0, 0, 300, 300);
    self.animatedImageView.center = self.contentView.center;
}

#pragma mark - Lazy Loading
- (UIImageView *)animatedImageView
{
    if (!_animatedImageView) {
        _animatedImageView = [UIImageView new];
        _animatedImageView.backgroundColor = [UIColor gifsendbuttonbackgroundGreen];
        [self.contentView addSubview:_animatedImageView];
    }
    return _animatedImageView;
}

#pragma mark - Get/Set Overrides
- (void)setAnimatedImage:(UIImage *)animatedImage
{
    self.animatedImageView.image = animatedImage;
}

- (UIImage *)animatedImage
{
    return self.animatedImageView.image;
}

@end