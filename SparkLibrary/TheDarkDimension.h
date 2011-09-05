//
//  TheDarkDimension.h
//  SparkLibrary
//
//  Created by Mohamed Hegab on 9/5/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheDarkDimension : UIViewController
{
    IBOutlet UIWebView * webView;
}
@property(nonatomic,retain) UIWebView * webView;
-(IBAction)backToParent:(id)sender;
@end
