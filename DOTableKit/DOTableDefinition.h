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

@protocol DOTableDefinitionDelegate <NSObject, UIScrollViewDelegate>
@optional
- (void)tableElement:(DOTableElement *)element valueDidChange:(id)value;
- (void)tableElement:(DOTableElement *)element movedToSection:(DOTableSection*)section;
- (void)tableElementDidBecomeFirstResponder:(DOTableElement *)element;
- (void)tableDefinition:(DOTableDefinition*)form willDisplayCell:(DOTableElementCell*)cell forElement:(DOTableElement*)element inTableView:(UITableView*)tableView;
@end

@interface DOTableDefinition : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<DOTableDefinitionDelegate> delegate;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, readonly) NSMutableArray *sections;

+ (id)tableWithSections:(DOTableSection*)first, ...;

- (NSIndexPath*)indexPathForElement:(DOTableElement*)element;

- (void)addSection:(DOTableSection*)section;
- (NSDictionary*) valuesDictionary;
- (NSArray*)orderedValuesArray;
- (NSArray*)elementsArray;

- (DOTableSection*) sectionAtIndex:(NSUInteger)index;
- (DOTableSection*) sectionForKey:(NSString*)aKey;
- (DOTableElement*) elementForKey:(NSString*)aKey;
- (NSArray*) elementsForKey:(NSString*)key;
- (DOTableElement*) elementForIndexPath:(NSIndexPath*)indexPath;

- (void)tableElement:(DOTableElement *)element valueDidChange:(id)value;
- (void)tableElementDidBecomeFirstResponder:(DOTableElement *)element;

@end

@interface UIScrollView (DOTableKit)
- (CGRect)DO_visibleRect;
@end