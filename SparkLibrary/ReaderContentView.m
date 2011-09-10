//
//	ReaderContentView.m
//	Reader v2.1.0
//
//	Created by Julius Oklamcak on 2011-07-01.
//	Copyright © 2011 Julius Oklamcak. All rights reserved.
//
//	This work is being made available under a Creative Commons Attribution license:
//		«http://creativecommons.org/licenses/by/3.0/»
//	You are free to use this work and any derivatives of this work in personal and/or
//	commercial products and projects as long as the above copyright is maintained and
//	the original author is attributed.
//

#import "ReaderConstants.h"
#import "ReaderContentView.h"
#import "ReaderContentPage.h"
#import "ReaderScrollView.h"

#import <QuartzCore/QuartzCore.h>

@implementation ReaderContentView

#pragma mark Constants

#define ZOOM_LEVELS 4
#define ZOOM_AMOUNT 0.5f

#if (READER_SHOW_SHADOW == TRUE) // Option
	#define CONTENT_INSET 4.0f
#else
	#define CONTENT_INSET 2.0f
#endif // end of READER_SHOW_SHADOW Option

#pragma mark Properties

@synthesize delegate;

#pragma mark ReaderContentView functions

static inline CGFloat ZoomScaleThatFits(CGSize target, CGSize source)
{
	CGFloat w_scale = (target.width / source.width);
	CGFloat h_scale = (target.height / source.height);

	return (w_scale < h_scale) ? w_scale : h_scale;
}

#pragma mark ReaderContentView instance methods

- (void)updateMinimumMaximumZoom
{
	CGRect targetRect = CGRectInset(theScrollView.bounds, CONTENT_INSET, CONTENT_INSET);

	CGFloat zoomScale = ZoomScaleThatFits(targetRect.size, theContentView.bounds.size);

	theScrollView.minimumZoomScale = zoomScale; // Set the minimum and maximum zoom scales

	theScrollView.maximumZoomScale = (zoomScale * ZOOM_LEVELS); // Number of zoom levels
}

- (id)initWithFrame:(CGRect)frame fileURL:(NSURL *)fileURL page:(NSUInteger)page password:(NSString *)phrase
{
 
	if ((self = [super initWithFrame:frame]))
	{
		self.autoresizesSubviews = YES;
		self.userInteractionEnabled = YES;
		self.contentMode = UIViewContentModeRedraw;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.backgroundColor = [UIColor clearColor];

		theScrollView = [[ReaderScrollView alloc] initWithFrame:self.bounds];

		theScrollView.scrollsToTop = NO;
		theScrollView.delaysContentTouches = NO;
		theScrollView.showsVerticalScrollIndicator = NO;
		theScrollView.showsHorizontalScrollIndicator = NO;
		theScrollView.contentMode = UIViewContentModeRedraw;
		theScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		theScrollView.backgroundColor = [UIColor clearColor];
		theScrollView.userInteractionEnabled = YES;
		theScrollView.autoresizesSubviews = NO;
		theScrollView.bouncesZoom = YES;
		theScrollView.delegate = self;

		theContentView = [[ReaderContentPage alloc] initWithURL:fileURL page:page password:phrase];

		if (theContentView != nil) // Must have a valid and initialized content view
		{
			theContainerView = [[UIView alloc] initWithFrame:theContentView.bounds];

			theContainerView.autoresizesSubviews = NO;
			theContainerView.userInteractionEnabled = NO;
			theContainerView.contentMode = UIViewContentModeRedraw;
			theContainerView.autoresizingMask = UIViewAutoresizingNone;
			theContainerView.backgroundColor = [UIColor whiteColor];

#if (READER_SHOW_SHADOW == TRUE) // Option

			theContainerView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
			theContainerView.layer.shadowRadius = 4.0f; theContainerView.layer.shadowOpacity = 1.0f;
			theContainerView.layer.shadowPath = [UIBezierPath bezierPathWithRect:theContainerView.bounds].CGPath;

#endif // end of READER_SHOW_SHADOW Option

			theScrollView.contentSize = theContentView.bounds.size; // Content size same as view size
			theScrollView.contentOffset = CGPointMake((0.0f - CONTENT_INSET), (0.0f - CONTENT_INSET));
			theScrollView.contentInset = UIEdgeInsetsMake(CONTENT_INSET, CONTENT_INSET, CONTENT_INSET, CONTENT_INSET);

			[theContainerView addSubview:theContentView]; // Add the content view to the container view

			[theScrollView addSubview:theContainerView]; // Add the container view to the scroll view

			[self updateMinimumMaximumZoom]; // Update the minimum and maximum zoom scales

			theScrollView.zoomScale = theScrollView.minimumZoomScale; // Zoom to fit
		}

		[self addSubview:theScrollView]; // Add the scroll view to the parent container view

		[theScrollView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];

		self.tag = page; // Tag the view with the page number
	}

	return self;
}

