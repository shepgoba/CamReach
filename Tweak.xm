UIView *tempview = nil;
//CGRect y = CGRect();
CGRect frame = CGRectMake(0, 120, 345, 44);
%hook CAMTopBar
	//- (void) layoutIfNeeded {}
	- (void) layoutSubviews 
	{
		%orig;
		//NSLog(@"%@",NSStringFromCGRect(frame));
		tempview = MSHookIvar<UIView *>(self, "__backgroundView");
		//CGRect topbarframe = MSHookIvar<CGRect>(self, "frame");
		//NSString *x = NSStringFromCGRect(tempview.frame);
		/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ROFL" 
                                                    message:x 
                                                    delegate:self 
                                                    cancelButtonTitle:@"OK" 
                                                    otherButtonTitles:nil];
		[alert show];*/
		CGRect tempframe = tempview.frame;
		tempframe.origin.y += 100;
		tempview.frame = tempframe;
		//tempview.origin.y += 100;
		MSHookIvar<UIView *>(self, "__backgroundView") = tempview;
		//topbarframe.origin.y = 0;
		
	}
%end

%hook CAMButtonLabel

	- (void) _updateAttributedText
	{
		%orig;
		MSHookIvar<NSString *>(self, "_text") = @"yeet";
	}
%end
@interface CAMModeDial : UIView
@property (nonatomic,readonly) CGRect frame; 
@end
%hook CAMModeDial
		/*UIView *t = MSHookIvar<UIView *>(self, "__itemsContainerView");
		t.frame = CGRect();
		CGRect y = t.frame;
		y.origin.y += 100;
		t.frame = y;
		MSHookIvar<UIView *>(self, "__itemsContainerView") = t;*/
		//NSLog(t)
	-(void) layoutSubviews 
	{
		%orig;
		//[self initWithFrame:frame];
	}
%end
