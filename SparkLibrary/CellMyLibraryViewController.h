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
    IBOutlet UIImageView *bookCover;
    IBOutlet UIImageView *pagesText;
}
@property (nonatomic,retain) UILabel * nameLabel;
@property (nonatomic,retain) UILabel *noOfPages;
@property (nonatomic,retain) UIImageView *bookCover;
@property (nonatomic,retain) UIImageView *pagesText;

@end