//
// Created by Jabari Bell on 5/22/15.
// Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import "GMGIFGenerator.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MFMessageComposeViewController.h>


@implementation GMGIFGenerator

#pragma mark - Public
/*
 Generates a GIF from an array of images.
 */
+ (void)generateGIFFromImages:(NSArray *)images duration:(NSTimeInterval)duration completion:(void (^)(NSURL *fileURL))completionBlock error:(void (^)(NSError **errorPtr))errorBlock
{
    __block NSError *error;
    __block NSURL *fileURL;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        fileURL = makeAnimatedGif(images, images.count, duration, &error);
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (error) {
                if (errorBlock) {
                    errorBlock(&error);
                }
                return;
            }

            if (completionBlock) {
                completionBlock(fileURL);
            }
        });
    });

}

#pragma mark - Private
/*
    Private GIF generation.  Creates GIF and returns NSURL of the file's location.
 */
static NSURL* makeAnimatedGif(NSArray *ourImages, NSUInteger frameCount, NSTimeInterval duration, NSError **error) {

    CGFloat delaytime = roundf((duration/frameCount * 100))/100;

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
        *error = [NSError errorWithDomain:@"" code:0 userInfo:nil];
    }
    CFRelease(destination);

    NSLog(@"url=%@", fileURL);

    return fileURL;
}

@end