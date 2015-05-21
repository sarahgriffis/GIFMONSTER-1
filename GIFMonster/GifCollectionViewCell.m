//
//  GifCollectionViewCell.m
//  GIFMonster
//
//  Created by Sarah Griffis on 5/20/15.
//  Copyright (c) 2015 PaperlessPost. All rights reserved.
//


#import "GifCollectionViewCell.h"
#import "FLAnimatedImage.h"

@implementation GifCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        NSInteger side = 300;
        CGRect imageFrame = CGRectMake(self.contentView.frame.size.width/2 - side/2, 100, side, side);
        
        self.container = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
        self.container.backgroundColor = [UIColor colorWithRed:174/255.0f green:216/255.0f blue:190/255.0f alpha:1.0f];
        [self.contentView addSubview:self.container];
        

        self.innerContainer = [[UIView alloc] initWithFrame:imageFrame];
        [self.container addSubview:self.innerContainer];

        self.displayImageView = [[FLAnimatedImageView alloc] init];
        self.displayImageView.frame = CGRectMake(0, 0, side, side);
        self.displayImageView.animatedImage = self.flImage;
        [self.innerContainer addSubview:self.displayImageView];
        
        //FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"file:///Users/sarah/Desktop/nyan.gif"]]];
        //self.displayImageView.animatedImage = image;
        
        
        self.textField1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 16, self.innerContainer.frame.size.width, 50)];
        self.textField2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 221, self.innerContainer.frame.size.width, 50)];
        UITextField *textField3 = [[UITextField alloc] initWithFrame:CGRectMake(0, 456, self.contentView.bounds.size.width, 50)];
        self.textField1.text = @"HAPPY BIRTHDAY SARAH!";
        self.textField2.text = @"FROM HEATHER";
        textField3.text = @"TEXT3";
        self.textField1.font = [UIFont boldSystemFontOfSize:18];
        self.textField2.font = [UIFont boldSystemFontOfSize:18];
        textField3.font = [UIFont boldSystemFontOfSize:18];
        self.textField1.textColor = [UIColor whiteColor];
        self.textField2.textColor = [UIColor whiteColor];
        textField3.textColor = [UIColor redColor];
        self.textField1.textAlignment = NSTextAlignmentCenter;
        self.textField2.textAlignment = NSTextAlignmentCenter;
        textField3.textAlignment = NSTextAlignmentCenter;
        [self.innerContainer addSubview:self.textField1];
        [self.innerContainer addSubview:self.textField2];
        //[self.container addSubview:textField3];
        
        
        self.ourImages = [[NSMutableArray alloc] init];

    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat ratio = [self ratioForImage:self.displayImageView.image];
    
    self.displayImageView.layer.borderWidth = 2.0;
    //self.displayImageView.layer.borderColor = [UIColor redColor].CGColor;
    
    self.displayImageView.layer.cornerRadius = 8;
    self.displayImageView.layer.masksToBounds = YES;
    self.displayImageView.backgroundColor = [UIColor yellowColor];
    
    self.innerContainer.layer.borderWidth = 2.0;
    //self.innerContainer.layer.borderColor = [UIColor redColor].CGColor;
    
    self.innerContainer.layer.cornerRadius = 8;
    self.innerContainer.layer.masksToBounds = YES;

    [self.innerContainer setNeedsDisplay];
    [self.displayImageView setNeedsDisplay];
    //    [self.imageView set]
    
}


- (CGFloat)ratioForImage:(UIImage *)image
{
    CGFloat ratio = 1.0;
    if (image.size.width > image.size.height) {
        ratio = self.container.frame.size.width / image.size.width;
    } else {
        ratio = self.container.frame.size.height / image.size.height;
    }
    return ratio;
}


@end