//
// Created by Jabari Bell on 5/22/15.
// Copyright (c) 2015 PaperlessPost. All rights reserved.
//

#import "GMMemeTextView.h"

@interface GMMemeTextView() <UITextFieldDelegate>

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
        _topTextField.delegate = self;
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
        _bottomTextField.delegate = self;
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

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    return [[GMMemeTextView alloc] initWithFrame:self.bounds topText:self.topTextField.text bottomText:self.bottomTextField.text];
}

#pragma mark - Keyboard
- (void)hideKeyboard
{
    [self.topTextField resignFirstResponder];
    [self.bottomTextField resignFirstResponder];
}

//http://stackoverflow.com/questions/433337/set-the-maximum-character-length-of-a-uitextfield
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 20;
}


@end
