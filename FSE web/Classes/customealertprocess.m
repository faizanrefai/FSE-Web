//
//  customealert.m
//  popalock
//
//  Created by apple on 12/1/11.
//  Copyright 2011 fgbfg. All rights reserved.
//

#import "customealertprocess.h"


@implementation customealertprocess

@synthesize lblAlertTitle;
@synthesize lblAlertMessage;
@synthesize _processDelegate;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

+(void)showAlert:(NSString*)strHeader message:(NSString*)strMessage delegate:(id)sender
{	
	
	UIViewController *controller;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		controller = [[UIViewController alloc] initWithNibName:@"customealertprocess_ipad" bundle:[NSBundle mainBundle]];
	}else {
		controller = [[UIViewController alloc] initWithNibName:@"customealertprocess" bundle:[NSBundle mainBundle]];
	}
	
	customealertprocess *customeAlertView = (customealertprocess *)controller.view;
	customeAlertView.lblAlertTitle.text = strHeader;
	customeAlertView.lblAlertMessage.text = strMessage;
	customeAlertView._processDelegate =sender;
	[customeAlertView show];
	[controller release];
}

-(IBAction)Logout
{
	if([_processDelegate respondsToSelector:@selector(ConfirmLogout)])
		[_processDelegate ConfirmLogout];
	[self dismiss:YES];	
}

- (void)dialogWillAppear {
	[super dialogWillAppear];
}


- (void)dialogWillDisappear {
	[super dialogWillDisappear];
}


- (void)dealloc {
	[lblAlertTitle release];
	[lblAlertMessage release];
    [super dealloc];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/



@end
