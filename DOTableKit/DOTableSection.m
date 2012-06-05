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

- (id)initWithTitle:(NSString*)title
{
    self = [super init];
    if (self) 
    {
        self.title = title;
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

@end
