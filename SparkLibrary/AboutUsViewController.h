//
//  AboutUsViewController.h
//  SparkLibrary
//
//  Created by Mohamed Hegab on 9/4/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h> 
#import <MessageUI/MessageUI.h>


@interface AboutUsViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
    IBOutlet UIWebView * aboutusWebView;
}

@property(nonatomic,retain) UIWebView * aboutusWebView;
-(IBAction)sendMail:(id)sender;

@end
