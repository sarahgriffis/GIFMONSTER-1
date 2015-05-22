//
// Created by Jabari Bell on 5/22/15.
// Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

/*
Generates a snapshot (collection of images) from a given UIImage and a top view that contains the stuffs that should be above the animated GIF.
 */
@interface GMSnapshotGenerator : NSObject

+ (NSArray *)snapshotImagesForImagesInAnimatedBackgroundImage:(UIImage *)image topView:(UIView *)topView;

@end
