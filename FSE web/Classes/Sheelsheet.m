//
//  Sheelsheet.m
//  FSEnet
//
//  Created by apple on 4/10/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import "Sheelsheet.h"


@implementation Sheelsheet


@synthesize valueDict;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	appDelegateObj = (coredataAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	[self performSelector:@selector(addGestureRecognizersToPiece:) withObject:myWebView afterDelay:0.1];
}

-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.hidden = TRUE;
	self.valueDict= appDelegateObj.valueDetail;
	Test1 *product = (Test1*) self.valueDict;
	
	[product_name_lbl setText:[NSString stringWithFormat:@"%@",appDelegateObj.product_name]];
	
	Pdfstr = [NSString stringWithFormat:@"http://sandbox.fsenet.com/FSEMobileServices/sellSheet?PRD_ID=%@&TPY_ID=%@&GPCType=%@",product.PRD_ID,product.TPY_ID,product.GPCType];
	NSLog(@"%@",Pdfstr);
	NSURL *url = [NSURL URLWithString:Pdfstr];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	myWebView.scalesPageToFit = TRUE;
	[myWebView loadRequest:request];
	
	PdfMailBtn.hidden = TRUE;
	
}


- (void)addGestureRecognizersToPiece:(UIView *)piece
{
	UISwipeGestureRecognizer *Gesture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previous)];
    [piece addGestureRecognizer:Gesture2];
	[Gesture2 setDirection:UISwipeGestureRecognizerDirectionRight];
    [Gesture2 release];
}

-(void)previous
{
	[appDelegateObj.tabBarController setSelectedIndex:3];
}

-(IBAction)Back_Btn_CLicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
	[[EGOCache currentCache] clearCache];
	
	NSURL *url = [NSURL URLWithString:[@"about:blank" stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[myWebView loadRequest:request];
}

#pragma mark -
#pragma mark Send Mail
-(IBAction)mail_btn_clicked
{
	[self showHUD];
	[self performSelector:@selector(DoMail) withObject:nil afterDelay:0.5];
}


-(void)DoMail
{
	if ([MFMailComposeViewController canSendMail]) 
	{
		MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
		[mail setSubject:[NSString stringWithFormat:@"%@",appDelegateObj.product_name]];
		NSURL *url = [NSURL URLWithString:Pdfstr];
		NSError *error = nil;
		NSMutableData *pdfData = [NSMutableData dataWithContentsOfURL:url options:NSUncachedRead error:&error];
		[mail addAttachmentData:pdfData mimeType:@"application/pdf" fileName:[NSString stringWithFormat:@"%@.pdf",appDelegateObj.product_name]];
		[mail setMailComposeDelegate:self];
		[self hideHUD];
		[self presentModalViewController:mail animated:YES];
		[mail release];
	}
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[act startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[act stopAnimating];
	PdfMailBtn.hidden = FALSE;
}

-(IBAction)Logout_Btn_CLicked:(id)sender
{
	NSURL *url = [NSURL URLWithString:[@"about:blank" stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[myWebView loadRequest:request];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[[EGOCache currentCache] clearCache];
	[appDelegateObj Logout];
	
}

-(void)viewWillDisappear:(BOOL)animated
{
	NSURL *url = [NSURL URLWithString:[@"about:blank" stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[myWebView loadRequest:request];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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
	
	valueDict=nil;
	[valueDict release];
}


@end
