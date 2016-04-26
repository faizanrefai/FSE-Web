//
//  NutriticationFacts.m
//  FSEnet
//
//  Created by apple on 3/20/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import "NutriticationFacts.h"


@implementation NutriticationFacts

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
	
	//myScroll.contentSize = CGSizeMake(320, 705);
	
	appDelegateObj = (coredataAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	[self performSelector:@selector(addGestureRecognizersToPiece:) withObject:myTable afterDelay:0.1];
}


-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.hidden = TRUE;
	[myTable setContentOffset:CGPointMake(0, 0) animated:NO];
	
	
	self.valueArr = appDelegateObj.valueDetail;
	Test1 *product = (Test1*) self.valueArr;
	
	[product_name_lbl setText:[NSString stringWithFormat:@"%@",appDelegateObj.product_name]];
	
	displayData = [[NSMutableArray alloc]init];
	
	
	if (product.Serving_Size!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:[NSString stringWithFormat:@"Serving Size :"] forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%.2f %@",[product.Serving_Size floatValue],product.Serving_Size_UOM] forKey:@"val1"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Calories!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:[NSString stringWithFormat:@"Calories :"] forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Calories,product.Calories_UOM] forKey:@"val1"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Calories_Fat!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:[NSString stringWithFormat:@"     Calories from Fat :"] forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Calories_Fat,product.Calories_Fat_UOM] forKey:@"val1"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Total_Fat!=nil || product.Total_Fat_RDI!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		
		[dict setObject:[NSString stringWithFormat:@"Total Fat :"] forKey:@"data"];
		
		if(product.Total_Fat!=nil)
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Total_Fat,product.Total_Fat_UOM] forKey:@"val1"];
			
		if(product.Total_Fat_RDI!=nil)
		[dict setObject:[NSString stringWithFormat:@"%.2f %@",[product.Total_Fat_RDI floatValue],@"%"] forKey:@"val2"];
		
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Saturated_Fat!=nil || product.Sat_Fat_RDI!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		
		[dict setObject:[NSString stringWithFormat:@"     Saturated Fat :"] forKey:@"data"];
		
		if(product.Saturated_Fat!=nil)
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Saturated_Fat,product.Saturated_Fat_UOM] forKey:@"val1"];
		
		if(product.Sat_Fat_RDI!=nil)
		[dict setObject:[NSString stringWithFormat:@"%.2f %@",[product.Sat_Fat_RDI floatValue],@"%"] forKey:@"val2"];
		
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Trans_Fatty_Acid!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:[NSString stringWithFormat:@"Trans Fatty Acid :"] forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Trans_Fatty_Acid,product.Trans_Fatty_Acid_UOM] forKey:@"val1"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Cholestrol!=nil || product.Cholestrol_RDI!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		
		[dict setObject:[NSString stringWithFormat:@"Cholestrol :"] forKey:@"data"];
		
		if (product.Cholestrol!=nil)
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Cholestrol,product.Cholestrol_UOM] forKey:@"val1"];
		
		if (product.Cholestrol_RDI!=nil)
		[dict setObject:[NSString stringWithFormat:@"%.2f %@",product.Cholestrol_RDI,@"%"] forKey:@"val2"];
		
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Sodium!=nil || product.Sodium_RDI!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		
		[dict setObject:[NSString stringWithFormat:@"Sodium :"] forKey:@"data"];
		
		if (product.Sodium!=nil)
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Sodium,product.Sodium_UOM] forKey:@"val1"];
		
		if (product.Sodium_RDI!=nil)
		[dict setObject:[NSString stringWithFormat:@"%.2f %@",[product.Sodium_RDI floatValue],@"%"] forKey:@"val2"];
		
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Carbohydrates!=nil || product.Carb_RDI!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		
		[dict setObject:[NSString stringWithFormat:@"Carbohydrates :"] forKey:@"data"];
		
		if (product.Carbohydrates!=nil)
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Carbohydrates,product.Carbohydrates_UOM] forKey:@"val1"];
		
		if (product.Carb_RDI!=nil)
		[dict setObject:[NSString stringWithFormat:@"%.2f %@",[product.Carb_RDI floatValue],@"%"] forKey:@"val2"];
		
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Total_Diet_Fiber!=nil || product.Total_Diet_Fiber_RDI!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		
		[dict setObject:[NSString stringWithFormat:@"     Total Diet Fiber :"] forKey:@"data"];
		
		if (product.Total_Diet_Fiber!=nil)
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Total_Diet_Fiber,product.Total_Diet_Fiber_UOM] forKey:@"val1"];
		
		if (product.Total_Diet_Fiber_RDI!=nil)
		[dict setObject:[NSString stringWithFormat:@"%.2f %@",[product.Total_Diet_Fiber_RDI floatValue],@"%"] forKey:@"val2"];
		
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Total_Sugar!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:[NSString stringWithFormat:@"     Total Sugar :"] forKey:@"data"];
		
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Total_Sugar,product.Total_Sugar_UOM] forKey:@"val1"];
		
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Protein!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:[NSString stringWithFormat:@"Protein :"] forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@ %@",product.Protein,product.Protein_UOM] forKey:@"val1"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Calcium_RDI!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:[NSString stringWithFormat:@"Calcium RDI :"] forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%.2f %@",[product.Calcium_RDI floatValue],@"%"] forKey:@"val2"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Iron_RDI!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:[NSString stringWithFormat:@"Iron %@ RDI :",@"%"] forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%.2f %@",[product.Iron_RDI floatValue],@"%"] forKey:@"val2"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Vitamin_A_RDI!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:[NSString stringWithFormat:@"Vitamin A %@ RDI :",@"%"] forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%.2f %@",[product.Vitamin_A_RDI floatValue],@"%"] forKey:@"val2"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Vitamin_C_RDI!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:[NSString stringWithFormat:@"Vitamin C %@ RDI :",@"%"] forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%.2f %@",[product.Vitamin_C_RDI floatValue],@"%"] forKey:@"val2"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Child_Nutrition_Flag!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:[NSString stringWithFormat:@"Child Nutrition Flag :"] forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.Child_Nutrition_Flag] forKey:@"val1"];
		[displayData addObject:dict];
		[dict release];
	}
	
	if (product.Ingredients!=nil) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
		[dict setObject:[NSString stringWithFormat:@"Ingredients :"] forKey:@"data"];
		[dict setObject:[NSString stringWithFormat:@"%@",product.Ingredients] forKey:@"val1"];
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
	[appDelegateObj.tabBarController setSelectedIndex:2];
}

