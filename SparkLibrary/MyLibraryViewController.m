//
//  MyLibraryViewController.m
//  SparkLibrary
//
//  Created by Mohamed Hegab on 8/29/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "MyLibraryViewController.h"
#import "RootViewController.h"
#import "CellMyLibraryViewController.h"
#import "MyLibraryViewController.h"
#import "Transition.h"

@implementation MyLibraryViewController

@synthesize categories;
@synthesize pdfViewController;

NSMutableDictionary* plistDict;




- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
/*    self.navigationController.navigationBarHidden = FALSE;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 920.0, 44.0)];
    //here for v, width= navBar width and height=navBar height
    
    [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navBarTop.png"]]];
    [self.navigationController.navigationBar addSubview:view];
    [view release];
*/     
    [self checkAndCreatePList];
    
    plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pListPath];
    
    self.categories = [plistDict objectForKey:@"myBooks"];
    
    
    
    //navigationbar items
 
     
    
    
    [super viewDidLoad];
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    UIButton * leftButtonItem = [[UIButton buttonWithType:UIButtonTypeInfoLight] retain];
	leftButtonItem.frame = CGRectMake(0.0, 0.0, 52.5, 30.0);
	leftButtonItem.backgroundColor = [UIColor clearColor];
    [leftButtonItem setImage: [UIImage imageNamed:@"backBarButton.png"] forState:UIControlStateNormal];
	[leftButtonItem addTarget:self action:@selector(goBackToRootViewController) forControlEvents:UIControlEventTouchUpInside];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)getList{
    
    NSString* docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* filePath = [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"test.csv"]];
    
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

-(void) goBackToRootViewController {
    UIViewController *viewController;
    
    viewController = [[[RootViewController alloc] init] autorelease] ;

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
    

    [self.navigationController popViewControllerAnimated:YES];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.categories count] == 0 ){
        	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return 8;
            }else{
              return 4;
            }
        
    }
    return [self.categories count];
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    int row = indexPath.row;
    NSInteger sectionRows = [tableView numberOfRowsInSection:[indexPath section]];
    CellMyLibraryViewController *cell = ((CellMyLibraryViewController *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier]);
    
    UIColor *emptyColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"middleRow.png"]];
    tableView.backgroundColor = emptyColor;

    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CellMyLibraryViewController" owner:self options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (CellMyLibraryViewController *) currentObject;
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
    
    
    //    cell.textLabel.text = [[categories objectAtIndex:row]objectForKey:@"name"];
    cell.nameLabel.text = [[categories objectAtIndex:row]objectForKey:@"name"];
     cell.noOfPages.text =[[categories objectAtIndex:row]objectForKey:@"noOfPages"];     
    if([self.categories count] == 0 ){
        cell.pagesText.hidden = TRUE;
    }
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
    
    
    NSString *imagePath = [documentDir stringByAppendingPathComponent:[[categories objectAtIndex:row]objectForKey:@"imageName"]];
    NSLog(@"%@",imagePath);
    cell.bookCover.image = [UIImage imageWithContentsOfFile:imagePath];
  
    // Configure the cell.
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    NSString *fileName = [[categories objectAtIndex:row]objectForKey:@"fileName"];
    [self showDocumentWithName:fileName];
}

#define SAMPLE_DOCUMENT @"Document.pdf"
#define DEMO_VIEW_CONTROLLER_PUSH FALSE

- (void) showDocumentWithName:(NSString *)fileName {
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif
    
	ReaderDocument *document = [ReaderDocument unarchiveFromFileName:SAMPLE_DOCUMENT];
    
	if (document == nil) // Create a brand new ReaderDocument object the first time we run
	{
        NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
        NSString *documentsDirectoryPath = [searchPaths objectAtIndex:0]; 
        NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:[[NSString stringWithFormat:@"%@",fileName] stringByAppendingPathExtension:@"pdf"]];
        
        
        NSLog(@"%@",path);
        [self checkAndCreatePList];
        NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pListPath];
        
        [plistDict setValue: [NSString stringWithFormat:@"%@",fileName]  forKey:@"fileName"];
        [plistDict writeToFile:pListPath atomically: YES];
        
        
        
        //		NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
        
		document = [[[ReaderDocument alloc] initWithFilePath:path password:nil] autorelease];
	}
    
	if (document != nil) // Must have a valid ReaderDocument object in order to proceed
	{
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
		readerViewController.delegate = self; // Set the ReaderViewController delegate to self
        
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
        
		[self.navigationController pushViewController:readerViewController animated:YES];
        
#else // present in a modal view controller
        
		readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        readerViewController.myLibraryViewController = self;
		[self presentModalViewController:readerViewController animated:YES];
        
#endif // DEMO_VIEW_CONTROLLER_PUSH
        
		[readerViewController release]; // Release the ReaderViewController
	}
}

- (void) dismissReaderViewController:(ReaderViewController *)viewController andShowDocumentWithName:(NSString *)fileName {
    [self performSelector:@selector(dismissReaderViewController:) withObject:viewController];
    [self performSelector:@selector(showDocumentWithName:) withObject:fileName afterDelay:0.5];
    [self dismissReaderViewController:viewController];
    [self showDocumentWithName:fileName];
}

#pragma mark ReaderViewControllerDelegate methods

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif
    
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    
	[self.navigationController popViewControllerAnimated:YES];
    
#else // dismiss the modal view controller
    
	[self dismissModalViewControllerAnimated:YES];
    
#endif // DEMO_VIEW_CONTROLLER_PUSH
}




@end
