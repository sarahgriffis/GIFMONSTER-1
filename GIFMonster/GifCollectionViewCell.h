//
//  GifCollectionViewCell.h
//  GIFMonster
//
//  Created by Sarah Griffis on 5/20/15.
//  Copyright (c) 2015 PaperlessPost. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FLAnimatedImage.h"
#import <QuartzCore/QuartzCore.h>

@interface GifCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIScrollView *container;
@property (nonatomic, strong) UIImageView *containerImageView;
@property (nonatomic, strong) UIView *innerContainer;
@property (nonatomic, strong) FLAnimatedImageView *displayImageView;
@property (nonatomic, strong) NSMutableArray *ourImages;
@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UITextField *textField2;
@property (nonatomic, strong) UIImage *ourImage;
@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) FLAnimatedImage *flImage;

@end