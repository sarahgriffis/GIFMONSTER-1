//
// Created by Jabari Bell on 5/22/15.
// Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import "GMSMSUtil.h"

@interface GMSMSUtil() <MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) UIViewController *viewController;

@end

@implementation GMSMSUtil

- (instancetype)initWithViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}

- (void)popSMSForFileAtURL:(NSURL *)fileURL
{
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    NSData *imgData = [[NSFileManager defaultManager] contentsAtPath:fileURL];
    BOOL didAttachImage = [messageController addAttachmentData:imgData typeIdentifier:(__bridge NSString *)kUTTypeGIF filename:@"LOLZ.gif"];

    if (didAttachImage)
    {
        // Present message view controller on screen
        [self.viewController presentViewController:messageController animated:YES completion:nil];
    }
    else
    {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                               message:@"Failed to attach image"
                                                              delegate:nil
                                                     cancelButtonTitle:@"OK"
                                                     otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;

        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }

        case MessageComposeResultSent:
            break;

        default:
            break;
    }

    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

@end