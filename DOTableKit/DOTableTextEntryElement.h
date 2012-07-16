//
//  DOTableTextEntryElement.h
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableElement.h"

@interface DOTableTextEntryElement : DOTableElement
{
    NSString *_placeholder;
    void (^returnBlock)(id value);
    
    BOOL _scrollsWhenHidden;
}

@property (nonatomic, retain) NSString *placeholder;

@property (nonatomic, assign) UIKeyboardType keyboardType;
@property (nonatomic, assign) UIReturnKeyType returnKeyType;
@property (nonatomic, assign, getter = isSecure) BOOL secure;

@property (nonatomic, copy) void (^returnBlock)(id value);

- (id)initWithTitle:(NSString *)title placeholder:(NSString*)placeholder;
- (id)initWithPlaceholder:(NSString*)placeholder;
- (id)initWithTitle:(NSString *)title placeholder:(NSString*)placeholder key:(NSString*)key;
- (id)initWithPlaceholder:(NSString*)placeholder key:(NSString*)key;

@end
