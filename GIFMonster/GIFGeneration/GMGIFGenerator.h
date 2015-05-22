//
// Created by Jabari Bell on 5/22/15.
// Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMGIFGenerator : NSObject

/*
Generates a GIF from array of images.
 */
+ (void)generateGIFFromImages:(NSArray *)images duration:(NSTimeInterval)duration completion:(void (^)(NSURL *fileURL))completionBlock error:(void (^)(NSError **errorPtr))errorBlock;

@end