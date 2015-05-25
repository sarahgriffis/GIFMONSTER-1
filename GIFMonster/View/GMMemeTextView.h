//
// Created by Jabari Bell on 5/22/15.
// Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NARootTouchThroughView.h"
#import "NATouchThroughView.h"

@interface GMMemeTextView : NARootTouchThroughView <NSCopying>

- (instancetype)initWithFrame:(CGRect)frame topText:(NSString *)topText bottomText:(NSString *)bottomText;

//TODO: Refactor this so it's not so tightly coupled.  Maybe the hideKeyboard method is a method from a top view protocol.
- (void)hideKeyboard;

@end