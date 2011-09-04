//
//  RootViewController.m
//  SparkLibrary
//
//  Created by Mohamed  Hegab on 8/19/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "RootViewController.h"
#import "SplashViewController.h"
#import "CellViewController.h"
#import "Transition.h"
#import "MyLibraryViewController.h"
#import "ZipArchive.h"
#import "DescriptionViewController.h"
#import "AboutUsViewController.h"


@implementation RootViewController
@synthesize categories;
@synthesize pdfViewController;
@synthesize readerController;
NSMutableDictionary* plistDict;
NSMutableData * downloadedFile;
int downloadCount =0;
NSString * fileName ; 
NSString * secondFileName ;
float expectedContentLength;
int currentRow;



-(void)removeImage{
    [[self parentViewController] dismissModalViewControllerAnimated:YES];    
}

- (void)viewDidLoad
{
    SplashViewController *splash = [[SplashViewController alloc]
                                    initWithNibName:@"SplashViewController" bundle:[NSBundle mainBundle]];
    
 	[self.navigationController presentModalViewController:splash animated:NO ];
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(removeImage) userInfo:nil repeats:NO];
    
    [splash release]; 
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent]; 
     UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 920.0, 44.0)];
    //here for v, width= navBar width and height=navBar height
    
    [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navBarTop.png"]]];
    [self.navigationController.navigationBar addSubview:view];
    [view release];
    [self getList];
    
    [self checkAndCreatePList];
 
    plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pListPath];
    
    self.categories = [plistDict objectForKey:@"Categories"];
    

    
    
    [super viewDidLoad];
}

-(void)getList{
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
    NSURL* pListURL = [NSURL URLWithString: [NSString stringWithFormat:@"http://php.thedarkdimension.com/sparkLib/books.csv"]];
    NSData* pListData = [NSData dataWithContentsOfURL: pListURL];
    NSString* downloadedFilePath = [documentDir stringByAppendingPathComponent:@"books.csv"];
    [pListData writeToFile: downloadedFilePath atomically: NO];

    
    
    NSString* docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* filePath = [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"books.csv"]];

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
                [booksList setValue:[NSString stringWithFormat:@"%@", inAppKey]  forKey:@"inAppKey"];
                [booksList setValue:[NSString stringWithFormat:@"%@", fileName]  forKey:@"fileName"];
                [booksList setValue:[NSString stringWithFormat:@"%@", noOfPages]  forKey:@"noOfPages"];
            [AllBooksList addObject:booksList];
  
        [plistDict setValue:AllBooksList forKey:@"Categories"];
        
    
        [plistDict writeToFile:pListPath atomically: YES];

        [data release];

        booksList = nil;
        row=nil;
    }
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
-(IBAction)myLibraryPage:(id)sender{
    UIViewController *viewController;

			 viewController = [[MyLibraryViewController alloc] init] ;
        NSObject<EPGLTransitionViewDelegate> *transition;
    	transition = [[[Transition alloc] init] autorelease];
    
    
    EPGLTransitionView *glview = [[[EPGLTransitionView alloc] 
                                   initWithView:self.navigationController.view
                                   delegate:transition] autorelease];
    
 
        [glview prepareTextureTo:viewController.view];
		// If you are using an "IN" animation for the "next" view set appropriate 
		// clear color (ie no alpha) 
		[glview setClearColorRed:0.0
						   green:0.0
							blue:0.0
						   alpha:1.0];
    
    [glview startTransition];
    


    	[self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction)aboutUsPage:(id)sender{
    UIViewController *viewController;
    
    viewController = [[AboutUsViewController alloc] init] ;
    NSObject<EPGLTransitionViewDelegate> *transition;
    transition = [[[Transition alloc] init] autorelease];
    
    
    EPGLTransitionView *glview = [[[EPGLTransitionView alloc] 
                                   initWithView:self.navigationController.view
                                   delegate:transition] autorelease];
    
    
    [glview prepareTextureTo:viewController.view];
    // If you are using an "IN" animation for the "next" view set appropriate 
    // clear color (ie no alpha) 
    [glview setClearColorRed:0.0
                       green:0.0
                        blue:0.0
                       alpha:1.0];
    
    [glview startTransition];
    
    
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    //navigationbar items
    UIButton * rightButtonItem = [[UIButton buttonWithType:UIButtonTypeInfoLight] retain];
	rightButtonItem.frame = CGRectMake(0.0, 0.0, 84.0, 30.0);
	rightButtonItem.backgroundColor = [UIColor clearColor];
    [rightButtonItem setImage: [UIImage imageNamed:@"libraryButton.png"] forState:UIControlStateNormal];
	[rightButtonItem addTarget:self action:@selector(myLibraryPage:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:rightButtonItem];
	self.navigationItem.rightBarButtonItem = rightButton;
	[rightButtonItem release];
	[rightButton release];
    
    
    UIButton * leftButtonItem = [[UIButton buttonWithType:UIButtonTypeInfoLight] retain];
	leftButtonItem.frame = CGRectMake(0.0, 0.0, 52.5, 30.0);
	leftButtonItem.backgroundColor = [UIColor clearColor];
    [leftButtonItem setImage: [UIImage imageNamed:@"aboutUsButton.png"] forState:UIControlStateNormal];
	[leftButtonItem addTarget:self action:@selector(aboutUsPage:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftButtonItem];
	self.navigationItem.leftBarButtonItem = leftButton;
	[leftButtonItem release];
	[leftButton release];
    

    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([self.categories count] == 0 ){
        return 8;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categories count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success;
    int row = indexPath.row;
    NSInteger sectionRows = [tableView numberOfRowsInSection:[indexPath section]];
    CellViewController *cell = ((CellViewController *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier]);
    
    UIColor *emptyColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"middleRow.png"]];
    tableView.backgroundColor = emptyColor;
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CellViewController" owner:self options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (CellViewController *) currentObject;
                break;
            }
        }
    }
    //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
	UIImage *bg;
	UIImage *selectionBg;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.frame];
    UIImageView *selectedImageView = [[UIImageView alloc] initWithFrame:cell.frame];
    if (row == 0 && row == sectionRows - 1)
	{
		bg = [UIImage imageNamed:@"topAndBottomRow.png"];
        selectionBg = [UIImage imageNamed:@"topAndBottomRow.png"];
	}
	else if (row == 0)
	{
		bg = [UIImage imageNamed:@"topRow.png"];
		selectionBg = [UIImage imageNamed:@"selectedTopRow.png"];        
	}
	else if (row == sectionRows - 1)
	{
		bg = [UIImage imageNamed:@"bottomRow.png"];
		selectionBg = [UIImage imageNamed:@"selectedButtomRow.png"];        
	}
	else
	{
		bg = [UIImage imageNamed:@"middleRow.png"];
		selectionBg = [UIImage imageNamed:@"selectedMiddleRow.png"];        
	}
 
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    tableView.backgroundColor = color;

    
    imageView.image = bg ;
    selectedImageView.image = selectionBg;
    
    
    cell.backgroundView = imageView;
    cell.selectedBackgroundView = selectedImageView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
    
