//
//  DOTableElementCellCell.h
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOTableElementCell : UITableViewCell
{
    __weak DOTableElement *_element;
}

@property (nonatomic, weak) DOTableElement *element;
@property (nonatomic, assign) CGFloat height;

- (id)initWithElement:(DOTableElement*)element;
- (id)initWithElement:(DOTableElement*)element tableViewCellStyle:(UITableViewCellStyle)style;

@end
