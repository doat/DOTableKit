//
//  DOTableTextEntryElementCell.h
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableKit.h"

@interface DOTableTextEntryElementCell : DOTableElementCell <UITextFieldDelegate>
{
    UITapGestureRecognizer *superviewTaps;
    UITextField *_textField;
    CGPoint originalContentOffset;
}

@property (nonatomic, readonly) UITextField *textField;

@end