//    cell.textLabel.text = [[categories objectAtIndex:row]objectForKey:@"name"];
    cell.nameLabel.text = [[categories objectAtIndex:row]objectForKey:@"name"];
    cell.priceLabel.text =[[categories objectAtIndex:row]objectForKey:@"price"]; 
    cell.noOfPages.text =[[categories objectAtIndex:row]objectForKey:@"noOfPages"];     
    
    NSString* filePath = [documentDir stringByAppendingPathComponent:[[categories objectAtIndex:row]objectForKey:@"imageName"]];
    
    success = [fileManager fileExistsAtPath:filePath];
    if(!success){
    NSURL* pListURL = [NSURL URLWithString: [NSString stringWithFormat:@"http://php.thedarkdimension.com/sparkLib/%@",[[categories objectAtIndex:row]objectForKey:@"imageName"]]];
    NSData* pListData = [NSData dataWithContentsOfURL: pListURL];
    [pListData writeToFile: filePath atomically: NO];
    }
    NSString *imagePath = [documentDir stringByAppendingPathComponent:[[categories objectAtIndex:row]objectForKey:@"imageName"]];
    NSLog(@"%@",imagePath);
    cell.bookCover.image = [UIImage imageWithContentsOfFile:imagePath];
    // Configure the cell.
    
    
    
 /*   UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
    button.frame = CGRectMake(20,50,30,30);
   // [button setImage:[UIImage imageNamed:@"Reader-Email.png"] forState:UIControlStateNormal];

    button.tag = row;
    [button addTarget:self action:@selector(description:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    [cell addSubview: button];
    */
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(IBAction)description:(id)sender{
    UIButton *button = (UIButton*) sender;
    NSLog(@"%@",[[categories objectAtIndex:button.tag]objectForKey:@"description"]);
    CGSize viewSize = self.view.bounds.size;
    DescriptionViewController *descView = [[DescriptionViewController alloc] initWithNibName:@"DescriptionViewController" bundle:nil];
    CGRect viewFrame = descView.view.frame;
    CGRect frame = [[UIScreen mainScreen] bounds];
    viewFrame.size.height=frame.size.height;
    viewFrame.size.width=frame.size.width;
    
    descView.view.frame =viewFrame;
    
    descView.view.center = CGPointMake(viewSize.width/2.0f , viewSize.height /2.0f);
    [self.view addSubview:[descView view]]; 
    descView.descTextView.text = [[categories objectAtIndex:button.tag]objectForKey:@"description"];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
 
    fileName = [[categories objectAtIndex:row]objectForKey:@"fileName"]; 
    secondFileName = [NSString stringWithFormat:@"%@_2",fileName];
    
     NSString * urlString = [NSString stringWithFormat:@"http://php.thedarkdimension.com/sparkLib/%@.zip",fileName];

    NSLog(@"%@",urlString);
        
        NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0 ];

 
        [[NSURLConnection alloc] initWithRequest:request1 delegate:self] ;
        HUD = [[MBProgressHUD showHUDAddedTo:self.view animated:YES] retain];
        currentRow = row;
    
    
    /*
    readerController = [[[ReaderController alloc] init] autorelease];
 //   pdfViewController = [[[PDFViewController alloc] init] autorelease]; 
    NSObject<EPGLTransitionViewDelegate> *transition;
    transition = [[[Transition alloc] init] autorelease];
    
    
    EPGLTransitionView *glview = [[[EPGLTransitionView alloc] 
                                   initWithView:self.view
                                   delegate:transition] autorelease];
    
    
    [glview prepareTextureTo:readerController.view];
    // If you are using an "IN" animation for the "next" view set appropriate 
    // clear color (ie no alpha) 
    [glview setClearColorRed:0.0
                       green:0.0
                        blue:0.0
                       alpha:1.0];
    
    [glview startTransition];

    readerController.fileName=[[categories objectAtIndex:row]objectForKey:@"fileName"]; 
    [self.navigationController presentModalViewController: readerController animated:YES];
     */
   

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
    [categories release];
   // [pdfViewController release];
    //[readerController release];

}






- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    expectedContentLength = [response expectedContentLength];
    downloadedFile = [[NSMutableData data] retain];
    HUD.mode = MBProgressHUDModeDeterminate;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    
    float soundFileContentLength = [downloadedFile length];
    float value = soundFileContentLength / expectedContentLength;
    HUD.progress = value;
    int valuePercent = value/1*100;
    NSLog(@"%d",valuePercent);
    HUD.labelText = [NSString stringWithFormat:@"%d %% Please Wait",valuePercent];
    [downloadedFile appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection

{
 
        NSString* docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        downloadCount ++;
    NSString* filePath;
    
 
        filePath = [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip",fileName]];
  
    
        NSLog(@"%@",filePath);
        [downloadedFile writeToFile:filePath atomically:YES];
    
    
 //   progressBar.hidden= TRUE;
 //   percentage.hidden=TRUE;
 //   percentageSign.hidden=TRUE;
 //   waitLabel.hidden = TRUE;
    
    // receivedData is declared as a method instance elsewhere
    NSLog(@"finish loading");
   // [FlurryAPI logEvent:@"finish downloading"];	
    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]] autorelease];
    HUD.mode = MBProgressHUDModeCustomView;
	[HUD hide:YES afterDelay:2];
    // release the connection, and the data object
   // [[self parentViewController] dismissModalViewControllerAnimated:YES];   
    
    
    ZipArchive* za = [[ZipArchive alloc] init];
	if( [za UnzipOpenFile:filePath] )
	{
        [za UnzipFileTo:docsDir overWrite:YES];
		[za UnzipCloseFile];
	}
	[za release];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:NULL];
    
    [connection release];
    
    [downloadedFile release];
//downloading =FALSE;
    
    [self checkAndCreatePList];
    plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pListPath];
    
    NSMutableArray *myBooks = [plistDict valueForKey:@"myBooks"];
    if (!myBooks) {
        myBooks = [[NSMutableArray alloc]init];
    }
    [myBooks addObject:[categories objectAtIndex:currentRow]];
    [plistDict setValue:myBooks forKey:@"myBooks"];
    [plistDict writeToFile:pListPath atomically: YES];
    [myBooks release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[HUD hide:YES];
	[connection release];

 }


@end
