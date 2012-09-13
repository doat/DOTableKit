//
//  DOTableTextViewElementCell.m
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableTextViewElementCell.h"

#define kPadding 5

@implementation DOTableTextViewElementCell
@synthesize textView = _textView;

-(id)initWithElement:(DOTableElement *)element tableViewCellStyle:(UITableViewCellStyle)style
{
    self = [super initWithElement:element tableViewCellStyle:style];
    if (self)
    {
        [self setupCell];
    }
    return self;
}

- (id)initWithElement:(DOTableTextFieldElement *)element
{
    self = [super initWithElement:element];
    if (self)
    {
        [self setupCell];
    }
    return self;
}

- (void)setupCell
{
    _textView = [[UITextView alloc] initWithFrame:CGRectZero];
    _textView.keyboardType = ((DOTableTextFieldElement *)_element).keyboardType;
    _textView.secureTextEntry = ((DOTableTextFieldElement *)_element).isSecure;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.font = [UIFont systemFontOfSize:16.0f];
    _textView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(textDidChange:)
                                                 name: UITextViewTextDidChangeNotification object: _textView];
    
    [self.contentView insertSubview:_textView aboveSubview:self.textLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (IsEmpty(self.textLabel.text))
    {
        _textView.frame = CGRectMake(kPadding,2,self.contentView.frame.size.width-5-kPadding, self.frame.size.height-20);
    }
    else
    {
        CGFloat fontSize = self.textLabel.font.pointSize == 0? 17 : self.textLabel.font.pointSize;
        CGSize size = [_element.title sizeWithFont:[self.textLabel.font fontWithSize:fontSize] forWidth:CGFLOAT_MAX lineBreakMode:UILineBreakModeWordWrap] ;
        
        _textView.frame = CGRectMake(size.width+5+kPadding,2,self.contentView.frame.size.width-size.width-5-kPadding, self.frame.size.height-20);
        
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_element cellDidBecomeFirstResponder];
    
    superviewTaps = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(_dismissKeyboard:)];
    
    superviewTaps.delegate = self;
    [_element.section.form.tableView addGestureRecognizer:superviewTaps];
}

- (void)textDidChange:(NSNotification*)notif
{
    [_element setValue: _textView.text];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_element setValue:textField.text];
    [_element.section.form.tableView removeGestureRecognizer:superviewTaps];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_element setValue:textField.text];
    
    if([(DOTableTextFieldElement *)self.element returnBlock])
    {
        ((DOTableTextFieldElement *)self.element).returnBlock(_element.value);
    }
    
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchPoint = [touch locationInView:self];
    if (!CGRectContainsPoint(self.textView.frame, touchPoint))
    {
        return YES;
    }
    
    return NO;
}

- (void)_dismissKeyboard:(UITapGestureRecognizer*)recognizer
{
    [_textView endEditing:YES];
    [_element.section.form.tableView removeGestureRecognizer:superviewTaps];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
