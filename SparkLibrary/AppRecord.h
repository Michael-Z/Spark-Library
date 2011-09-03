 
@interface AppRecord : NSObject
{
    NSString *bookName;
    UIImage *bookIcon;
    NSString *author;
    NSString *imageURLString;

}

@property (nonatomic, retain) NSString *bookName;
@property (nonatomic, retain) UIImage *bookIcon;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *imageURLString;


@end