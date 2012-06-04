//
//  DOTableDetailLabelElement.m
//  DOTableKit
//
//  Created by Hezi Cohen on 5/20/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableKit.h"

@implementation DOTableDetailLabelElement

- (Class)cellClass
{
    return [DOTableElementCell class];
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView
{
    DOTableElementCell *cell = (DOTableElementCell *)[super cellForTableView:tableView cellBaseStyle:(UITableViewCellStyleValue1)];
    
    cell.textLabel.text = self.title; 
    cell.detailTextLabel.text = self.value; 
    cell.imageView.image = nil; 
    
    if(self.action && self.enabled)
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    else
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.showsReorderControl = YES;
    cell.accessoryView = nil;
    
    return cell;
}

@end
