//
//  DOTableDefinition.h
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class DOTableElementCell;
@class DOTableDefinition;
@class DOTableSection;
@class DOTableElement;

@protocol DOTableDefinitionDelegate <NSObject>
@optional
- (void)tableElement:(DOTableElement *)element valueDidChange:(id)value;
- (void)tableDefinition:(DOTableDefinition*)form willDisplayCell:(DOTableElementCell*)cell forElement:(DOTableElement*)element inTableView:(UITableView*)tableView;
@end

@interface DOTableDefinition : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<DOTableDefinitionDelegate> delegate;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, readonly) NSMutableArray *sections;

- (NSIndexPath*)indexPathByElement:(DOTableElement*)element;

- (void)addSection:(DOTableSection*)section;
- (NSDictionary*) valuesDictionary;

- (DOTableSection*) sectionAtIndex:(NSUInteger)index;
- (DOTableSection*) sectionForKey:(NSString*)aKey;
- (DOTableElement*) elementForKey:(NSString*)aKey;

- (void)tableElement:(DOTableElement *)element valueDidChange:(id)value;

@end

@interface UIScrollView (DOTableKit)
- (CGRect)DO_visibleRect;
@end