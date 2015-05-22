//
// Created by Jabari Bell on 5/22/15.
// Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NARootTouchThroughView.h"
#import "NATouchThroughView.h"

@interface GMMemeTextView : NARootTouchThroughView

- (instancetype)initWithFrame:(CGRect)frame topText:(NSString *)topText bottomText:(NSString *)bottomText;

@end