//
//  DOTableElement.m
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableKit.h"

@implementation DOTableElement
@synthesize section;
@synthesize key;
@synthesize title;
@synthesize value;
@synthesize enabled;
@synthesize cellBaseStyle;
@synthesize action = actionBlock;

- (Class)cellClass
{
    return NSClassFromString([NSString stringWithFormat:@"%@Cell", NSStringFromClass(self.class)]);
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        self.enabled = YES;
    }
    return self;
}

- (id)initWithKey:(NSString*)aKey
{
    self = [self init];
    if (self) 
    {
        self.key = aKey;
    }
    return self;
}

- (id)initWithTitle:(NSString*)aTitle
{
    self = [self init];
    if (self) 
    {
        self.title = aTitle;
    }
    return self;
}

- (void)setValue: (id)aValue
{
    if (value != aValue)
    {
        value = aValue;

        [self.section tableElement: self valueDidChange: value];
    }
}

- (void)markAsInvalid:(BOOL)mark
{
    invalid = mark;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView
{
    return [self cellForTableView:tableView cellBaseStyle:(UITableViewCellStyleDefault)];
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView cellBaseStyle:(UITableViewCellStyle)cellStyle
{
    DOTableElementCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self cellClass])];
    
    if (cell == nil)
    {
        Class cellClass = [self cellClass];
        cell = [[cellClass alloc] initWithElement:self tableViewCellStyle:cellStyle];
    }
    
    cell.textLabel.text = self.title; 
    cell.detailTextLabel.text = self.value; 
    cell.imageView.image = nil; 
    
    if(self.action && self.enabled)
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    else
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.showsReorderControl = YES;
    cell.accessoryView = nil;
    
    if(invalid)
        cell.textLabel.textColor = rgbColor(0xda2e2e);
       
    return cell;
}

@end
