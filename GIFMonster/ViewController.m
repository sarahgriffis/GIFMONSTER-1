//
//  ViewController.m
//  GIFMonster
//
//  Created by Jabari Bell on 5/14/15.
//  Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import "ViewController.h"
#import "FLAnimatedImage.h"

@interface ViewController ()
@property (nonatomic, strong) IBOutlet UITextField *textField1;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *container = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:container];

    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://raphaelschaad.com/static/nyan.gif"]]];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    
    imageView.frame = CGRectMake(0.0, 0.0, 300.0, 300.0);
    [container addSubview:imageView];

    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 240, 20)];
    myLabel.text = @"BAWS";
    myLabel.font = [UIFont boldSystemFontOfSize:20];
    myLabel.textColor = [UIColor whiteColor];
    [container addSubview:myLabel];
    
    UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(25, 175, 50, 50)];
    textField1.text = @"text1";
    textField2.text = @"text2";
    [container addSubview:textField1];
    [container addSubview:textField2];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(75, 175, 50, 50);
    button.layer.borderColor = [UIColor redColor].CGColor;
    button.layer.borderWidth = 0.5f;
    
    [container addSubview:button];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];





}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonAction
{
    UIGraphicsBeginImageContext(CGSizeMake(300,300));
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    UIView *container = self.view.subviews[2];
    //[container.layer renderInContext:context];
    //UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    //UIGraphicsEndImageContext();
    
    FLAnimatedImageView *imageView = container.subviews[0];
    
    UIImage *image11 = [imageView.animatedImage imageLazilyCachedAtIndex:11];
    
    
    //[imageview.animatedImage imageLazilyCachedAtIndex:11]
    //UIImageView *snapshot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300, 300, 300)];
    //snapshot.image = screenShot;
    //[self.view addSubview:snapshot];
}

@end
