//
//  SparkLibraryAppDelegate.m
//  SparkLibrary
//
//  Created by Mohamed  Hegab on 8/19/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "SparkLibraryAppDelegate.h"
#import "MKStoreManager.h"

@implementation SparkLibraryAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
NSMutableDictionary* plistDict;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self getList];
    [[UIApplication sharedApplication]
     registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                         UIRemoteNotificationTypeSound |
                                         UIRemoteNotificationTypeAlert)];
    
    application.applicationIconBadgeNumber = 0;
    
     // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}




/* 
 * --------------------------------------------------------------------------------------------------------------
 *  BEGIN APNS CODE 
 * --------------------------------------------------------------------------------------------------------------
 */

/**
 * Fetch and Format Device Token and Register Important Information to Remote Server
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
	
#if !TARGET_IPHONE_SIMULATOR
    
	// Get Bundle Info for Remote Registration (handy if you have more than one app)
	NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
	NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	
	// Check what Notifications the user has turned on.  We registered for all three, but they may have manually disabled some or all of them.
	NSUInteger rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
	
	// Set the defaults to disabled unless we find otherwise...
	NSString *pushBadge = (rntypes & UIRemoteNotificationTypeBadge) ? @"enabled" : @"disabled";
	NSString *pushAlert = (rntypes & UIRemoteNotificationTypeAlert) ? @"enabled" : @"disabled";
	NSString *pushSound = (rntypes & UIRemoteNotificationTypeSound) ? @"enabled" : @"disabled";	
	
	// Get the users Device Model, Display Name, Unique ID, Token & Version Number
	UIDevice *dev = [UIDevice currentDevice];
	NSString *deviceUuid;
	if ([dev respondsToSelector:@selector(uniqueIdentifier)])
		deviceUuid = dev.uniqueIdentifier;
	else {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		id uuid = [defaults objectForKey:@"deviceUuid"];
		if (uuid)
			deviceUuid = (NSString *)uuid;
		else {
			CFStringRef cfUuid = CFUUIDCreateString(NULL, CFUUIDCreate(NULL));
			deviceUuid = (NSString *)cfUuid;
			CFRelease(cfUuid);
			[defaults setObject:deviceUuid forKey:@"deviceUuid"];
		}
	}
	NSString *deviceName = [dev.name stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
	NSString *deviceModel = [dev.model stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
	NSString *deviceSystemVersion = dev.systemVersion;
	
	// Prepare the Device Token for Registration (remove spaces and < >)
	NSString *deviceToken = [[[[devToken description] 
                               stringByReplacingOccurrencesOfString:@"<"withString:@""] 
                              stringByReplacingOccurrencesOfString:@">" withString:@""] 
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
	
	// Build URL String for Registration
	// !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
	// !!! SAMPLE: "secure.awesomeapp.com"
	NSString *host = @"php.spark-books.com";
	
	// !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED 
	// !!! ( MUST START WITH / AND END WITH ? ). 
	// !!! SAMPLE: "/path/to/apns.php?"
	NSString *urlString = [NSString stringWithFormat:@"/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, deviceToken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
	
	// Register the Device Data
	// !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
	NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//	NSLog(@"Register URL: %@", url);
//	NSLog(@"Return Data: %@", returnData);
	
#endif
}

/**
 * Failed to Register for Remote Notifications
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	
#if !TARGET_IPHONE_SIMULATOR
	
	NSLog(@"Error in registration. Error: %@", error);
	
#endif
}

/**
 * Remote Notification Received while application was open.
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	
#if !TARGET_IPHONE_SIMULATOR
    
	NSLog(@"remote notification: %@",[userInfo description]);
	NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
	
	NSString *alert = [apsInfo objectForKey:@"alert"];
	NSLog(@"Received Push Alert: %@", alert);
	
 	
	NSString *badge = [apsInfo objectForKey:@"badge"];
	NSLog(@"Received Push Badge: %@", badge);
	application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
	
#endif
}

/* 
 * --------------------------------------------------------------------------------------------------------------
 *  END APNS CODE 
 * --------------------------------------------------------------------------------------------------------------
 */





- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}
-(void)getList{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
    NSURL* pListURL = [NSURL URLWithString: [NSString stringWithFormat:@"http://php.spark-books.com/sparkLib/books.csv"]];
    NSData* pListData = [NSData dataWithContentsOfURL: pListURL];
    NSString* downloadedFilePath = [documentDir stringByAppendingPathComponent:@"books.csv"];
    [pListData writeToFile: downloadedFilePath atomically: NO];
    
    
    NSString* filePath = [documentDir stringByAppendingPathComponent:[NSString stringWithFormat:@"books.csv"]];
    
  	NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:filePath];
    if (success) {
        
    }
	NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
	NSMutableArray *rows = [[NSArray alloc] initWithArray:[fileContents componentsSeparatedByString:@"\n"]];
    
    NSMutableArray * AllBooksList = [[NSMutableArray alloc]init];        
    for(int i=0 ; i < rows.count-1 ; i++){
        NSString * row = [rows objectAtIndex:i];
        
        NSArray * data = [[NSArray alloc] initWithArray:[row componentsSeparatedByString:@","]];
        
        
        [self checkAndCreatePList];
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pListPath];
        //read plist
        
        
        
        NSMutableDictionary * booksList = [NSMutableDictionary dictionary];        
        NSString * name = [[data objectAtIndex:0] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString * author = [[data objectAtIndex:1] stringByReplacingOccurrencesOfString:@"\"" withString:@""];        
        NSString * price = [[data objectAtIndex:2] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString * description = [[data objectAtIndex:3] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString * imageName = [[data objectAtIndex:4] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString * inAppKey = [[data objectAtIndex:5] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString * fileName = [[data objectAtIndex:6] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSString * noOfPages = [[data objectAtIndex:7] stringByReplacingOccurrencesOfString:@"\"" withString:@""];  
        [booksList setValue:[NSString stringWithFormat:@"%@", name]  forKey:@"name"];
        [booksList setValue:[NSString stringWithFormat:@"%@", author]  forKey:@"author"];
        [booksList setValue:[NSString stringWithFormat:@"%@", price]  forKey:@"price"];
        [booksList setValue:[NSString stringWithFormat:@"%@", description]  forKey:@"description"];
        [booksList setValue:[NSString stringWithFormat:@"%@", imageName]  forKey:@"imageName"];
        [booksList setValue:[NSString stringWithFormat:@"%@", inAppKey] forKey: @"inAppKey"];
        [booksList setValue:[NSString stringWithFormat:@"%@", fileName]  forKey:@"fileName"];
        [booksList setValue:[NSString stringWithFormat:@"%@", noOfPages]  forKey:@"noOfPages"];
        
        [AllBooksList addObject:booksList];
        
        [plistDict setValue:AllBooksList forKey:@"Categories"];
        
        
        
        
        [plistDict writeToFile:pListPath atomically: YES];
        
        [data release];
        
        booksList = nil;
        row=nil;
    }
    [MKStoreManager sharedManager];
}


-(void)checkAndCreatePList{
	BOOL success;
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
 	pListPath = [ documentDir stringByAppendingPathComponent:@"sparkLib.plist"];
  	NSFileManager *fileManager = [NSFileManager defaultManager];
	success = [fileManager fileExistsAtPath:pListPath];
	
	if(success) return;
	
	NSString *pListPathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"sparkLib.plist"];
	
	[fileManager copyItemAtPath:pListPathFromApp toPath:pListPath error:nil];
	
	[fileManager release];
}

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
