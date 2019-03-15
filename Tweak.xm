
//C
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
		//NSLog(@"%@",NSStringFromCGRect(frame));
		//tempview = MSHookIvar<UIView *>(self, "__backgroundView");
		//CGRect topbarframe = MSHookIvar<CGRect>(self, "frame");
		//topbarframe.origin.y += 100;
		//NSString *x = NSStringFromCGRect(tempview.frame);
		/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ROFL" 
                                                    message:x 
                                                    delegate:self 
                                                    cancelButtonTitle:@"OK" 
                                                    otherButtonTitles:nil];
		[alert show];*/
		//CGRect tempframe = tempview.frame;
		//tempframe.origin.y += 100;
		//tempview.frame = tempframe;
		//tempview.origin.y += 100;
		//MSHookIvar<UIView *>(self, "__backgroundView") = tempview;
		//CGRect topbarframe = self.frame;
		//topbarframe.origin.y = 0;
		/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ROFL" 
                                                    message:NSStringFromCGRect(frame)
                                                    delegate:self 
                                                    cancelButtonTitle:@"OK" 
                                                    otherButtonTitles:nil];*/
		//[alert show];
		//CGRect camframe = self.frame;
		//camframe.origin.y = 345;
		//self.frame = camframe;
		//self.hidden = YES;
	}
%end
@interface CAMModeDial : UIView
//@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end
%hook CAMModeDial
		/*t.frame = CGRect();
		CGRect y = t.frame;
		y.origin.y += 100;
		t.frame = y;
		MSHookIvar<UIView *>(self, "__itemsContainerView") = t;*/
		//NSLog(t)
		- (void) layoutIfNeeded {}
	-(void) layoutSubviews 
	{
		%orig;
		bottomDial = self;
		[self removeFromSuperview];
		//UIView *t = MSHookIvar<UIView *>(self, "__itemsContainerView");
		/*CGRect dialFrame = t.frame;
		dialFrame.origin.y = -200;
		t.frame = dialFrame;*/
		//[t removeFromSuperview];
		//bottomDial = MSHookIvar<UIView *>(self, "__itemsContainerView");
		//[MSHookIvar<UIView *>(self, "__itemsContainerView") removeFromSuperview];
		//camframe2.origin.y = 0;
		//self.frame = camframe2;
		/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ROFL" 
                                                    message:NSStringFromCGRect(camframe2)
                                                    delegate:self 
                                                    cancelButtonTitle:@"OK" 
                                                    otherButtonTitles:nil];
		[alert show];*/
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
//@property (nonatomic, assign) CGRect frame;
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
-(void) layoutSubviews
{
	%orig;
	//CGRect yeet = CGRectMake(20, 20, 20, 20);
	CGRect newFrame = topBar.frame;
	newFrame.size.height = 38;
	topBar.frame = newFrame;
	CGRect tmpFrame = livePhotoBadge.frame;
	livePhotoBadge.frame = tmpFrame;
	//[self addSubview: yeet];
	[self addSubview: topBar];
	[self addSubview: livePhotoBadge];
}
%end
@interface CAMFilterScrubberView : UIView
//@property (nonatomic, assign) CGRect frame;
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
/*@interface CAMUtilityBar : UIView
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end
%hook CAMUtilityBar
	- (void) layoutIfNeeded {}
	- (void) layoutSubviews
	{
		%orig;
		CGRect tmpFrame = self.frame;
		tmpFrame.origin.y -= 90;
		self.frame = tmpFrame;
	}
%end*/
@interface CAMExpandableMenuButton : UIControl
//@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign, readwrite, getter=isHidden) BOOL hidden;
@end
%hook CAMExpandableMenuButton
	-(void) layoutIfNeeded {}
	-(void) layoutSubviews
	{
		%orig;
	}
%end
