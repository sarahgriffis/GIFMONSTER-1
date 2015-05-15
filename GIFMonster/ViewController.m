//
//  ViewController.m
//  GIFMonster
//
//  Created by Jabari Bell on 5/14/15.
//  Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import "ViewController.h"
#import "FLAnimatedImage.h"
#import "UIImage+animatedGIF.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *container;
@property (nonatomic, strong) UIImageView *containerImageView;
@property (nonatomic, strong) FLAnimatedImageView *displayImageView;

@property (nonatomic, strong) NSMutableArray *ourImages;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.container = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.container];

    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://raphaelschaad.com/static/nyan.gif"]]];
    self.displayImageView = [[FLAnimatedImageView alloc] init];
    

    self.displayImageView.animatedImage = image;
    self.displayImageView.frame = CGRectMake(0.0, 0.0, 300.0, 300.0);
    self.displayImageView.center = self.view.center;
    
    CGFloat ratio = [self ratioForImage:self.displayImageView.image];
    
    //self.displayImageView.frame = CGRectMake(0, 0, self.displayImageView.image.size.width * ratio , self.displayImageView.image.size.height * ratio);
    [self.container addSubview:self.displayImageView];

//    [imageView.animatedImage imageLazilyCachedAtIndex:12];
//    NSLog(@"frame count: %d", [imageView.animatedImage frameCount]);
    UIImage *ourImage = [UIImage animatedImageWithAnimatedGIFURL:[[NSURL alloc] initWithString:@"http://raphaelschaad.com/static/nyan.gif"]];
    //NeonLights_iOS_750x1334.gif
    //https://files.slack.com/files-pri/T02JM6XQR-F04SKBSSN/download/neonlights_ios_750x1334.gif
    //http://raphaelschaad.com/static/nyan.gif
//    self.containerImageView.image = ourImage;

    NSLog(@"images: %@", ourImage.images);

    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, self.view.bounds.size.width, 20)];
    myLabel.text = @"HI SARAH!";
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.font = [UIFont boldSystemFontOfSize:20];
    myLabel.textColor = [UIColor whiteColor];
    [self.container addSubview:myLabel];
    
    UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 216, self.view.bounds.size.width, 50)];
    UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 421, self.view.bounds.size.width, 50)];
    UITextField *textField3 = [[UITextField alloc] initWithFrame:CGRectMake(0, 456, self.view.bounds.size.width, 50)];
    textField1.text = @"HAPPY BIRTHDAY SARAH";
    textField2.text = @"FROM HEATHER";
    textField3.text = @"TEXT3";
    textField1.font = [UIFont boldSystemFontOfSize:18];
    textField2.font = [UIFont boldSystemFontOfSize:18];
    textField3.font = [UIFont boldSystemFontOfSize:18];
    textField1.textColor = [UIColor whiteColor];
    textField2.textColor = [UIColor whiteColor];
    textField3.textColor = [UIColor redColor];
    textField1.textAlignment = NSTextAlignmentCenter;
    textField2.textAlignment = NSTextAlignmentCenter;
    textField3.textAlignment = NSTextAlignmentCenter;
    [self.container addSubview:textField1];
    [self.container addSubview:textField2];
    //[self.container addSubview:textField3];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat buttonWidth = 125;
    CGFloat buttonX = (self.view.bounds.size.width/2) - (buttonWidth/2);
    
    button.frame = CGRectMake(buttonX, self.displayImageView.image.size.height * ratio - 75, buttonWidth, 35);
    button.backgroundColor = [UIColor blackColor];
    button.layer.cornerRadius = 17;
    button.layer.masksToBounds = YES;
    [button setTitle:@"SEND" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    

    
    [self.container addSubview:button];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];


//    [self displayCachedImagesForAnimatedImage:self.containerImageView.animatedImage];
    self.ourImages = [[NSMutableArray alloc] init];

    NSUInteger i = 0;
    NSInteger side = 300;
    for (UIImage *image in ourImage.images) {
        if (self.containerImageView) {
            [self.containerImageView removeFromSuperview];
            self.containerImageView.image = nil;
            self.containerImageView = nil;
            [textField1 removeFromSuperview];
            [textField2 removeFromSuperview];
            [myLabel removeFromSuperview];
        }
        self.containerImageView = [UIImageView new];
        self.containerImageView.frame = CGRectMake(0.0, 0.0, side, side);
        self.containerImageView.image = image;
          [self.container addSubview:self.containerImageView];
          [self.container addSubview:textField1];
          [self.container addSubview:textField2];
          [self.container addSubview:myLabel];
//        [self.container insertSubview:self.containerImageView atIndex:0];

        UIGraphicsBeginImageContext(CGSizeMake(side, side));
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.container.layer renderInContext:context];
        UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.ourImages addObject:screenShot];
        UIImageView *iv = [[UIImageView alloc] initWithImage:screenShot];
        NSLog(@"screenshot: %@", screenShot);
        iv.frame = CGRectMake(0, side * i, side, side);
        //[self.container addSubview:iv];
        i++;
    }

    //self.container.contentSize = CGSizeMake(self.view.frame.size.width, i * side);

    self.containerImageView.hidden = YES;

    makeAnimatedGif(self.ourImages, self.ourImages.count, ourImage.duration);

}

static void makeAnimatedGif(NSArray *ourImages, NSUInteger frameCount, NSTimeInterval duration) {
//    static NSUInteger kFrameCount = frameCount;
    float delaytime = roundf((duration/frameCount * 100))/100;
    

    NSDictionary *fileProperties = @{
            (__bridge id)kCGImagePropertyGIFDictionary: @{
                    (__bridge id)kCGImagePropertyGIFLoopCount: @0, // 0 means loop forever
            }
    };

    NSDictionary *frameProperties = @{
            (__bridge id)kCGImagePropertyGIFDictionary: @{
                    (__bridge id)kCGImagePropertyGIFDelayTime: [NSNumber numberWithFloat:delaytime], // a float (not double!) in seconds, rounded to centiseconds in the GIF data
            }
    };

    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    NSURL *fileURL = [documentsDirectoryURL URLByAppendingPathComponent:@"animated.gif"];

    CGImageDestinationRef destination = CGImageDestinationCreateWithURL((__bridge CFURLRef)fileURL, kUTTypeGIF, frameCount, NULL);
    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)fileProperties);

    for (NSUInteger i = 0; i < frameCount; i++) {
        @autoreleasepool {
            UIImage *image = ourImages[i];
            CGImageDestinationAddImage(destination, image.CGImage, (__bridge CFDictionaryRef)frameProperties);
        }
    }

    if (!CGImageDestinationFinalize(destination)) {
        NSLog(@"failed to finalize image destination");
    }
    CFRelease(destination);

    NSLog(@"url=%@", fileURL);
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
