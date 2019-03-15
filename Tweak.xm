//Copyright (C) shepgoba 2019
CAMModeDial *bottomDial = nil;
CAMTopBar *topBar = nil;
CAMLivePhotoBadge *livePhotoBadge = nil;
@interface CAMTopBar : UIView
@property (nonatomic, assign) CGRect frame;
@end
%hook CAMTopBar
	- (void) layoutIfNeeded {}
	- (void) layoutSubviews 
	{
		%orig;
		topBar = self;
		[self removeFromSuperview];
	}
%end
@interface CAMModeDial : UIView
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end
%hook CAMModeDial
	- (void) layoutIfNeeded {}
	- (void) layoutSubviews 
	{
		%orig;
		bottomDial = self;
		[self removeFromSuperview];
	}
%end
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
		[self addSubview: bottomDial];
	}
%end

@interface CAMLivePhotoBadge : UIView
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end
%hook CAMLivePhotoBadge
	- (void) layoutIfNeeded {}
	- (void) viewDidLoad
	{
		%orig;
		livePhotoBadge = self;
		[self removeFromSuperview];
	}
%end
%hook CAMBottomBar
	- (void) layoutIfNeeded {}
	- (void) layoutSubviews
	{
		%orig;
		CGRect newFrame = topBar.frame;
		newFrame.size.height = 38;
		topBar.frame = newFrame;
		CGRect tmpFrame = livePhotoBadge.frame;
		livePhotoBadge.frame = tmpFrame;
		[self addSubview: topBar];
		[self addSubview: livePhotoBadge];
	}
%end
@interface CAMFilterScrubberView : UIView
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end
%hook CAMFilterScrubberView
	- (void) layoutIfNeeded {}
	- (void) layoutSubviews
	{
		%orig;
		CGRect tmpFrame = self.frame;
		tmpFrame.origin.y -= 85;
		self.frame = tmpFrame;
	}
%end

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
