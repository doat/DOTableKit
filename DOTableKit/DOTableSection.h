//
//  DOTableSection.h
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DOTableElement;

@interface DOTableSection : NSObject
{
    __weak DOTableDefinition *_form;
    
    NSString *_key;
    NSString *_title;
    
    NSString *_footer;
    
    __strong NSMutableArray *_elements;
    
    UIView *(^footerViewBlock)(NSString *footerText);
    UIView *(^headerViewBlock)(NSString *headerText);
}

@property (nonatomic, weak) DOTableDefinition *form;

@property (nonatomic, readonly) NSMutableArray *elements;
@property (nonatomic, retain) NSString *key;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *footer;

@property (nonatomic, copy) UIView*(^footerViewBlock)(NSString *footerText);
@property (nonatomic, copy) UIView*(^headerViewBlock)(NSString *headerText);

+ (id)sectionWithElements:(DOTableElement*)first, ...;
+ (id)sectionWithTitle:(NSString*)aTitle elements:(DOTableElement*)first, ...;
+ (id)sectionWithKey:(NSString*)aKey elements:(DOTableElement*)first, ...;
+ (id)sectionWithTitle:(NSString*)aTitle key:(NSString*)aKey elements:(DOTableElement*)first, ...;

- (id)initWithTitle:(NSString*)title;
- (id)initWithTitle:(NSString *)title key:(NSString*)key;
- (void)addElement:(DOTableElement*)section;
- (void)addElement:(DOTableElement*)element atIndex:(NSUInteger)index;
- (void)removeElement:(DOTableElement*)element;
- (void)removeAllElements;
- (void)replaceElement:(DOTableElement*)currentElement withElement:(DOTableElement*)newElement;
- (void)tableElement:(DOTableElement *)element valueDidChange:(id)value;
- (void)tableElementDidBecomeFirstResponder:(DOTableElement *)element;

@end
