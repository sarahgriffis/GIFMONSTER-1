//
// Created by Jabari Bell on 5/22/15.
// Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import "UIImage+Ratio.h"

@implementation UIImage (Ratio)

- (CGFloat)ratioForImageInContainerView:(UIView *)containerView
{
    CGFloat ratio = 1.0;
    //the image is smaller than the container view so can keep the ratio
    if (self.size.width < containerView.frame.size.width && self.size.height < containerView.frame.size.height) return ratio;

    if (self.size.width > self.size.height) {
        return containerView.frame.size.width / self.size.width;
    } else {
        return containerView.frame.size.height / self.size.height;
    }
}

@end
