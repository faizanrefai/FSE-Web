//
//  ImageView.m
//  FSEnet
//
//  Created by apple on 3/20/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import "ImageView.h"


@implementation ImageView


@synthesize valueDict;
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
	
	[self performSelector:@selector(addGestureRecognizersToPiece:) withObject:productZoomScroll afterDelay:0.1];
	
}

-(void)viewWillAppear:(BOOL)animated
{
	
	self.navigationController.navigationBar.hidden = TRUE;
	
	self.valueDict= appDelegateObj.valueDetail;
	Test1 *product = (Test1*) self.valueDict;
	
	[product_name_lbl setText:[NSString stringWithFormat:@"%@",appDelegateObj.product_name]];
	
	NSString *str = [NSString stringWithFormat:@"%@",product.PRD_IMAGE_LINK];
	NSLog(@"%@",str);

	if(myimageView2 || myImgView)
	{
		[myimageView2 removeFromSuperview];
		myimageView2=nil;
		[myimageView2 release];
		
		[myImgView removeFromSuperview];
		myImgView=nil;
		[myImgView release];
		
	}
	
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
			myImgView = [[UIImageView alloc]init];
			myImgView.frame = CGRectMake( 0, 0, 720, 720);
			
			myimageView2 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder_ipad_img.png"]];
		}else {
			myImgView = [[UIImageView alloc]init];
			myImgView.frame = CGRectMake( 0, 0, 300, 300);
			
			myimageView2 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"placeholder_iphone_img.png"]];
		
		}
	
		[productZoomScroll addSubview:myImgView];
	
	[myimageView2 setContentMode:UIViewContentModeScaleAspectFit];
	
		myimageView2.frame = myImgView.bounds;
		myimageView2.delegate = self;
		[myImgView.layer setMasksToBounds:YES];
		[myImgView addSubview:myimageView2];

	if (![str isEqualToString:@""]) 
	{
		myimageView2.imageURL = [NSURL URLWithString:str];
	}
	else {
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
			myimageView2.image = [UIImage imageNamed:@"noimage_big_ipad.png"];
		}else {
			myimageView2.image = [UIImage imageNamed:@"noimage_big.png"];
		}
	}
	
	
	productZoomScroll.contentSize = CGSizeMake(300, 300);
	productZoomScroll.contentOffset = CGPointMake(0, 0);
	productZoomScroll.minimumZoomScale = 1.0;
	productZoomScroll.maximumZoomScale = 2.0;
	productZoomScroll.backgroundColor = [UIColor whiteColor];
	
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	if (scrollView == productZoomScroll) {
		return myImgView;
	}
	return nil;
}

- (void)addGestureRecognizersToPiece:(UIView *)piece
{
	UISwipeGestureRecognizer *Gesture1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(next)];
    [piece addGestureRecognizer:Gesture1];
	[Gesture1 setDirection:UISwipeGestureRecognizerDirectionLeft];
    [Gesture1 release];
	
	UISwipeGestureRecognizer *Gesture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previous)];
    [piece addGestureRecognizer:Gesture2];
	[Gesture2 setDirection:UISwipeGestureRecognizerDirectionRight];
    [Gesture2 release];
}


-(void)next
{
	[appDelegateObj.tabBarController setSelectedIndex:4];
}

-(void)previous
{
	[appDelegateObj.tabBarController setSelectedIndex:2];
}


-(IBAction)Back_Btn_CLicked:(id)sender
{
	[[EGOCache currentCache] clearCache];
	[self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)Logout_Btn_CLicked:(id)sender
{
	[[EGOCache currentCache] clearCache];
	[appDelegateObj Logout];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewWillDisappear:(BOOL)animated
{
	
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
	[self.valueDict release];
	
}


@end
