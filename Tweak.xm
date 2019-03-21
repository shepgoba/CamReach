//Copyright (C) shepgoba 2019
@interface CAMModeDial : UIView
@property (nonatomic, assign) CGRect frame;
@end
@interface CAMTopBar : UIView
@property (nonatomic, assign) CGRect frame;
@end
@interface CAMFilterScrubberView : UIView
@property (nonatomic, assign) CGRect frame;
@end
CAMModeDial *bottomDial = nil;
CAMTopBar *topBar = nil;
CAMFilterScrubberView *scrubber = nil;
BOOL scrubberAppear = NO;
static CGRect topBarFrame;
static BOOL runone = NO;

%hook CAMTopBar
	- (void) layoutIfNeeded {}
	- (void) layoutSubviews 
	{
		%orig;
		topBar = self;
		//self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - 2);
		if (!runone)
		{
			topBarFrame = self.frame;
			runone = YES;
		}
		[self removeFromSuperview];
	}
%end
%hook CAMModeDial
	- (void) layoutIfNeeded {}
	- (void) layoutSubviews 
	{
		%orig;
		bottomDial = self;
		bottomDial.frame = topBarFrame; /* Set the frame of bottomDial equal to original TopBar frame */
		[self removeFromSuperview]; 

	}
%end
void setTopBarFrame()
{
	CGRect tmpFrame = topBar.frame;
	tmpFrame.origin.y = 0;
	topBar.frame = tmpFrame;
}
@interface CAMViewfinderView : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL opaque;
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end
%hook CAMViewfinderView
	UIColor *clear = [UIColor colorWithRed: 0.0f green: 0.0f blue: 0.0f alpha:0.0f];
	- (void) layoutIfNeeded {}
	- (void) layoutSubviews
	{
		%orig;
		bottomDial.frame = topBarFrame;
		setTopBarFrame();
		[self addSubview: bottomDial];
	}
%end

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

%hook CAMBottomBar
	- (void) layoutIfNeeded {}
	- (void) layoutSubviews
	{
		%orig();
		setTopBarFrame();
		[self addSubview: topBar];
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
