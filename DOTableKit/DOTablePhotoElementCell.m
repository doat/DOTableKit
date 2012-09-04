//
//  DOTablePhotoPickerElementCell.m
//  DOTableKit
//
//  Created by Hezi Cohen on 6/3/12.
//  Copyright (c) 2012 DoAT Media Ltd.. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DOTablePhotoElementCell.h"

@implementation DOTablePhotoElementCell
@synthesize thumbnailView = _thumbnailView;

- (id)initWithElement:(DOTablePhotoElement*)element tableViewCellStyle:(UITableViewCellStyle)style
{
    self = [super initWithElement:element tableViewCellStyle:style];
    if (self) 
    {
        [self setupCell];
    }
    return self;
}

- (id)initWithElement:(DOTablePhotoElement*)element
{
    self = [super initWithElement:element];
    if (self) 
    {
        [self setupCell];
    }
    return self;
}

- (void)setupCell
{
    _thumbnailView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
    _thumbnailView.image = ((DOTablePhotoElement*)self.element).thumbnail;
    _thumbnailView.layer.anchorPoint = CGPointMake(1.0f, 0.0f);
    _thumbnailView.contentMode = UIViewContentModeScaleAspectFit;
        
    [self.contentView insertSubview:_thumbnailView aboveSubview:self.textLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _thumbnailView.center = CGPointMake(self.contentView.frame.size.width-10, 10);
}

@end
