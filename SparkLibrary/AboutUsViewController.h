//
//  AboutUsViewController.h
//  SparkLibrary
//
//  Created by Mohamed Hegab on 9/4/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsViewController : UIViewController
{
    IBOutlet UITextView * aboutusTextView;
}

@property(nonatomic,retain) UITextView * aboutusTextView;

@end
