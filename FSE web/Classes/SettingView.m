//
//  SettingView.m
//  FSEnet
//
//  Created by apple on 3/20/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import "SettingView.h"


@implementation SettingView

@synthesize onAndoff,_userDelegate;

+(void)showAlert:(int)OnOff delegate:(id)sender{
	
	UIViewController *controller;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		controller = [[UIViewController alloc] initWithNibName:@"SettingView_ipad" bundle:[NSBundle mainBundle]];
	}else {
		controller = [[UIViewController alloc] initWithNibName:@"SettingView" bundle:[NSBundle mainBundle]];
	}
	
	SettingView *customeAlertView = (SettingView *)controller.view;
	customeAlertView.onAndoff = OnOff;
	customeAlertView._userDelegate = sender;
	[customeAlertView show];
	[controller release];
}

- (void)dialogWillAppear {
	[super dialogWillAppear];
	
	if (onAndoff == 1) {
		on_btn.selected = TRUE;
		off_btn.selected = FALSE;
	}
	
	if (onAndoff == 0) {
		on_btn.selected = FALSE;
		off_btn.selected = TRUE;
	}
}

-(IBAction)onAndoff_btn_clicked:(id)sender
{
	UIButton *btn = (UIButton*)sender;
	
	int val;
	
	if (btn.tag == 1) {
		val = 1;
	}
	
	if (btn.tag == 0) {
		val = 0;
	}
	
	if([_userDelegate respondsToSelector:@selector(select_on_off_mode:)])
		[_userDelegate select_on_off_mode:val];
	[self dismiss:YES];
}


- (void)dialogWillDisappear {
	[super dialogWillDisappear];
}


- (void)dealloc {
    [super dealloc];
}


@end
