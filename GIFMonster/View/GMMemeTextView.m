//
// Created by Jabari Bell on 5/22/15.
// Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import "GMMemeTextView.h"

@interface GMMemeTextView()

@property (nonatomic, strong) UITextField *topTextField;
@property (nonatomic, strong) UITextField *bottomTextField;
@property (nonatomic, strong) NATouchThroughView *touchThroughView;

@end

@implementation GMMemeTextView

- (instancetype)initWithFrame:(CGRect)frame topText:(NSString *)topText bottomText:(NSString *)bottomText
{
    self = [super initWithFrame:frame];
    if (self) {
        self.topTextField.text = topText;
        self.bottomTextField.text = bottomText;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    static NSInteger textFieldHeight = 30;
    static NSInteger margin = 10;
    self.topTextField.frame = CGRectMake(0, margin, self.bounds.size.width, textFieldHeight);
    self.bottomTextField.frame = CGRectMake(0, self.bounds.size.height - textFieldHeight - margin, self.bounds.size.width, textFieldHeight);
    self.touchThroughView.frame = CGRectMake(0, margin + textFieldHeight, self.bounds.size.width, self.bounds.size.height - (2 * (margin + textFieldHeight)));
}

#pragma mark - Lazy Loading
- (UITextField *)topTextField
{
    if (!_topTextField) {
        _topTextField = [UITextField new];
        _topTextField.textAlignment = NSTextAlignmentCenter;
        _topTextField.font = [UIFont boldSystemFontOfSize:18];
        _topTextField.textColor = [UIColor whiteColor];
        _topTextField.userInteractionEnabled = YES;
        [self addSubview:_topTextField];
    }
    return _topTextField;
}

- (UITextField *)bottomTextField
{
    if (!_bottomTextField) {
        _bottomTextField = [UITextField new];
        _bottomTextField.textAlignment = NSTextAlignmentCenter;
        _bottomTextField.font = [UIFont boldSystemFontOfSize:18];
        _bottomTextField.textColor = [UIColor whiteColor];
        [self addSubview:_bottomTextField];
    }
    return _bottomTextField;
}

- (NATouchThroughView *)touchThroughView
{
    if (!_touchThroughView) {
        _touchThroughView = [NATouchThroughView new];
        [self addSubview:_touchThroughView];
    }
    return _touchThroughView;
}

@end
