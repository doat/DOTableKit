//
//  DOTablePhotoPickerElement.m
//  DOTableKit
//
//  Created by Hezi Cohen on 6/3/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import "DOTableKit.h"

@implementation DOTablePhotoElement
@synthesize thumbnail = _thumbnail;

- (id)init
{
    self = [super init];
    if (self) 
    {
        self.enabled = YES;
        self.cellHeight = 60.0f;
    }
    return self;
}

@end