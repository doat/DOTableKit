//
//  DOTableTextViewElementCell.h
//  DOTableKit
//
//  Created by Hezi Cohen on 5/14/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableKit.h"

@interface DOTableTextViewElementCell : DOTableElementCell <UITextViewDelegate, UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *superviewTaps;
    UITextView *_textView;
}

@property (nonatomic, readonly) UITextView *textView;

@end
