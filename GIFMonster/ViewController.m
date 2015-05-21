//
//  ViewController.m
//  GIFMonster
//
//  Created by Jabari Bell on 5/14/15.
//  Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import "ViewController.h"
#import "FLAnimatedImage.h"
#import "MBProgressHUD.h"
#import "UIImage+animatedGIF.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "GifCollectionViewCell.h"

static NSString *CellIdentifier = @"CellIdentifier";

@interface ViewController () <MFMessageComposeViewControllerDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIScrollView *container;
@property (nonatomic, strong) UIImageView *containerImageView;
@property (nonatomic, strong) UIView *innerContainer;
//@property (nonatomic, strong) FLAnimatedImageView *displayImageView;

@property (nonatomic, strong) NSMutableArray *ourImages;
@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UITextField *textField2;

@property (nonatomic, strong) UIImage *ourImage;

//@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *gifsArray = [NSMutableArray array];
    [gifsArray addObject:@"file:///Users/sarah/Desktop/nyan.gif"];
    [gifsArray addObject:@"file:///Users/sarah/Desktop/tiger_eating_meat.gif"];
    self.dataSource = gifsArray;
    
    [self setupCollectionView];
    
    //NSInteger side = 300;
    
    //self.container = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    //[self.view addSubview:self.container];
    
    //self.container.backgroundColor = [UIColor colorWithRed:174/255.0f green:216/255.0f blue:190/255.0f alpha:1.0f];

    //FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://raphaelschaad.com/static/nyan.gif"]]];
    
    //self.displayImageView = [[FLAnimatedImageView alloc] init];
    //twice
    //self.displayImageView.frame = CGRectMake(self.view.frame.size.width/2 - side/2, 100, side, side);
    //self.imageFrame = self.displayImageView.frame;
    //self.innerContainer = [[UIView alloc] initWithFrame:self.displayImageView.frame];
    //[self.container addSubview:self.innerContainer];
    
    //self.displayImageView.animatedImage = image;

    //CGFloat ratio = [self ratioForImage:self.displayImageView.image];
    //twice
    //self.displayImageView.frame = CGRectMake(0, 0, side, side);
    //[self.innerContainer addSubview:self.displayImageView];
    //@"http://raphaelschaad.com/static/nyan.gif"

    self.ourImage = [UIImage animatedImageWithAnimatedGIFURL:[[NSURL alloc] initWithString:@"file:///Users/sarah/Desktop/nyan.gif"]];

    NSLog(@"images: %@", self.ourImage.images);
    
    //self.textField1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 16, self.innerContainer.frame.size.width, 50)];
    //self.textField2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 221, self.innerContainer.frame.size.width, 50)];
    //UITextField *textField3 = [[UITextField alloc] initWithFrame:CGRectMake(0, 456, self.view.bounds.size.width, 50)];
    //self.textField1.text = @"HAPPY BIRTHDAY SARAH!";
    //self.textField2.text = @"FROM HEATHER";
    //textField3.text = @"TEXT3";
    //self.textField1.font = [UIFont boldSystemFontOfSize:18];
    //self.textField2.font = [UIFont boldSystemFontOfSize:18];
    //textField3.font = [UIFont boldSystemFontOfSize:18];
    //self.textField1.textColor = [UIColor whiteColor];
    //self.textField2.textColor = [UIColor whiteColor];
    //textField3.textColor = [UIColor redColor];
    //self.textField1.textAlignment = NSTextAlignmentCenter;
    //self.textField2.textAlignment = NSTextAlignmentCenter;
    //textField3.textAlignment = NSTextAlignmentCenter;
    //[self.innerContainer addSubview:self.textField1];
    //[self.innerContainer addSubview:self.textField2];
    //[self.container addSubview:textField3];
    
    
    //UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //CGFloat buttonWidth = 125;
    //CGFloat buttonX = (self.view.bounds.size.width/2) - (buttonWidth/2);
    
    //button.frame = CGRectMake(buttonX, self.displayImageView.image.size.height * ratio - 75, buttonWidth, 35);
    //button.backgroundColor = [UIColor colorWithRed:65/255.0f green:102/255.0f blue:79/255.0f alpha:1.0f];
    //button.layer.cornerRadius = 17;
    //button.layer.masksToBounds = YES;
    //[button setTitle:@"SEND" forState:UIControlStateNormal];
    //button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    //[button setTitleColor:[UIColor colorWithRed:223/255.0f green:239/255.0f blue:229/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    //UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    //tapRecognizer.numberOfTouchesRequired = 1;
    //tapRecognizer.numberOfTapsRequired = 1;
    //[self.container addGestureRecognizer:tapRecognizer];
    //[self.container addSubview:button];
    //[button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];

    self.ourImages = [[NSMutableArray alloc] init];
}