-(void)previous
{
	[appDelegateObj.tabBarController setSelectedIndex:0];
}

-(IBAction)Logout_Btn_CLicked:(id)sender
{
	[[EGOCache currentCache] clearCache];
	[appDelegateObj Logout];
	
}

-(int)size:(NSString*)string
{
	//NSLog(@"a : %@",string);
	NSString *str = [NSString stringWithFormat:@"%@",string];
	CGSize textSize = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:12.0] constrainedToSize:CGSizeMake(140, 500000)];
	return textSize.height>34?textSize.height:34;
}

-(int)sizeIpad:(NSString*)string
{
	//NSLog(@"a : %@",string);
	NSString *str = [NSString stringWithFormat:@"%@",string];
	CGSize textSize = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:16.0] constrainedToSize:CGSizeMake(410, 500000)];
	return textSize.height>44?textSize.height:44;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	float height;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		height = [self sizeIpad:[NSString stringWithFormat:@"%@",[[displayData objectAtIndex:indexPath.row] valueForKey:@"val1"]]];
	}else {
		height = [self size:[NSString stringWithFormat:@"%@", [[displayData objectAtIndex:indexPath.row] valueForKey:@"val1"]]];
	}
	
	return height+10;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   	
	cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	UILabel *lbl_name;
	UILabel *lbl_val1;
	UILabel *lbl_val2;
	UIImageView *img_cell_bk;
	
	NSMutableDictionary *dict = [displayData objectAtIndex:indexPath.row];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		float height = [self sizeIpad:[NSString stringWithFormat:@"%@", [[displayData objectAtIndex:indexPath.row] valueForKey:@"val1"]]];
		
		lbl_name = [[UILabel alloc] initWithFrame:CGRectMake(10,5,296,height)];
		
		
		
		if ([[dict objectForKey:@"data"] isEqualToString:@"Ingredients :"]) {
			lbl_val1 = [[UILabel alloc] initWithFrame:CGRectMake(346,5,410,height)];
		}
		else {
			lbl_val1 = [[UILabel alloc] initWithFrame:CGRectMake(346,5,78,height)];
		}
		
		lbl_val2 = [[UILabel alloc] initWithFrame:CGRectMake(680,5,78,height)];
		
		img_cell_bk = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,768,height+10)];
		[lbl_name setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16.0]];
		lbl_val2.font=[UIFont systemFontOfSize:16.0];
		lbl_val1.font=[UIFont systemFontOfSize:16.0];
		
	}
	else
	{
		float height = [self size:[NSString stringWithFormat:@"%@",[[displayData objectAtIndex:indexPath.row] valueForKey:@"val1"]]];
		
		lbl_name = [[UILabel alloc] initWithFrame:CGRectMake(10,5,150,height)];
		
		if ([[dict objectForKey:@"data"] isEqualToString:@"Ingredients :"]) {
			lbl_val1 = [[UILabel alloc] initWithFrame:CGRectMake(170,5,140,height)];
		}
		else {
			lbl_val1 = [[UILabel alloc] initWithFrame:CGRectMake(170,5,50,height)];
		}
		
		
		
		lbl_val2 = [[UILabel alloc] initWithFrame:CGRectMake(260,5,50,height)];
		
		img_cell_bk = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,height+10)];
		[lbl_name setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12.0]];
		lbl_val2.font=[UIFont systemFontOfSize:12.0];
		lbl_val1.font=[UIFont systemFontOfSize:12.0];
	}
	
	//lbl_val2.backgroundColor = [UIColor redColor];
