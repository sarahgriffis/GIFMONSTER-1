//
// Created by Jabari Bell on 5/22/15.
// Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface GMSMSUtil : NSObject

- (instancetype)initWithViewController:(UIViewController *)viewController;
- (void)popSMSForFileAtURL:(NSURL *)fileURL;

@end