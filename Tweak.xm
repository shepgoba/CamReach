#import "CAMFrame.h"
@interface CAMTopBar : UIView
@end
@interface CAMFilterScrubberView : UIView
@end
@interface CAMModeDial : UIView
@end
static CAMModeDial *bottomDial;
static CAMTopBar *ttopBar;
//static CAMBottomBar *bottomBar = nil;
//static CAMFilterScrubberView *scrubber = nil;
BOOL scrubberAppear = NO;
static CGRect topBarFrame;
static CGRect bottomDialFrame;
//static BOOL runone = NO;

@interface CAMBottomBar : UIView
@property (nonatomic,retain) CAMModeDial * modeDial;
@end

@implementation CAMBottomBar
@synthesize modeDial=_modeDial;
@end


@interface CAMViewfinderView : UIView
@property (nonatomic,retain) CAMTopBar * topBar; 
@property (nonatomic, retain) CAMBottomBar * bottomBar;
@end

@implementation CAMViewfinderView
@synthesize topBar=_topBar;
@synthesize bottomBar=_bottomBar;
@end


static BOOL hasRun = NO;
BOOL viewHasLoaded = NO;
CGRect CGRectCopy(CGPoint x, CGSize y)
{
	return CGRectMake(x.x, x.y, y.width, y.height);
}
%hook CAMViewfinderView
	- (void) layoutIfNeeded {}
	- (void) layoutSubviews
	{
		%orig;
		if (!hasRun)
		{
			bottomDialFrame = self.bottomBar.modeDial.frame; //this isn't even a copy. TODO: Deep copy values
			topBarFrame = self.topBar.frame; //this isn't even a copy. TODO: Deep copy values
			viewHasLoaded = YES;
			hasRun = YES;
		}
		[self addSubview: bottomDial];
	}
%end

%hook CAMBottomBar
	//- (void) layoutIfNeeded {}
	- (void) layoutSubviews
	{
		%orig;
		[self addSubview: ttopBar];
	}
%end
%hook CAMModeDial
	- (void) layoutIfNeeded {}
	- (void) layoutSubviews 
	{
		static BOOL hasRun = NO;
		%orig;
		if (viewHasLoaded)
		{
			bottomDial = self;
			self.frame = topBarFrame;
			if (!hasRun)
			{
				hasRun = YES;
			}
			[self removeFromSuperview];
		}
	}
%end

%hook CAMTopBar
	- (void) layoutSubviews 
	{
		static BOOL hasRun = NO;
		%orig;
		if (viewHasLoaded)
		{
			ttopBar = self;
			//self.frame = bottomDialFrame;
			if (!hasRun)
			{
				hasRun = YES;
			}
			[self removeFromSuperview];
			
		}
	}
	
%end

//CGRect *bottomDialFramePointer = &bottomDialFrame;
//void setTopBarFrame()
//{
	/*CGRect tmpFrame = topBar.frame;
	tmpFrame.origin.y = 0;
	topBar.frame = tmpFrame;*/
	//if (bottomDialFramePointer != nil)
	//{
		//topBar.frame = *bottomDialFramePointer;
	//}
//}
/*
%hook CAMFilterScrubberView
	- (void) layoutIfNeeded {}
	- (void) layoutSubviews
	{
		scrubber = self;
		[self removeFromSuperview];
		
		%orig;
	}
%end
@interface CAMUtilityBar : UIView
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end
%hook CAMUtilityBar
	- (void) layoutIfNeeded {}
	- (void) layoutSubviews
	{
		%orig;

		CGRect tmpFrame = scrubber.frame;
		tmpFrame.origin.y -= topBarFrame.size.height;
		scrubber.frame = tmpFrame;

		[self addSubview: scrubber];
	}
%end
/*
@interface CAMExpandableMenuButton : UIControl
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end
%hook CAMExpandableMenuButton
	-(void) layoutIfNeeded {}
	-(void) layoutSubviews
	{
		%orig;
	}
%end

*/
