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
#import <MessageUI/MFMessageComposeViewController.h>

@interface ViewController ()

@property (nonatomic, strong) UIScrollView *container;
@property (nonatomic, strong) UIImageView *containerImageView;

@property (nonatomic, strong) NSMutableArray *ourImages;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.container = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.container];
//
//    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://raphaelschaad.com/static/nyan.gif"]]];
//    self.containerImageView = [[FLAnimatedImageView alloc] init];
//    self.containerImageView.animatedImage = image;

//    [imageView.animatedImage imageLazilyCachedAtIndex:12];
//    NSLog(@"frame count: %d", [imageView.animatedImage frameCount]);
    UIImage *ourImage = [UIImage animatedImageWithAnimatedGIFURL:[[NSURL alloc] initWithString:@"http://raphaelschaad.com/static/nyan.gif"]];
//    self.containerImageView.image = ourImage;

    NSLog(@"images: %@", ourImage.images);




    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 240, 20)];
    myLabel.text = @"HI NAH YO CHILL SON!";
    myLabel.font = [UIFont boldSystemFontOfSize:20];
    myLabel.textColor = [UIColor whiteColor];
    [self.container addSubview:myLabel];
    
    UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(25, 175, 50, 50)];
    textField1.text = @"text1";
    textField2.text = @"text2";
    [self.container addSubview:textField1];
    [self.container addSubview:textField2];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(75, 175, self.view.frame.size.width - 75, 50);
    button.backgroundColor = [UIColor blueColor];
    button.layer.borderWidth = 0.5f;
    
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
        [self.container addSubview:iv];
        i++;
    }

    self.container.contentSize = CGSizeMake(self.view.frame.size.width, i * side);

    self.containerImageView.hidden = YES;

    makeAnimatedGif(self.ourImages, self.ourImages.count);

}

- (void)buttonAction
{
    [self popSMS];
}

static void makeAnimatedGif(NSArray *ourImages, NSUInteger frameCount) {
//    static NSUInteger kFrameCount = frameCount;

    NSDictionary *fileProperties = @{
            (__bridge id)kCGImagePropertyGIFDictionary: @{
                    (__bridge id)kCGImagePropertyGIFLoopCount: @0, // 0 means loop forever
            }
    };

    NSDictionary *frameProperties = @{
            (__bridge id)kCGImagePropertyGIFDictionary: @{
                    (__bridge id)kCGImagePropertyGIFDelayTime: @0.02f, // a float (not double!) in seconds, rounded to centiseconds in the GIF data
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

- (void)popSMS
{
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
//    messageController.messageComposeDelegate = self;

    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    NSURL *fileURL = [documentsDirectoryURL URLByAppendingPathComponent:@"animated.gif"];

    NSData *imgData = [[NSFileManager defaultManager] contentsAtPath:fileURL];
    BOOL didAttachImage = [messageController addAttachmentData:imgData typeIdentifier:(__bridge NSString *)kUTTypeGIF filename:@"LOLZ.gif"];
//    [self.messageController addAttachmentData:gifData typeIdentifier:(__bridge NSString *)kUTTypeGIF filename:@"animated.gif"];

    if (didAttachImage)
    {
        // Present message view controller on screen
        [self presentViewController:messageController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                               message:@"Failed to attach image"
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
}

@end
