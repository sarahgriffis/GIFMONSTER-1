//
// Created by Jabari Bell on 5/22/15.
// Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import "GMSnapshotGenerator.h"


@implementation GMSnapshotGenerator

/*
Creates an array of snapshot UIImages from an animated background image and then a topView that contains the view that holds the content that should be above the animated GIF.
 */
+ (NSArray *)snapshotImagesForImagesInAnimatedBackgroundImage:(UIImage *)image topView:(UIView *)topView
{
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    NSMutableArray *snapshots = [NSMutableArray array];
    for (UIImage *snapshot in image.images) {

        //1. create a UIView that will hold the text and background image frame
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageHeight)];

        //2. create UIImageView that holds the background image
        UIImageView *imageView = [[UIImageView alloc] initWithImage:snapshot];

        //3. add imageView to container
        [containerView addSubview:imageView];

        //4. then add text view to the top
        [containerView addSubview:topView];

        //5. take snapshot of the container view with the background frame and the top text view
        UIGraphicsBeginImageContext(CGSizeMake(imageWidth, imageHeight));
        CGContextRef context = UIGraphicsGetCurrentContext();
        [containerView.layer renderInContext:context];

        //6. get a reference of the snapshot from the current image context
        UIImage *containerSnapshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        //7. add snapshot to the snapshots array
        [snapshots addObject:containerSnapshot];
    }

    return [snapshots copy];
}

@end