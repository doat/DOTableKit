//
//  DOTableTextEntryElementCell.m
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableTextEntryElementCell.h"

#define kPadding 10

@implementation DOTableTextEntryElementCell
@synthesize textField = _textField;

-(id)initWithElement:(DOTableElement *)element tableViewCellStyle:(UITableViewCellStyle)style
{
    self = [super initWithElement:element tableViewCellStyle:style];
    if (self) 
    {
        [self setupCell];
    }
    return self;    
}

- (id)initWithElement:(DOTableTextEntryElement*)element
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
    _textField = [[UITextField alloc] initWithFrame:CGRectZero];
    _textField.keyboardType = ((DOTableTextEntryElement*)_element).keyboardType;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.placeholder = ((DOTableTextEntryElement*)_element).placeholder;
    _textField.secureTextEntry = ((DOTableTextEntryElement*)_element).isSecure;
    _textField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(textDidChange:)
                                                 name: UITextFieldTextDidChangeNotification object: _textField];
    
    [self.contentView insertSubview:_textField aboveSubview:self.textLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (IsEmpty(self.textLabel.text)) 
    {
        _textField.frame = CGRectMake(kPadding,10,self.contentView.frame.size.width-10-kPadding, self.frame.size.height-20);
    }
    else
    {
        CGFloat fontSize = self.textLabel.font.pointSize == 0? 17 : self.textLabel.font.pointSize;
        CGSize size = [_element.title sizeWithFont:[self.textLabel.font fontWithSize:fontSize] forWidth:CGFLOAT_MAX lineBreakMode:UILineBreakModeWordWrap] ;
        
        _textField.frame = CGRectMake(size.width+5+kPadding,10,self.contentView.frame.size.width-size.width-10-kPadding, self.frame.size.height-20);
        
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    originalContentOffset = _element.section.form.tableView.contentOffset;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 50 * USEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSIndexPath *ip = [_element.section.form indexPathByElement:_element];
        UITableViewCell *cell = [_element.section.form.tableView cellForRowAtIndexPath:ip]; 
        CGFloat sectionHeight = [_element.section.form.tableView sectionFooterHeight];
        CGPoint newOffset = CGPointMake(0, cell.frame.origin.y - sectionHeight);
        [_element.section.form.tableView setContentOffset:newOffset animated:YES];
    });
    
}

- (void)textDidChange:(NSNotification*)notif
{
    [_element setValue: _textField.text];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //[_element.section.form.tableView setContentOffset:originalContentOffset animated:YES];
    [_element setValue:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_element setValue:textField.text];

    if([(DOTableTextEntryElement*)self.element returnBlock])
    {
        ((DOTableTextEntryElement*)self.element).returnBlock(_element.value); 
    }

    [textField resignFirstResponder];
    
    return YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
