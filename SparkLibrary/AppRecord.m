

#import "AppRecord.h"

@implementation AppRecord

@synthesize bookName;
@synthesize bookIcon;
@synthesize imageURLString;
@synthesize author;


- (void)dealloc
{
    [bookName release];
    [bookIcon release];
     [imageURLString release];
     [author release];
    
    [super dealloc];
}

@end

