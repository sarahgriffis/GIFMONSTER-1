//
//  GMGIFCollectionViewCell.h
//  GIFMonster
//
//  Created by Sarah Griffis on 5/20/15.
//  Copyright (c) 2015 PaperlessPost. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface GMGIFCollectionViewCell : UICollectionViewCell

/*
Reference to the animated background image for the cell.
 */
@property (nonatomic, strong) UIImage *animatedImage;

@property (nonatomic, strong, readonly) UIImageView *animatedImageView;

@end