//
//  FontView.h
//  SparkLibrary
//
//  Created by Mohamed Hegab on 8/29/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

/*@protocol ReaderMainToolbarDelegate <NSObject>

@required // Delegate protocols

- (void)tappedInToolbar:(ReaderMainToolbar *)toolbar pdf2Button:(UIBarButtonItem *)button;
 
@end
*/
@interface FontView : UIViewController
{
    NSString *pListPath;
}
-(IBAction)getPDF2:(id)sender;
-(void)checkAndCreatePList;
@end

