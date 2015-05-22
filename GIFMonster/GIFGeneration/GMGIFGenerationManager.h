//
// Created by Jabari Bell on 5/22/15.
// Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface GMGIFGenerationManager : NSObject

+ (void)generateGIFForAnimatedBackgroundImage:(UIImage *)animatedImage topView:(UIView *)topView completion:(void (^)(NSURL *fileURL))completionBlock error:(void (^)(NSError **error))errorBlock;

@end