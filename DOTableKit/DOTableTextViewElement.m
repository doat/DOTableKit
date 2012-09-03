//
//  DOTableTextViewElement.m
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableKit.h"

@implementation DOTableTextViewElement
@synthesize placeholder = _placeholder;
@synthesize keyboardType = _keyType;
@synthesize keyboardAppearance = _keyboardAppearance;
@synthesize returnKeyType = _returnKeyType;
@synthesize secure = _secure;
@synthesize returnBlock;

- (id)initWithTitle:(NSString *)title placeholder:(NSString*)placeholder
{
    self = [super initWithTitle:title];
    if (self) 
    {
        self.placeholder = placeholder;
        self.value = @"";
        self.keyboardType = UIKeyboardTypeDefault;
        self.keyboardAppearance = UIKeyboardAppearanceDefault;
    }
    return self;
}

- (id)initWithPlaceholder:(NSString*)placeholder
{
    self = [self initWithTitle:nil placeholder:placeholder];
    if (self) 
    {
    }
    return self;
}

- (id)initWithPlaceholder:(NSString*)placeholder key:(NSString*)key
{
    self = [self initWithTitle:nil placeholder:placeholder];
    if (self) 
    {
        self.key = key;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title placeholder:(NSString*)placeholder key:(NSString*)key
{
    self = [self initWithTitle:title placeholder:placeholder];
    if (self) 
    {
        self.key = key;
    }
    return self;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView
{
    DOTableTextViewElementCell *cell = (DOTableTextViewElementCell *)[super cellForTableView:tableView cellBaseStyle:(UITableViewCellStyleDefault)];
    
    [cell.textView setKeyboardType:self.keyboardType];
    [cell.textView setReturnKeyType:self.returnKeyType];
    [cell.textView setKeyboardAppearance: self.keyboardAppearance];
    [cell.textView setSecureTextEntry:self.isSecure];
    cell.textView.text = self.value;
    cell.textLabel.text = self.title;
    
    cell.detailTextLabel.text = nil; 
    cell.imageView.image = nil; 
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.showsReorderControl = YES;
    cell.accessoryView = nil;
    
    return cell;
}

@end
