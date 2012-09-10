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
    NSString *_title;
    NSString *_key;
    id value;
        
    BOOL enabled;
    BOOL invalid;
}

@property (nonatomic, weak) DOTableSection *section;
@property (nonatomic, strong) id representedObject;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) id value;

@property (nonatomic, copy) void (^actionBlock)(DOTableElement *e);
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) UITableViewCellSelectionStyle cellSelectionStyle;
@property (nonatomic, assign) UITableViewCellStyle cellBaseStyle;
@property (nonatomic, assign) BOOL enabled;

@property (nonatomic, assign) BOOL canEditCell;
@property (nonatomic, assign) BOOL canMoveCell;
@property (nonatomic, assign) BOOL shouldIndentWhileEditing;

- (Class)cellClass;
- (id)initWithKey:(NSString*)key;
- (id)initWithTitle:(NSString*)title;
- (id)initWithTitle:(NSString*)aTitle key:(NSString*)aKey;
- (id)initWithTitle:(NSString*)aTitle key:(NSString*)aKey value:(id)aValue;
- (id)initWithTitle:(NSString*)aTitle actionBlock:(void(^)(DOTableElement *e))block;
- (id)initWithTitle:(NSString*)aTitle key:(NSString*)aKey actionBlock:(void(^)(DOTableElement *e))block;
- (UITableViewCell *)cellForTableView:(UITableView *)tableView;
- (UITableViewCell *)cellForTableView:(UITableView *)tableView cellBaseStyle:(UITableViewCellStyle)cellStyle;

- (void)cellDidBecomeFirstResponder;
- (void)markAsInvalid:(BOOL)invalid;

@end
