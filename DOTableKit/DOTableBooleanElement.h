//
//  DOTableBooleanElement.h
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableElement.h"

typedef enum {
    DOTableBooleanElementStyleSwitch = 0,
    DOTableBooleanElementStyleCheckbox,
} DOTableBooleanElementCellStyle;

@interface DOTableBooleanElement : DOTableElement
{
    DOTableBooleanElementCellStyle style;
}

@property (nonatomic, assign) DOTableBooleanElementCellStyle style;

- (id)initWithTitle:(NSString *)title boolean:(BOOL)boolVal;
- (id)initWithTitle:(NSString *)title boolean:(BOOL)boolVal key:(NSString*)aKey;

@end