- (void)dealloc
{

	[theScrollView removeObserver:self forKeyPath:@"frame"];

	[theScrollView release], theScrollView = nil;

	[theContainerView release], theContainerView = nil;

	[theContentView release], theContentView = nil;

	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

	if ((object == theScrollView) && [keyPath isEqualToString:@"frame"])
	{
		CGFloat oldMinimumZoomScale = theScrollView.minimumZoomScale;

		[self updateMinimumMaximumZoom]; // Update the zoom scale limits

		if (theScrollView.zoomScale == oldMinimumZoomScale) // Old minimum
		{
			theScrollView.zoomScale = theScrollView.minimumZoomScale;
		}
		else // Check against minimum zoom scale
		{
			if (theScrollView.zoomScale < theScrollView.minimumZoomScale)
			{
				theScrollView.zoomScale = theScrollView.minimumZoomScale;
			}
			else // Check against maximum zoom scale
			{
				if (theScrollView.zoomScale > theScrollView.maximumZoomScale)
				{
					theScrollView.zoomScale = theScrollView.maximumZoomScale;
				}
			}
		}
	}
}

- (void)layoutSubviews
{

	CGRect viewFrame = theContainerView.frame;
	CGSize boundsSize = theScrollView.bounds.size;
	CGPoint contentOffset = theScrollView.contentOffset;

	if (viewFrame.size.width < boundsSize.width)
		viewFrame.origin.x = (((boundsSize.width - viewFrame.size.width) / 2.0f) + contentOffset.x);
	else
		viewFrame.origin.x = 0.0f;

	if (viewFrame.size.height < boundsSize.height)
		viewFrame.origin.y = (((boundsSize.height - viewFrame.size.height) / 2.0f) + contentOffset.y);
	else
		viewFrame.origin.y = 0.0f;

	theContainerView.frame = viewFrame;
}

- (id)singleTap:(UITapGestureRecognizer *)recognizer
{

	return [theContentView singleTap:recognizer];
}

- (void)zoomIncrement
{

	CGFloat zoomScale = theScrollView.zoomScale;

	if (zoomScale <= theScrollView.maximumZoomScale)
	{
		zoomScale += ZOOM_AMOUNT;

		if (zoomScale > theScrollView.maximumZoomScale)
		{
			zoomScale = theScrollView.minimumZoomScale;
		}
	}

	if (zoomScale != theScrollView.zoomScale) // Do zoom
	{
		[theScrollView setZoomScale:zoomScale animated:YES];
	}
}

- (void)zoomDecrement
{

	CGFloat zoomScale = theScrollView.zoomScale;

	if (zoomScale >= theScrollView.minimumZoomScale)
	{
		zoomScale -= ZOOM_AMOUNT;

		if (zoomScale < theScrollView.minimumZoomScale)
		{
			zoomScale = theScrollView.maximumZoomScale;
		}
	}

	if (zoomScale != theScrollView.zoomScale) // Do zoom
	{
		[theScrollView setZoomScale:zoomScale animated:YES];
	}
}

- (void)zoomReset
{

	if (theScrollView.zoomScale > theScrollView.minimumZoomScale)
	{
		theScrollView.zoomScale = theScrollView.minimumZoomScale;
	}
}

#pragma mark UIScrollViewDelegate methods

- (void)scrollViewTouchesBegan:(UIScrollView *)scrollView touches:(NSSet *)touches
{

	[delegate scrollViewTouchesBegan:scrollView touches:touches];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return theContainerView;
}

@end
