//
//  DOTableTextEntryElement.m
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableKit.h"

@implementation DOTableTextEntryElement
@synthesize placeholder = _placeholder;
@synthesize keyboardType = _keyType;
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

- (UITableViewCell *)cellForTableView:(UITableView *)tableView
{
    DOTableTextEntryElementCell *cell = (DOTableTextEntryElementCell *)[super cellForTableView:tableView cellBaseStyle:(UITableViewCellStyleDefault)];
    
    [cell.textField setKeyboardType:self.keyboardType];
    [cell.textField setReturnKeyType:self.returnKeyType];
    [cell.textField setSecureTextEntry:self.isSecure];
    cell.textField.text = self.value;
    cell.textLabel.text = self.title;
    
    cell.detailTextLabel.text = nil; 
    cell.imageView.image = nil; 
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.showsReorderControl = YES;
    cell.accessoryView = nil;
    
    return cell;
}

@end
