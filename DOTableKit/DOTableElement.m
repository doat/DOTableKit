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
@synthesize cellSelectionStyle;
@synthesize cellHeight;
@synthesize actionBlock;

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, key: %@, value: %@>", NSStringFromClass([self class]), self, self.key, self.value];
}

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

- (id)initWithTitle:(NSString*)aTitle key:(NSString*)aKey
{
    self = [self init];
    if (self) 
    {
        self.title = aTitle;
        self.key = aKey;
    }
    return self;
}

- (id)initWithTitle:(NSString*)aTitle key:(NSString*)aKey value:(id)aValue
{
    self = [self init];
    if (self) 
    {
        self.title = aTitle;
        self.key = aKey;
        self.value = aValue;
    }
    return self;
}

- (id)initWithTitle:(NSString*)aTitle actionBlock:(void(^)(DOTableElement *e))block
{
    self = [self init];
    if (self) 
    {
        self.title = aTitle;
        self.actionBlock = block;
    }
    return self;
}


- (id)initWithTitle:(NSString *)aTitle key:(NSString *)aKey actionBlock:(void (^)(DOTableElement *))block
{
    self = [self initWithTitle:aTitle key:aKey];
    if (self) 
    {
        self.actionBlock = block;
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

- (void)cellDidBecomeFirstResponder
{
    [self.section tableElementDidBecomeFirstResponder:self];
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
    
    cell.element = self;
    cell.shouldIndentWhileEditing = self.shouldIndentWhileEditing;
    cell.textLabel.text = self.title; 
    cell.detailTextLabel.text = self.value; 
    cell.imageView.image = nil; 
    
    if(self.actionBlock && self.enabled)
        cell.selectionStyle = self.cellSelectionStyle;
    else
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.showsReorderControl = YES;
    cell.accessoryView = nil;
    
    if(invalid)
        cell.textLabel.textColor = rgbColor(0xda2e2e);
       
    return cell;
}

@end
