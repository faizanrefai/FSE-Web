//
//  LoginView.m
//  FSEnet
//
//  Created by apple on 3/17/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import "LoginView.h"


@implementation LoginView


@synthesize Login_Arr;

@synthesize managedObjectContext,token;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	appDelegateObj = (coredataAppDelegate *)[[UIApplication sharedApplication]delegate];
}


-(void)viewWillAppear:(BOOL)animated
{

	U_name_txt.text = @"rajesh";
	U_Password_txt.text = @"fse123";
	
	self.navigationItem.title = @"Login";
	[U_name_txt becomeFirstResponder];
	self.navigationController.navigationBar.hidden = TRUE;
	
}

-(IBAction)Btn_Login_clicked:(id)sender
{
	
	//self.navigationItem.title =@"Logout";
//	ProductCategory *ProductCategoryObj;
//	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
//		ProductCategoryObj = [[ProductCategory alloc]initWithNibName:@"ProductCategory_ipad" bundle:nil];
//	}else {
//		ProductCategoryObj = [[ProductCategory alloc]initWithNibName:@"ProductCategory" bundle:nil];
//	}
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:1.0];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
//	[self.navigationController pushViewController:ProductCategoryObj animated:NO];
//	[UIView commitAnimations];
//	[ProductCategoryObj release];
	
	[U_name_txt resignFirstResponder];
	[U_Password_txt resignFirstResponder];
	
	BOOL InternetAccessibility = [appDelegateObj checkInternet];
	if (InternetAccessibility==0) 
	{
		[customealert showAlert:@"Alert" message:@"Please connect your device with internet." delegate:self];
	}
	else 
	{
		NSString *u_name = [U_name_txt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		NSString *u_pwd = [U_Password_txt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
		if ([u_name isEqualToString:@""] || [u_pwd isEqualToString:@""]) {
			[customealert showAlert:@"Alert" message:@"Username/Password can not be null." delegate:self];
		}
		else {
			NSString *urlString = [NSString stringWithFormat:@"http://sandbox.fsenet.com/FSEMobileServices/login?userName=%@&password=%@",u_name,u_pwd];
			urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
			NSLog(@"%@",urlString);
			[self showHUD];
			Web_req =[[ASIHttpParser alloc] initWithRequestWithURL:urlString selSuccess:@selector(Login_Detail:) selError:@selector(OnError) andHandler:self];
		
			ResourceLoader *loader = [ResourceLoader sharedResourceLoader];
			self.token = [loader loadOperationWithObject:Web_req forDelegate:self withSelector:@selector(startParsingReq)];
			
		
		}
	}
}

-(void)Login_Detail:(NSDictionary*)dictionary{
	NSLog(@"%@",dictionary);
	[self hideHUD];
	self.Login_Arr = (NSMutableArray*)dictionary;
	
	if ([self.Login_Arr valueForKey:@"pyId"] != nil || dictionary != nil) {
		
		NSString* countNum = [self.Login_Arr valueForKey:@"contId"];
		
		if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] isEqualToString:countNum]) 
		{
			[[NSUserDefaults standardUserDefaults] setValue:countNum forKey:@"user"];
			[[NSUserDefaults standardUserDefaults] synchronize];
			
			[[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"first"];
			[[NSUserDefaults standardUserDefaults] synchronize];
			
			[[NSUserDefaults standardUserDefaults]setValue:@"0" forKey:@"case"];
			[[NSUserDefaults standardUserDefaults] synchronize];
			
			[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"OnOff"];
			[[NSUserDefaults standardUserDefaults] synchronize];
			
			[self deleteAllObjects:@"Test1"];
		}
		
		appDelegateObj.isFse = [self.Login_Arr valueForKey:@"isFse"];
		appDelegateObj.pyId = [self.Login_Arr valueForKey:@"pyId"];
		
		ProductCategory *ProductCategoryObj;
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
			ProductCategoryObj = [[ProductCategory alloc]initWithNibName:@"ProductCategory_ipad" bundle:nil];
		}else {
			ProductCategoryObj = [[ProductCategory alloc]initWithNibName:@"ProductCategory" bundle:nil];
		}
		 
		self.navigationItem.title =@"Logout";
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:1.0];
		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
		[self.navigationController pushViewController:ProductCategoryObj animated:YES];
		[UIView commitAnimations];
		
		[ProductCategoryObj release];
	}
	else {
		[customealert showAlert:@"Alert" message:@"Username/Password is incorrect." delegate:self];
	}

	
}

- (void) deleteAllObjects: (NSString *) entityDescription  {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:[appDelegateObj managedObjectContext]];
    [fetchRequest setEntity:entity];
	
    NSError *error;
    NSArray *items = [[appDelegateObj managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
	
    for (NSManagedObject *managedObject in items) {
        [[appDelegateObj managedObjectContext] deleteObject:managedObject];
        //NSLog(@"%@ object deleted",entityDescription);
    }
    if (![[appDelegateObj managedObjectContext] save:&error]) {
        NSLog(@"Error deleting %@ - error:%@",entityDescription,error);
    }
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)showHUD{
	[self hideHUD];
	HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
    HUD.labelText = @"Processing..";
	[HUD show:YES];
	self.view.userInteractionEnabled = NO;
}
-(void)hideHUD{
	if (HUD) {
		[HUD hide:YES];
		[HUD removeFromSuperview];
		[HUD release];
		HUD = nil;
		self.view.userInteractionEnabled = YES;
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
