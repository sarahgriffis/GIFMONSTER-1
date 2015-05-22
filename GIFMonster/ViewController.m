//
//  ViewController.m
//  GIFMonster
//
//  Created by Jabari Bell on 5/14/15.
//  Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import "GMGIFCollectionViewCell.h"
#import "GMGIFGenerationManager.h"
#import "UIImage+animatedGIF.h"
#import "UIColor+GIFMonsterColors.h"
#import "GMMemeTextView.h"
#import "GMSMSUtil.h"

static NSString *CellIdentifier = @"CellIdentifier";

@interface ViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) GMMemeTextView *topView;
@property (nonatomic, strong) GMSMSUtil *smsUtil;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor gifMonsterGreen];

    self.dataSource = @[
            @"http://raphaelschaad.com/static/nyan.gif",
            @"http://raphaelschaad.com/static/nyan.gif",
            @"http://raphaelschaad.com/static/nyan.gif"
    ];
    
    [self setupCollectionView];

    //TODO: Move to view did layout subviews
    self.topView = [[GMMemeTextView alloc] initWithFrame:CGRectMake(0, 0, 300, 300) topText:@"LMOAZ" bottomText:@"OMFG"];
    self.topView.center = self.view.center;
    [self.view addSubview:self.topView];

    //TODO: Add button
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GMGIFCollectionViewCell *cell = (GMGIFCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *url = self.dataSource[indexPath.row];
    UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:url]];
    cell.animatedImage = image;
    return cell;
}

#pragma mark - Helper
- (void)setupCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [flowLayout setItemSize:CGSizeMake(self.view.frame.size.width, self.view.bounds.size.height)];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds  collectionViewLayout:flowLayout];
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setCollectionViewLayout:flowLayout];
    [self.collectionView registerClass:[GMGIFCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
}

#pragma mark - Lazy
- (GMSMSUtil *)smsUtil
{
    if (!_smsUtil) {
        _smsUtil = [[GMSMSUtil alloc] initWithViewController:self];
    }
    return _smsUtil;
}

#pragma mark - Button Action
- (void)buttonAction
{
    //TODO: Get image from the currently selected cell
    UIImage *selectedBackgroundImage = [UIImage new];
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GMGIFGenerationManager generateGIFForAnimatedBackgroundImage:selectedBackgroundImage topView:self.topView completion:^(NSURL *fileURL) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf.smsUtil popSMSForFileAtURL:fileURL];
    } error:^(NSError **error) {
        //do error stuffs
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}

- (void)hideKeyBoard
{
    //TODO: forward this to the top view
}

@end
