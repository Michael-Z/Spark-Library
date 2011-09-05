//
//  OurProducts.h
//  SparkLibrary
//
//  Created by Mohamed Hegab on 9/6/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OurProducts : UIViewController
{
int goTo;
NSString *pListPath;
NSArray *chapters;
NSArray *links;

}
@property (nonatomic, retain) NSArray *chapters;
@property (nonatomic, retain) NSArray *links;
@property (readwrite, nonatomic) int goTo;
-(void)checkAndCreatePList;
-(IBAction)backToParent:(id)sender;
@end
