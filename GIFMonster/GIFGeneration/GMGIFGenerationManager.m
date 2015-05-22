//
// Created by Jabari Bell on 5/22/15.
// Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import "GMGIFGenerationManager.h"
#import "GMGIFGenerator.h"
#import "GMSnapshotGenerator.h"

@implementation GMGIFGenerationManager

+ (void)generateGIFForAnimatedBackgroundImage:(UIImage *)animatedImage topView:(UIView *)topView completion:(void (^)(NSURL *fileURL))completionBlock error:(void (^)(NSError **error))errorBlock
{
    NSArray *snapshots = [GMSnapshotGenerator snapshotImagesForImagesInAnimatedBackgroundImage:animatedImage topView:topView];
    [GMGIFGenerator generateGIFFromImages:snapshots duration:animatedImage.duration completion:completionBlock error:errorBlock];
}

@end