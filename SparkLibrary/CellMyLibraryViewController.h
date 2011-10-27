//
//  CellMyLibraryViewController.h
//  SparkLibrary
//
//  Created by Mohamed Hegab on 8/29/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellMyLibraryViewController : UITableViewCell
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *noOfPages;
    IBOutlet UILabel *authorName;
    IBOutlet UILabel *authorText;
    IBOutlet UIImageView *bookCover;
    IBOutlet UILabel *pagesText;
}

@property (nonatomic,retain) UILabel *authorName;
@property (nonatomic,retain) UILabel *authorText;
@property (nonatomic,retain) UILabel * nameLabel;
@property (nonatomic,retain) UILabel *noOfPages;
@property (nonatomic,retain) UIImageView *bookCover;
@property (nonatomic,retain) UILabel *pagesText;

@end