#pragma mark - datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GifCollectionViewCell *cell = (GifCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *url = self.dataSource[indexPath.row];
    
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat buttonWidth = 125;
    CGFloat buttonX = (self.view.bounds.size.width/2) - (buttonWidth/2);
    
    button.frame = CGRectMake(buttonX, 450, buttonWidth, 35);
    button.backgroundColor = [UIColor colorWithRed:65/255.0f green:102/255.0f blue:79/255.0f alpha:1.0f];
    button.layer.cornerRadius = 17;
    button.layer.masksToBounds = YES;
    [button setTitle:@"SEND" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [button setTitleColor:[UIColor colorWithRed:223/255.0f green:239/255.0f blue:229/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    tapRecognizer.numberOfTouchesRequired = 1;
    tapRecognizer.numberOfTapsRequired = 1;
    [cell.container addGestureRecognizer:tapRecognizer];
    [cell.container addSubview:button];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    cell.displayImageView.animatedImage = image;
    cell.displayImageView.layer.borderColor = [UIColor blackColor].CGColor;
    cell.displayImageView.layer.borderWidth = 3.0;

    
    return cell;
}


#pragma mark - helper
- (void)setupCollectionView
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [flowLayout setItemSize:CGSizeMake(self.view.frame.size.width, 548)];
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds  collectionViewLayout:flowLayout];
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView registerClass:[GifCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor colorWithRed:174/255.0f green:216/255.0f blue:190/255.0f alpha:1.0f];
    
    [self.view addSubview:self.collectionView];
    
}

- (void)buttonAction
{
    NSUInteger i = 0;
    NSInteger side = 300;
    
    for (UIImage *image in self.ourImage.images) {
        if (self.containerImageView) {
            [self.containerImageView removeFromSuperview];
            self.containerImageView.image = nil;
            self.containerImageView = nil;
            [self.textField1 removeFromSuperview];
            [self.textField2 removeFromSuperview];
        }
        self.containerImageView = [UIImageView new];
        self.containerImageView.frame = CGRectMake(0, 0, 300, 300);
        self.containerImageView.image = image;
        [self.innerContainer addSubview:self.containerImageView];
        [self.innerContainer addSubview:self.textField1];
        [self.innerContainer addSubview:self.textField2];
        
        UIGraphicsBeginImageContext(CGSizeMake(side, side));
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.innerContainer.layer renderInContext:context];
        UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.ourImages addObject:screenShot];
        UIImageView *iv = [[UIImageView alloc] initWithImage:screenShot];
        NSLog(@"screenshot: %@", screenShot);
        iv.frame = CGRectMake(0, side * i, side, side);
//        [self.container addSubview:iv];
        i++;
    }
    
   //selfcell.container.contentSize = CGSizeMake(self.view.frame.size.width, i * side);
    
    //self.containerImageView.hidden = YES;
    
   // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
       makeAnimatedGif(self.ourImages, self.ourImages.count, self.ourImage.duration);
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [self popSMS];
        });
    });
}

- (void)hideKeyBoard
{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
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

- (void)popSMS
{
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;

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

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
