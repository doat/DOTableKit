//
//  DOTableCheckElementCell.h
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableElementCell.h"

@interface DOTableCheckElementCell : DOTableElementCell
{
    UIButton *_button;
}

@property (nonatomic, readonly) UIButton *buttonControl;

@end
