//
//  OtherInformation.m
//  FSEnet
//
//  Created by apple on 3/20/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import "OtherInformation.h"

#define distance 6


@implementation OtherInformation

@synthesize valueArr;

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
	
	[self performSelector:@selector(addGestureRecognizersToPiece:) withObject:myTable afterDelay:0.1];
}


-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.hidden = TRUE;
	[product_name_lbl setText:[NSString stringWithFormat:@"%@",appDelegateObj.product_name]];
	
	[myTable setContentOffset:CGPointMake(0, 0) animated:NO];
	
	self.valueArr = appDelegateObj.valueDetail;
	Test1 *product = (Test1*) self.valueArr;
	
	displayData = [[NSMutableArray alloc]init];
	
	if (product.Brand_Owner!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Brand Owner :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.Brand_Owner] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.GPC_Description!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"GPC Description :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.GPC_Description] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Country_Origin_of_Product!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Country Origin of Product :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.Country_Origin_of_Product] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Kosher!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Kosher :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.Kosher] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.General_Desc!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"General Desc :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.General_Desc] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Benefits!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Benefits :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.Benefits] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.More_Info!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"More Info :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.More_Info] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Pack_Storage_Info!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Pack & Storage Info :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.Pack_Storage_Info] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Prep_Cooking_Sugg!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Prep & Cooking Sugg. :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.Prep_Cooking_Sugg] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Serving_Suggestion!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Serving Suggestion :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.Serving_Suggestion] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if ([displayData count]==0) 
	{
		noDataImg.hidden = FALSE;
	}
	else {
		noDataImg.hidden = TRUE;
	}
	
	
	[myTable reloadData];
}

-(int)size:(NSString*)string
{
	//NSLog(@"a : %@",string);
	NSString *str = [NSString stringWithFormat:@"%@",string];
	CGSize textSize = [str sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(140, 500000)];
	return textSize.height>44?textSize.height:44;
}

-(int)sizeIpad:(NSString*)string
{
	//NSLog(@"a : %@",string);
	NSString *str = [NSString stringWithFormat:@"%@",string];
	CGSize textSize = [str sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(364, 500000)];
	return textSize.height>44?textSize.height:44;
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
	[appDelegateObj.tabBarController setSelectedIndex:3];
}

-(void)previous
{
	[appDelegateObj.tabBarController setSelectedIndex:1];
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

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return [[c_arr valueForKey:@"key"] count];
	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return  [displayData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	float height;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		height = [self sizeIpad:[NSString stringWithFormat:@"%@", [[displayData objectAtIndex:indexPath.row] valueForKey:@"val"]]];
	}else {
		height = [self size:[NSString stringWithFormat:@"%@", [[displayData objectAtIndex:indexPath.row] valueForKey:@"val"]]];
	}
	height += 10;
	return height;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   	
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	
	
	UILabel *lbl_name;
	UILabel *lbl_address;
	UIImageView *img_cell_bk;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		float height = [self sizeIpad:[NSString stringWithFormat:@"%@", [[displayData objectAtIndex:indexPath.row] valueForKey:@"val"]]];
		
		lbl_name = [[UILabel alloc] initWithFrame:CGRectMake(10,5,364,height)];
		lbl_address = [[UILabel alloc] initWithFrame:CGRectMake(394,5,364,height)];
		img_cell_bk = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,768,height+10)];
		[lbl_name setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0]];
		lbl_address.font=[UIFont systemFontOfSize:16.0];
	}else {
		float height = [self size:[NSString stringWithFormat:@"%@", [[displayData objectAtIndex:indexPath.row] valueForKey:@"val"]]];
		
		lbl_name = [[UILabel alloc] initWithFrame:CGRectMake(10,5,140,height)];
		lbl_address = [[UILabel alloc] initWithFrame:CGRectMake(170,5,140,height)];
		img_cell_bk = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,height+10)];
		[lbl_name setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0]];
		lbl_address.font=[UIFont systemFontOfSize:12.0];
	}

	
	
	[img_cell_bk setImage:[UIImage imageNamed:@"cellBg.png"]];
	[cell.contentView addSubview:img_cell_bk];
	[img_cell_bk release];
	
	
	
	lbl_name.lineBreakMode = UILineBreakModeWordWrap;
	lbl_name.backgroundColor = [UIColor clearColor];
	lbl_name.numberOfLines = 2;
	[lbl_name setTextColor:[UIColor colorWithRed:84.0/255.0 green:84.0/255.0 blue:84.0/255.0 alpha:1.0]];
	
	lbl_name.text =[NSString stringWithFormat:@"%@", [[displayData objectAtIndex:indexPath.row] valueForKey:@"data"]];
	[cell.contentView addSubview:lbl_name];	
	lbl_name=nil;
	[lbl_name release];
	
	
	
	lbl_address.lineBreakMode = UILineBreakModeWordWrap;
	lbl_address.numberOfLines = 0;//Dynamic
	lbl_address.backgroundColor = [UIColor clearColor];
	[lbl_address setTextColor:[UIColor colorWithRed:84.0/255.0 green:84.0/255.0 blue:84.0/255.0 alpha:1.0]];
	lbl_address.text = [NSString stringWithFormat:@"%@", [[displayData objectAtIndex:indexPath.row] valueForKey:@"val"]];
	
	[cell.contentView addSubview:lbl_address];	
	
	lbl_address=nil;
	[lbl_address release];
	
	
	
	return cell;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
