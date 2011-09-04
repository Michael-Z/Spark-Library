//
//  CellViewController.m
//  SparkLibrary
//
//  Created by Mohamed Hegab on 8/27/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "CellViewController.h"

@implementation CellViewController
@synthesize nameLabel,priceLabel,noOfPages,bookCover,pagesText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
