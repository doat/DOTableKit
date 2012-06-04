//
//  DOTableElementCellCell.m
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableKit.h"

@implementation DOTableElementCell
@synthesize element = _element;
@synthesize height = _height;

- (id)initWithElement:(DOTableElement*)element tableViewCellStyle:(UITableViewCellStyle)style
{
    self = [super initWithStyle:style reuseIdentifier:NSStringFromClass(self.class)];
    
    if (self) 
    {
        _element = element;
        _height = 0;
    }
    return self;
}

- (id)initWithElement:(DOTableElement*)element
{
    self = [self initWithElement:element tableViewCellStyle:UITableViewCellStyleDefault];
    
    if (self) 
    {
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