//	lbl_name.backgroundColor = [UIColor redColor];
	
	[img_cell_bk setImage:[UIImage imageNamed:@"cellBg.png"]];
	[cell.contentView addSubview:img_cell_bk];
	[img_cell_bk release];	
	
	
	
	lbl_name.lineBreakMode = UILineBreakModeWordWrap;
	lbl_name.numberOfLines = 0;
	lbl_name.backgroundColor = [UIColor clearColor];
	[lbl_name setTextColor:[UIColor colorWithRed:84.0/255.0 green:84.0/255.0 blue:84.0/255.0 alpha:1.0]];
	lbl_name.text =[NSString stringWithFormat:@"%@", [dict valueForKey:@"data"]];
	
	NSLog(@"%@",[dict valueForKey:@"val1"]);
	
	[cell.contentView addSubview:lbl_name];	
	lbl_name=nil;
	[lbl_name release];
	
	
	if ([dict objectForKey:@"val1"]) 
	{
		
		lbl_val1.lineBreakMode = UILineBreakModeWordWrap;
		lbl_val1.numberOfLines = 0;//Dynamic
		lbl_val1.textAlignment = UITextAlignmentCenter;
		lbl_val1.backgroundColor = [UIColor clearColor];
		[lbl_val1 setTextColor:[UIColor colorWithRed:84.0/255.0 green:84.0/255.0 blue:84.0/255.0 alpha:1.0]];
		lbl_val1.text = [NSString stringWithFormat:@"%@", [dict valueForKey:@"val1"]];
		[cell.contentView addSubview:lbl_val1];	
		lbl_val1=nil;
		[lbl_val1 release];
		
		
	}
	
	if ([dict objectForKey:@"val2"]) 
	{
		lbl_val2.lineBreakMode = UILineBreakModeWordWrap;
		lbl_val2.numberOfLines = 0;//Dynamic
		lbl_val2.textAlignment = UITextAlignmentRight;
		lbl_val2.backgroundColor = [UIColor clearColor];
		[lbl_val2 setTextColor:[UIColor colorWithRed:84.0/255.0 green:84.0/255.0 blue:84.0/255.0 alpha:1.0]];
		lbl_val2.text = [NSString stringWithFormat:@"%@", [dict valueForKey:@"val2"]];
		[cell.contentView addSubview:lbl_val2];	
		lbl_val2=nil;
		[lbl_val2 release];
	}

	
	
	
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
	
	valueArr=nil;
	[valueArr release];
}


@end
