//
//  Specification.m
//  FSEnet
//
//  Created by apple on 3/20/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import "Specification.h"


@implementation Specification

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
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		myTable.rowHeight = 54.0;
	}
	else {
		myTable.rowHeight = 44.0;
	}

	
	
	[self performSelector:@selector(addGestureRecognizersToPiece:) withObject:myTable afterDelay:0.1];
		
}

- (void)addGestureRecognizersToPiece:(UIView *)piece
{
	UISwipeGestureRecognizer *Gesture1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(next)];
    [piece addGestureRecognizer:Gesture1];
	[Gesture1 setDirection:UISwipeGestureRecognizerDirectionLeft];
    [Gesture1 release];
}

-(void)next
{
	[appDelegateObj.tabBarController setSelectedIndex:1];
}


-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.hidden = TRUE;
		
	[myTable setContentOffset:CGPointMake(0, 0) animated:NO];
	//[myScroll setContentOffset:CGPointMake(0, 0) animated:NO];
	
	self.valueArr = appDelegateObj.valueDetail;
	Test1 *product = (Test1*) self.valueArr;
	
	[product_name_lbl setText:[NSString stringWithFormat:@"%@",appDelegateObj.product_name]];
	
	displayData = [[NSMutableArray alloc]init];
	
	
	if (product.Brand_Name!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Brand Name :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.Brand_Name] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.MPC != nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"MPC :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.MPC] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.GTIN != nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"GTIN :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.GTIN] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Avg_Serving!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Avg. Serving :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.Avg_Serving] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Net_Content!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Net Content :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Net_Content,product.Net_Content_UOM] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Shelf_Life!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Shelf Life :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Shelf_Life,product.Shelf_Life_UOM] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Height!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Height :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%.4f %@",[product.Height floatValue],product.Height_UOM] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Width!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Width :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%.4f %@",[product.Width floatValue],product.Width_UOM] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Depth!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Depth :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%.4f %@",[product.Depth floatValue],product.Depth_UOM] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Volume!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Volume :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%.4f %@",[product.Volume floatValue],product.Volume_UOM] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Gross_Weight!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Gross Weight :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%.4f %@",[product.Gross_Weight floatValue],product.Gr_Weight_UOM] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Net_Weight!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Net Weight :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%.4f %@",[product.Net_Weight floatValue],product.Net_Weight_UOM] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Pallet_Ti!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Pallet Ti :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.Pallet_Ti] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Pallet_Hi!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Pallet Hi" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.Pallet_Hi] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Storage_Temp_From!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Storage Temp From :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Storage_Temp_From,product.Storage_Temp_From_UOM] forKey:@"val"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Storage_Temp_To!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:@"Storage Temp To :" forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Storage_Temp_To,product.Storage_Temp_To_UOM] forKey:@"val"];
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
    //return [[[c_arr objectAtIndex:section] valueForKey:@"value"] count];
	
	return  [displayData count];
    
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
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		lbl_name = [[UILabel alloc] initWithFrame:CGRectMake(10,0,364,tableView.rowHeight)];
		lbl_address = [[UILabel alloc] initWithFrame:CGRectMake(394,0,364,tableView.rowHeight)];
		img_cell_bk = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,768,54)];
		[lbl_name setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0]];
		lbl_address.font=[UIFont systemFontOfSize:16.0];
	}
	else 
	{
		lbl_name = [[UILabel alloc] initWithFrame:CGRectMake(10,0,140,tableView.rowHeight)];
		lbl_address = [[UILabel alloc] initWithFrame:CGRectMake(170,0,140,tableView.rowHeight)];
		img_cell_bk = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,44)];
		[lbl_name setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0]];
		lbl_address.font=[UIFont systemFontOfSize:12.0];
	}
	
	
	[img_cell_bk setImage:[UIImage imageNamed:@"cellBg.png"]];
	[cell.contentView addSubview:img_cell_bk];
	[img_cell_bk release];
	
	lbl_name.lineBreakMode = UILineBreakModeWordWrap;
	lbl_name.backgroundColor = [UIColor clearColor];
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
	
	displayData = nil;
	[displayData release];
	
	valueArr = nil;
	[valueArr release];
}


@end
