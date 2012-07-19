//
//  DOTableBooleanElementCell.m
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DOTableKit.h"

@implementation DOTableSwitchElementCell
@synthesize switchControl = _switchControl;

- (id)initWithElement:(DOTableElement *)element tableViewCellStyle:(UITableViewCellStyle)style
{
    self = [super initWithElement:element tableViewCellStyle:style];
    if (self) 
    {
        [self setupCell];
    }
    return self;
}

- (id)initWithElement:(DOTableBooleanElement*)element
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
    _switchControl = [[UISwitch alloc] initWithFrame:CGRectZero];
    _switchControl.on = [[_element value] boolValue];
    _switchControl.layer.anchorPoint = CGPointMake(1.0f, 0.0f);
    [_switchControl addTarget:self action:@selector(boolValueChanged:) forControlEvents:UIControlEventValueChanged];        
    
    _switchControl.enabled = _element.enabled;
    
    [self.contentView insertSubview:_switchControl aboveSubview:self.textLabel];    
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    _switchControl.center = CGPointMake(self.contentView.frame.size.width-10, 10);
}

- (void)boolValueChanged:(id)sender
{
    [_element setValue: [NSNumber numberWithBool:_switchControl.on]];
}

@end
