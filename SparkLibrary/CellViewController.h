//
//  CellViewController.h
//  SparkLibrary
//
//  Created by Mohamed Hegab on 8/27/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellViewController : UITableViewCell
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *priceLabel;
    IBOutlet UILabel *noOfPages;
    IBOutlet UILabel *authorName;
    IBOutlet UILabel *dollarSign;
    IBOutlet UIImageView *bookCover;
    IBOutlet UILabel *pagesText;
    IBOutlet UILabel *priceText;
    IBOutlet UIButton * descButton;
    IBOutlet UIButton * buyButton;
    
}
@property (nonatomic,retain) UIButton * descButton;
@property (nonatomic,retain) UILabel *authorName;
@property (nonatomic,retain) UILabel *dollarSign;
@property (nonatomic,retain) UIButton * buyButton;
@property (nonatomic,retain) UILabel * nameLabel;
@property (nonatomic,retain) UILabel * priceLabel;
@property (nonatomic,retain) UILabel *noOfPages;
@property (nonatomic,retain) UIImageView *bookCover;
@property (nonatomic,retain) UILabel *pagesText;
@property (nonatomic,retain) UILabel *priceText;

@end
