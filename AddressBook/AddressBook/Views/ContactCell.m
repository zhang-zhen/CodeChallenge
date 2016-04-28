//
//  ContactCell.m
//  AddressBook
//
//  Created by Zhen Zhang on 2016-04-27.
//  Copyright © 2016 Zhang Zhen. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    [[self.headImageView layer] setBorderColor:[UIColor grayColor].CGColor];
    [[self.headImageView layer] setBorderWidth:1.0f];
}

@end
