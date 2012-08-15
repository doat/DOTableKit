//
//  DOTableSection.m
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableKit.h"

@implementation DOTableSection
@synthesize form = _form;
@synthesize elements = _elements;
@synthesize title = _title;
@synthesize key = _key;
@synthesize footer = _footer;
@synthesize footerViewBlock;
@synthesize headerViewBlock;

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p, key: %@, title: %@, footer: %@, elements: %@>", NSStringFromClass([self class]), self, self.key, self.title, self.footer, self.elements];
}

+ (id)sectionWithElements:(DOTableElement*)first, ...
{
	DOTableSection *instance = [[self alloc] init];
	if (instance) 
    {       
		va_list args;
		va_start(args, first);
        
        [instance addElement:first];
        
        DOTableElement *anElement;
        while ((anElement = va_arg(args, DOTableElement*)))
            [instance addElement:anElement];
        
		va_end(args);
	}
	return instance;
}

+ (id)sectionWithTitle:(NSString*)aTitle elements:(DOTableElement*)first, ...
{
	DOTableSection *instance = [[self alloc] initWithTitle:aTitle];
	if (instance) 
    {       
		va_list args;
		va_start(args, first);
        
        [instance addElement:first];
        
        DOTableElement *anElement;
        while ((anElement = va_arg(args, DOTableElement*)))
            [instance addElement:anElement];
        
		va_end(args);
	}
	return instance;
}

+ (id)sectionWithKey:(NSString*)aKey elements:(DOTableElement*)first, ...
{
	DOTableSection *instance = [[self alloc] init];
	if (instance) 
    {        
        instance.key = aKey;
        
		va_list args;
		va_start(args, first);
        
        [instance addElement:first];
        
        DOTableElement *anElement;
        while ((anElement = va_arg(args, DOTableElement*)))
            [instance addElement:anElement];
        
		va_end(args);
	}
	return instance;
}

+ (id)sectionWithTitle:(NSString*)aTitle key:(NSString*)aKey elements:(DOTableElement*)first, ...
{
	DOTableSection *instance = [[self alloc] initWithTitle:aTitle key:aKey];
	if (instance) 
    {                
		va_list args;
		va_start(args, first);
        
        [instance addElement:first];
        
        DOTableElement *anElement;
        while ((anElement = va_arg(args, DOTableElement*)))
            [instance addElement:anElement];
        
		va_end(args);
	}
	return instance;
}

- (id)initWithTitle:(NSString*)title
{
    self = [super init];
    if (self) 
    {
        self.title = title;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title key:(NSString*)key
{
    self = [super init];
    if (self) 
    {
        self.title = title;
        self.key = key;
    }
    return self;    
}

- (void)addElement:(DOTableElement*)element
{
    if(!_elements)
        _elements = [NSMutableArray array];
    
    element.section = self;
    
    [_elements addObject:element];
}

- (void)addElement:(DOTableElement*)element atIndex:(NSUInteger)index
{
    element.section = self;
    
    [_elements insertObject:element atIndex:index];
}


- (void)removeElement:(DOTableElement*)element
{
    if([_elements containsObject:element])
        [_elements removeObject:element];
}

- (void)removeAllElements
{
    [_elements removeAllObjects];
}

- (void)replaceElement:(DOTableElement*)currentElement withElement:(DOTableElement*)newElement
{
    if(![_elements containsObject:currentElement])
    {
        [NSException raise:NSInvalidArgumentException 
                    format:@"The element (%@) to be replaced has to be part of the section (%@)", currentElement.key, self];
    }
    
    NSUInteger currentElementIndex = [_elements indexOfObject:currentElement];
    [_elements replaceObjectAtIndex:currentElementIndex withObject:newElement];
}

- (void)tableElement:(DOTableElement *)element valueDidChange:(id)value
{
    [_form tableElement: element valueDidChange: value];
}

- (void)tableElementDidBecomeFirstResponder:(DOTableElement *)element;
{
    [_form tableElementDidBecomeFirstResponder:element];
}

@end
