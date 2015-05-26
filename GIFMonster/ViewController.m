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
#import "UIColor+GIFMonsterColors.h"
#import "GMMemeTextView.h"
#import "GMSMSUtil.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString *CellIdentifier = @"CellIdentifier";

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) GMMemeTextView *topView;
@property (nonatomic, strong) GMSMSUtil *smsUtil;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) NSIndexPath *selectedCellIndexPath;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor gifMonsterGreen];
    self.selectedCellIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];

    self.dataSource = @[
            @"http://raphaelschaad.com/static/nyan.gif",
            @"http://media.giphy.com/media/fA5fRLP2rMtP2/giphy.gif",
            @"http://media.giphy.com/media/5HSYaZTcRpYnS/giphy.gif",
            @"http://media.giphy.com/media/11SiBP2RFeBCHC/giphy.gif"
    ];
    
    [self setupCollectionView];
    [self setupTopView];
    [self setupSendButton];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //TODO: put this size in a global space
    self.topView.frame = CGRectMake(0, 0, 300, 300);
    self.topView.center = self.view.center;
    CGFloat buttonWidth = 125;
    CGFloat buttonX = (self.view.bounds.size.width / 2) - (buttonWidth / 2);
    self.sendButton.frame = CGRectMake(buttonX, self.topView.frame.size.height + self.topView.frame.origin.y + 20, buttonWidth, 35);
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
    [cell.animatedImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    }];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (UICollectionViewCell *cell in [self.collectionView visibleCells]) {
        self.selectedCellIndexPath = [self.collectionView indexPathForCell:cell];
    }
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

    UITapGestureRecognizer *recognizer = [UITapGestureRecognizer new];
    recognizer.numberOfTapsRequired = 1;
    [recognizer addTarget:self action:@selector(hideKeyboard)];
    [self.collectionView addGestureRecognizer:recognizer];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
}

- (void)setupTopView
{
    self.topView = [[GMMemeTextView alloc] initWithFrame:CGRectZero topText:@"LMOAZ" bottomText:@"OMFG"];
    [self.view addSubview:self.topView];
}

- (void)setupSendButton
{
    self.sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendButton.backgroundColor = [UIColor gifsendbuttonbackgroundGreen];
    self.sendButton.layer.cornerRadius = 17;
    self.sendButton.layer.masksToBounds = YES;
    [self.sendButton setTitle:@"SEND" forState:UIControlStateNormal];
    self.sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.sendButton setTitleColor:[UIColor gifSendButtonTextGreen] forState:UIControlStateNormal];
    [self.sendButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendButton];
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
- (void)buttonAction:(id)sender
{
    GMGIFCollectionViewCell *cell = (GMGIFCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:self.selectedCellIndexPath];
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [GMGIFGenerationManager generateGIFForAnimatedBackgroundImage:cell.animatedImage topView:[self.topView copy] completion:^(NSURL *fileURL) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [weakSelf.smsUtil presentMessageControllerForFileAtURL:fileURL];
    } error:^(NSError **error) {
        //do error stuffs
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        //TODO: Add error alert view.
    }];
}

#pragma mark - Keyboard
-(void)hideKeyboard
{
    [self.topView hideKeyboard];
}

@end
