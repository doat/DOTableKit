//
//  DOTableElement.h
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOTableElement : NSObject
{
    __weak DOTableSection *_section;
    
    NSString *_title;
    NSString *_key;
    id value;
    
    void (^actionBlock)();
    
    BOOL enabled;
    BOOL invalid;
}

@property (nonatomic, weak) DOTableSection *section;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) id value;

@property (nonatomic, copy) void (^action)();

@property (nonatomic, assign) BOOL enabled;

- (Class)cellClass;
- (id)initWithKey:(NSString*)key;
- (id)initWithTitle:(NSString*)title;
- (UITableViewCell *)cellForTableView:(UITableView *)tableView;
- (UITableViewCell *)cellForTableView:(UITableView *)tableView cellBaseStyle:(UITableViewCellStyle)cellStyle;

- (void)markAsInvalid:(BOOL)invalid;

@end
