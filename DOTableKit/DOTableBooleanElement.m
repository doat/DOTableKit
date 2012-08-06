//
//  DOTableBooleanElement.m
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableKit.h"

@implementation DOTableBooleanElement
@synthesize style;

- (Class)cellClass
{
    switch (style) {
        case DOTableBooleanElementStyleSwitch:
            return [DOTableSwitchElementCell class];
        case DOTableBooleanElementStyleCheckbox:
            return [DOTableCheckElementCell class];
        default:
            [NSException raise:NSInternalInconsistencyException 
                        format:@"DOTableBooleanElement style must be DOTableBooleanElementStyleSwitch or DOTableBooleanElementStyleCheckbox"];
    }
}

- (id)initWithTitle:(NSString *)title boolean:(BOOL)boolVal
{
    self = [super initWithTitle:title];
    if (self) 
    {
        self.value = [NSNumber numberWithBool:boolVal];
        self.style = DOTableBooleanElementStyleSwitch;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title boolean:(BOOL)boolVal key:(NSString*)aKey
{
    self = [super initWithTitle:title];
    if (self) 
    {
        self.value = [NSNumber numberWithBool:boolVal];
        self.style = DOTableBooleanElementStyleSwitch;
        self.key = aKey;
    }
    return self;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView
{
    DOTableElementCell *cell = (DOTableElementCell *)[super cellForTableView:tableView cellBaseStyle:(UITableViewCellStyleDefault)];
    
    switch (style) {
        case DOTableBooleanElementStyleSwitch:
        {
            ((DOTableSwitchElementCell*)cell).switchControl.on = [self.value boolValue];
        }
            break;
        case DOTableBooleanElementStyleCheckbox:
        {
            [cell.textLabel setFont:[UIFont systemFontOfSize:17.0f]];
            [((DOTableCheckElementCell*)cell).buttonControl setSelected: [self.value boolValue]];
        }
            break;
        default:
            break;
    }
    
    cell.textLabel.text = self.title;
    cell.detailTextLabel.text = nil; 
    cell.imageView.image = nil; 
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.showsReorderControl = YES;
    cell.accessoryView = nil;
    
    return cell;
}

@end
