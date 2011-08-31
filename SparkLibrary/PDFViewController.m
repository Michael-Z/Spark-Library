    //
//  PDFViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/19/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "PDFViewController.h"
#import "Utilities.h"
#import "SparkLibraryAppDelegate.h"
 
@implementation PDFViewController 
 
@synthesize documentLayout, pageNo,backButton,fileName;

- (id)init {
       if (self = [super init]) {
        
         
	CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("fekhElSunaI.pdf"), NULL, NULL);

		pdf = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
      }
     
    
   /*
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectoryPath = [searchPaths objectAtIndex:0]; 
	NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:[@"dark.matter" stringByAppendingPathExtension:@"pdf"]];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the file exists
	if ([fileManager fileExistsAtPath:path])
	{
		//Display PDF
		CFURLRef pdfURL = CFURLCreateWithFileSystemPath (NULL, (CFStringRef)path, kCFURLPOSIXPathStyle, FALSE);
		pdf = CGPDFDocumentCreateWithURL(pdfURL);
		leavesView.backgroundRendering = NO;
		CFRelease(pdfURL);
		[leavesView reloadData];
        
	}
    */
    
    
    return self;
} 

- (void)dealloc {
	CGPDFDocumentRelease(pdf);
  
   
    [super dealloc];
}

- (void) displayPageNumber:(NSUInteger)pageNumber {

    pageNo.text =[NSString stringWithFormat:
                  						 @"الصفحة %u من %u", 
                  								 pageNumber, 
                								 CGPDFDocumentGetNumberOfPages(pdf)];

}

#pragma mark  LeavesViewDelegate methods

- (void) leavesView:(LeavesView *)leavesView willTurnToPageAtIndex:(NSUInteger)pageIndex {
	[self displayPageNumber:CGPDFDocumentGetNumberOfPages(pdf)-pageIndex ];
}

#pragma mark LeavesViewDataSource methods

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return CGPDFDocumentGetNumberOfPages(pdf);
}

 

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
	CGPDFPageRef page = CGPDFDocumentGetPage(pdf, CGPDFDocumentGetNumberOfPages(pdf)-index); //hegab
	CGAffineTransform transform = aspectFit(CGPDFPageGetBoxRect(page, kCGPDFMediaBox),
											CGContextGetClipBoundingBox(ctx));
	CGContextConcatCTM(ctx, transform);
	CGContextDrawPDFPage(ctx, page);
}

#pragma mark UIViewController
-(void) viewWillAppear:(BOOL)animated{
   /* NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    pListPath = [ documentDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",self.fileName]];

    
    CFURLRef pdfURL = (CFURLRef)[NSURL fileURLWithPath:pListPath];    
    
 
    //	CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("fekhElSunaI.pdf"), NULL, NULL);
    
    pdf = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
   
    
//    CFRelease(pdfURL);
    
   [super init];
    */
}



-(void) backToLibrary{
    [[self parentViewController] dismissModalViewControllerAnimated:YES];    
}
- (void) viewDidLoad {

   [super viewDidLoad];
 	leavesView.backgroundRendering = YES;
    leavesView.multipleTouchEnabled=YES;
    pageNo = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 300, 20  )];
    pageNo.backgroundColor=[UIColor clearColor];
    [ self.view addSubview:pageNo];    

    
     backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self 
               action:@selector(backToLibrary)
     forControlEvents:UIControlEventTouchDown];
    
    UIImage *buttonImageNormal = [UIImage imageNamed:@"page.png"];
    
    UIImage *strechableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    [backButton setBackgroundImage:strechableButtonImageNormal forState:UIControlStateNormal];

    backButton.frame = CGRectMake(20.0, 0.0, 73.0, 29.0);

    
    [self.view addSubview:backButton];
	[self displayPageNumber:1];
	[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(hide) userInfo:nil repeats:NO]; 
}

-(void)hide{
         self.navigationController.navigationBarHidden=TRUE;
}

@end
