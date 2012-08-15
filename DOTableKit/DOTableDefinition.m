//
//  DOTableDefinition.m
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableKit.h"

@implementation UIScrollView (DOTableKit)

- (CGRect)DO_visibleRect
{
    CGRect visibleRect;
    visibleRect.origin = self.contentOffset;
    visibleRect.size = self.bounds.size;
    
    float theScale = 1.0 / self.zoomScale;
    visibleRect.origin.x *= theScale;
    visibleRect.origin.y *= theScale;
    visibleRect.size.width *= theScale;
    visibleRect.size.height *= theScale;
    
    return visibleRect;
}

@end

@implementation DOTableDefinition
@synthesize delegate = _delegate;
@synthesize sections = _sections;
@synthesize tableView = _tableView;

+ (id)tableWithSections:(DOTableSection*)first, ...
{
	DOTableDefinition* instance = [[self alloc] init];
	if (instance) 
    {
		va_list args;
		va_start(args, first);

            [instance addSection:first];
        
            DOTableSection *aSection;
            while ((aSection = va_arg(args, DOTableSection*)))
                [instance addSection:aSection];

		va_end(args);
	}
	return instance;
}

- (void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    
}

- (void)addSection:(DOTableSection*)section
{
    if(!_sections)
        _sections = [NSMutableArray array];
    
    section.form = self;
    [_sections addObject:section];
}

- (NSDictionary*) valuesDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (DOTableSection *section in _sections) 
    {
        for (DOTableElement *element in section.elements) 
        {
            if(element.key)
                if(element.value)
                    [dict setObject:element.value forKey:element.key];
        }
    }
    
    return dict;
}

- (NSArray*)orderedValuesArray
{
    NSMutableArray *valuesArray = [NSMutableArray array];
    for (DOTableSection *section in _sections)
    {
        for (DOTableElement *element in section.elements)
        {
            if(element.key)
                if(element.value)
                    [valuesArray addObject:@{@"key":element.key, @"value":element.value}];
        }
    }
    
    return valuesArray;
}

- (void)tableElement:(DOTableElement *)element valueDidChange:(id)value
{
    if([_delegate respondsToSelector: @selector(tableElement:valueDidChange:)])
        [_delegate tableElement: element valueDidChange: value];
}

- (void)tableElementDidBecomeFirstResponder:(DOTableElement *)element;
{
    if([_delegate respondsToSelector: @selector(tableElementDidBecomeFirstResponder:)])
        [_delegate tableElementDidBecomeFirstResponder:element];
}

- (DOTableSection*) sectionAtIndex:(NSUInteger)index
{
    if(index < [_sections count])
        return [_sections objectAtIndex:index];
    
    return nil;
}

- (DOTableSection*) sectionForKey:(NSString*)aKey
{
    for (DOTableSection *section in _sections) 
    {
        if([section.key isEqualToString:aKey])
            return section;
    }
    return nil;
}

- (DOTableElement*) elementForKey:(NSString*)aKey
{
    for (DOTableSection *section in _sections) 
    {
        for (DOTableElement *element in section.elements) 
        {
            if([element.key isEqualToString:aKey])
                return element;
        }
    }
    return nil;
}

- (DOTableSection*) sectionForIndexPath:(NSIndexPath*)indexPath
{
    id sectionAtIndex = [_sections objectAtIndex:indexPath.section];
    DOTableSection *formSection = (DOTableSection*)sectionAtIndex;
    
    return formSection;
}

- (DOTableElement*) elementForIndexPath:(NSIndexPath*)indexPath
{
    id sectionAtIndex = [_sections objectAtIndex:indexPath.section];
    DOTableSection *formSection = (DOTableSection*)sectionAtIndex;
    
    id rowAtIndex = [formSection.elements objectAtIndex:indexPath.row];
    DOTableElement *formElement = (DOTableElement*)rowAtIndex;

    return formElement;
}

- (NSIndexPath*)indexPathForElement:(DOTableElement*)element
{
    NSInteger sectionIndex = [_sections indexOfObject:element.section];
    NSInteger elementIndex = [element.section.elements indexOfObject:element];
    
    return [NSIndexPath indexPathForRow:elementIndex inSection:sectionIndex];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [scrollView endEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id sectionAtIndex = [_sections objectAtIndex:section];
    DOTableSection *formSection = (DOTableSection*)sectionAtIndex;
    
    return [formSection.elements count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DOTableElement *formElement = [self elementForIndexPath:indexPath];

    if([_delegate respondsToSelector: @selector(tableDefinition:willDisplayCell:forElement:inTableView:)])
        [_delegate tableDefinition:self willDisplayCell:(DOTableElementCell*)cell forElement:formElement inTableView:tableView];
    
    return;   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DOTableElement *formElement = [self elementForIndexPath:indexPath];
    
    if(formElement.cellBaseStyle != UITableViewCellStyleDefault)
        return [formElement cellForTableView:tableView cellBaseStyle:formElement.cellBaseStyle];
    else
        return [formElement cellForTableView:tableView];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    DOTableElement *element = [self elementForIndexPath:indexPath];
    return element.canEditCell;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    DOTableElement *element = [self elementForIndexPath:indexPath];
    return element.canMoveCell;
}

-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    DOTableElement *element = [self elementForIndexPath:indexPath];
    return element.shouldIndentWhileEditing;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    DOTableElement *elementToMove = [self elementForIndexPath:fromIndexPath];
    
    DOTableSection *fromSection = [self sectionForIndexPath:fromIndexPath];
    [fromSection removeElement:elementToMove];
    
    DOTableSection *toSection = [self sectionForIndexPath:toIndexPath];
    [toSection addElement:elementToMove atIndex:toIndexPath.row];
    
    if([_delegate respondsToSelector:@selector(tableElement:movedToSection:)])
        [_delegate tableElement:elementToMove movedToSection:toSection];
    
    return;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    DOTableSection *formSection = (DOTableSection*)[_sections objectAtIndex:section];

    return formSection.title;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    DOTableSection *formSection = (DOTableSection*)[_sections objectAtIndex:section];    
    return formSection.footer;    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    DOTableSection *formSection = (DOTableSection*)[_sections objectAtIndex:section];
    
    if (formSection.footerViewBlock)
        return formSection.footerViewBlock(formSection.footer);
    else
        return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DOTableSection *formSection = (DOTableSection*)[_sections objectAtIndex:section];
    
    if (formSection.headerViewBlock)
        return formSection.headerViewBlock(formSection.title);
    else
        return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    DOTableSection *formSection = (DOTableSection*)[_sections objectAtIndex:section];
    
    if (formSection.footerViewBlock)
        return formSection.footerViewBlock(formSection.footer).frame.size.height;
    else
        return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    DOTableSection *formSection = (DOTableSection*)[_sections objectAtIndex:section];
    
    if (formSection.headerViewBlock)
        return formSection.headerViewBlock(formSection.title).frame.size.height;
    else
        return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DOTableElement *formElement = [self elementForIndexPath:indexPath];
    
    CGFloat height = ((DOTableElementCell*)[formElement cellForTableView:self.tableView]).height;
    return height?:44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DOTableElement *formElement = [self elementForIndexPath:indexPath];
    
    if(formElement.enabled && formElement.actionBlock)
    {
        formElement.actionBlock(formElement);
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
