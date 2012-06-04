//
//  DOTableCheckElementCell.m
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableKit.h"

@implementation DOTableCheckElementCell
@synthesize buttonControl = _button;

- (id)initWithElement:(DOTableBooleanElement*)element
{
    self = [super initWithElement:element];
    if (self) 
    {
        [self setupCell];
    }
    return self;
}

-(id)initWithElement:(DOTableElement *)element tableViewCellStyle:(UITableViewCellStyle)style
{
    self = [super initWithElement:element tableViewCellStyle:style];
    if (self) 
    {
        [self setupCell];
    }
    return self;
}

- (void)setupCell
{
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage imageNamed:@"radioButtonOff"] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageNamed:@"radioButtonOff"] forState:UIControlStateHighlighted];
    [_button setBackgroundImage:[UIImage imageNamed:@"radioButtonOn"] forState:UIControlStateSelected];
    
    [_button setSelected:[[_element value] boolValue]];
    
    [_button addTarget:self action:@selector(boolValueChanged:) forControlEvents:UIControlEventTouchUpInside];        
    
    [self.contentView insertSubview:_button aboveSubview:self.textLabel];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(boolValueChanged:)];
    [self.contentView addGestureRecognizer:tapRecognizer];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _button.frame = CGRectMake(5, 8, 30, 30);
    self.textLabel.frame = CGRectMake(40, self.textLabel.frame.origin.y, self.contentView.frame.size.width-50, self.textLabel.frame.size.height);
}

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        // handling code
    }
}

- (void)boolValueChanged:(id)sender
{   
    BOOL value = !_button.selected;
    [_button setSelected:value];
    [_element setValue:[NSNumber numberWithBool:value]];
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
