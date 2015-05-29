//
//  GMGIFCollectionViewCell.h
//  GIFMonster
//
//  Created by Sarah Griffis on 5/20/15.
//  Copyright (c) 2015 PaperlessPost. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "FLAnimatedImage.h"

@interface GMGIFCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, readonly) FLAnimatedImageView *animatedImageView;

@end