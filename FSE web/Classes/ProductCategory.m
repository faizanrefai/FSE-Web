//
//  ProductCategory.m
//  FSEnet
//
//  Created by apple on 3/19/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import "ProductCategory.h"


@implementation ProductCategory
@synthesize managedObjectContext,Web_req,dateStr,recordStart,recordEnd,token;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//dal = [[DAL alloc]init];
	self.navigationItem.title = @"Search By";
	
	recordStart = 1;
	recordEnd = 50;
	
	appDelegateObj = (coredataAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	[self performSelector:@selector(start) withObject:nil afterDelay:1];
	
	
}

-(void)start
{
	if(!Web_req)
	{
		[self select_on_off_mode:1];
		
		NSDate *date = [NSDate date];
		
		NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		dateFormatter.dateFormat = @"dd-MMM-yy hh:mm:ss a";
		[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
		dateFormatter.timeZone = [NSTimeZone systemTimeZone];
		self.dateStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
		
		recordStart = 1;
		recordEnd = 50;
		
		int S_Val = [[[NSUserDefaults standardUserDefaults]valueForKey:@"case"] intValue];
		
		if (S_Val == 1)
		{
			self.dateStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"date"];
			recordStart = [[[NSUserDefaults standardUserDefaults] valueForKey:@"start"] intValue];
			recordEnd = [[[NSUserDefaults standardUserDefaults] valueForKey:@"end"] intValue];
		}
		
		[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"case"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		[[NSUserDefaults standardUserDefaults] setValue:self.dateStr forKey:@"date"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		[[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",recordStart] forKey:@"start"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		[[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",recordEnd] forKey:@"end"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		[self Synchronize_data];
	}
}


-(void)viewWillAppear:(BOOL)animated
{
		
	self.navigationController.navigationBar.hidden = TRUE;
	
}

-(IBAction)LogOut_Btn_clicked:(id)sender
{
	
	//[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"OnOff"];
	[appDelegateObj Logout];
	
}


-(IBAction)Setting_Btn_clicked:(id)sender
{
	
	int val = [[[NSUserDefaults standardUserDefaults]valueForKey:@"OnOff"] intValue];
	
	[SettingView showAlert:val delegate:self];
}


-(IBAction)Product_Btn_Clicked:(id)sender
{

	ProductList *ProductListObj;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		ProductListObj = [[ProductList alloc]initWithNibName:@"ProductList_ipad" bundle:nil];
	}else {
		ProductListObj = [[ProductList alloc]initWithNibName:@"ProductList" bundle:nil];
	}
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test1" inManagedObjectContext:[appDelegateObj managedObjectContext]];
    [fetchRequest setEntity:entity];
	//[fetchRequest setFetchLimit:50];
	[fetchRequest setFetchBatchSize:10];

	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Long_Name" ascending:YES]; 
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[fetchRequest setSortDescriptors:sortDescriptors];
	[sortDescriptor release];	
    NSError *error;
    NSArray *arr = [[appDelegateObj managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
	
	ProductListObj.CatFlag = 1;
	ProductListObj.product_arr = [arr copy];
	ProductListObj.mailArr = [arr copy];

	arr = nil;
	[arr release];
	[self.navigationController pushViewController:ProductListObj animated:YES];
	[ProductListObj release];
}

-(IBAction)Brand_Btn_Clicked:(id)sender
{
	
	SearchView *SearchViewObj;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		SearchViewObj = [[SearchView alloc]initWithNibName:@"SearchView_ipad" bundle:nil];
	}else {
		SearchViewObj = [[SearchView alloc]initWithNibName:@"SearchView" bundle:nil];
	}
	
	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test1" inManagedObjectContext:[appDelegateObj managedObjectContext]];
    [request setEntity:entity];
	[request setReturnsDistinctResults:YES];
	[request setResultType:NSDictionaryResultType];
	[request setPropertiesToFetch:[NSArray arrayWithObject:@"Brand_Name"]];
	[request setFetchBatchSize:10];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Brand_Name" ascending:YES]; 
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	
    NSError *error;
	
	SearchViewObj.BRAND_ARR = (NSMutableArray*)[[appDelegateObj managedObjectContext] executeFetchRequest:request error:&error];
	SearchViewObj.AllValuesArr = SearchViewObj.BRAND_ARR;
	
	[self.navigationController pushViewController:SearchViewObj animated:YES];
	[SearchViewObj release];
}

-(IBAction)AdvSearch_Btn_Clicked:(id)sender
{
	AdvancedSearch *AdvancedSearchObj;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		AdvancedSearchObj = [[AdvancedSearch alloc]initWithNibName:@"AdvancedSearch_ipad" bundle:nil];
	}else {
		AdvancedSearchObj = [[AdvancedSearch alloc]initWithNibName:@"AdvancedSearch" bundle:nil];
	}
	[self.navigationController pushViewController:AdvancedSearchObj animated:YES];
	[AdvancedSearchObj release];
}


-(void)select_on_off_mode:(int)val
{
	//NSLog(@"%d",val);
	
	[[NSUserDefaults standardUserDefaults]setInteger:val forKey:@"OnOff"];
	[[NSUserDefaults standardUserDefaults]synchronize];
	
	if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"OnOff"] intValue] == 1) 
	{
		BOOL InternetAccessibility = [appDelegateObj checkInternet];
		if (InternetAccessibility==0) 
		{
			[customealert showAlert:@"Alert" message:@"Please connect your device with internet." delegate:self];
		}
		else
		{
			//05-May-11 12:35:51 PM
			
			S_timer = [NSTimer scheduledTimerWithTimeInterval:900 target:self selector:@selector(start) userInfo:nil repeats:YES];
			
			[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"OnOff"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
	}
	else 
	{
				
		[S_timer invalidate];
		
		[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"OnOff"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		//[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"case"];
//		[[NSUserDefaults standardUserDefaults] synchronize];		
		
	}
}


-(void)manageWebService
{
	recordStart = recordStart + 50;
	recordEnd = recordEnd + 50;
	
	[[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",recordStart] forKey:@"start"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",recordEnd] forKey:@"end"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[self Synchronize_data];
}


-(void)Synchronize_data
{	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSString *urlString;
	if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"first"] intValue]==0)
	{
		urlString = [NSString stringWithFormat:@"http://sandbox.fsenet.com/FSEMobileServices/catalog?startRow=%d&endRow=%d&isFse=%@&pyId=%@",recordStart,recordEnd,appDelegateObj.isFse,appDelegateObj.pyId];
	}else {
		urlString = [NSString stringWithFormat:@"http://sandbox.fsenet.com/FSEMobileServices/catalog?startRow=%d&endRow=%d&isFse=%@&pyId=%@&lastSyncDate=%@",recordStart,recordEnd,appDelegateObj.isFse,appDelegateObj.pyId,self.dateStr];
	}
	
	urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
	NSLog(@"%@",urlString);
	
	if(Web_req)
	{
		Web_req = nil;
		[Web_req release];
	}
	
	Web_req =[[ASIHttpParser alloc] initWithRequestWithURL:urlString selSuccess:@selector(Detail:) selError:@selector(OnError) andHandler:self];
	appDelegateObj.objectValue = self;
	
	ResourceLoader *loader = [ResourceLoader sharedResourceLoader];
	self.token = [loader loadOperationWithObject:Web_req forDelegate:self withSelector:@selector(startParsingReq)];
	
	
	[pool release];

}

-(void)Detail:(NSDictionary*)dictionary
{
	
	
	NSMutableArray *arr_temp = [[NSMutableArray alloc]init];
	arr_temp = (NSMutableArray*)dictionary;
	
	if ([arr_temp count]==0)
	{
		if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"first"] intValue]==0) {
			[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"first"];
			[[NSUserDefaults standardUserDefaults] synchronize];
		}
		
		[S_timer invalidate];
		
		//[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"OnOff"];
//		[[NSUserDefaults standardUserDefaults] synchronize];
		
		[[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"case"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		if(Web_req)
		{
			Web_req = nil;
			[Web_req release];
		}
		return;
	}
	
	
	for (int i=0; i < [arr_temp count]; i++) 
	{
		NSString * Calories_Fat = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Calories (Fat)"]];
		NSString * Child_Nutrition_Flag = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Child Nutrition Flag"]];
		NSString * Calories = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Calories"]];
		NSString * Pallet_Hi = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Pallet Hi"]];
		NSString * Total_Diet_Fiber = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Total Diet Fiber"]];
		NSString * Carb_RDI = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Carb % RDI"]];
		NSString * Calcium_RDI = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Calcium RDI"]];
		NSString * Width = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Width"]];
		NSString * Total_Sugar = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Total Sugar"]];
		NSString * Width_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Width UOM"]];
		NSString * Protein = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Protein"]];
		NSString * Storage_Temp_To = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Storage Temp To"]];
		NSString * Storage_Temp_To_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Storage Temp To UOM"]];
		NSString * Vitamin_C_RDI = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Vitamin C % RDI"]];
		NSString * Serving_Suggestion = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Serving Suggestion"]];
		NSString * Height = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Height"]];
		NSString * Cholestrol = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Cholestrol"]];
		NSString * More_Info = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"More Info"]];
		NSString * Trans_Fatty_Acid = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Trans Fatty Acid"]];
		NSString * Total_Diet_Fiber_RDI = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Total Diet Fiber RDI"]];
		NSString * Net_Weight = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Net Weight"]];
		NSString * Cholestrol_RDI = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Cholestrol % RDI"]];
		NSString * Nxt_Lower_Lvl_Pack_Qty_CIR = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Nxt Lower Lvl Pack Qty(CIR)"]];
		NSString * Brand_Owner_GLN = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Brand Owner GLN"]];
		NSString * Long_Name = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Long Name"]];
		NSString * Info_Provider = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Info Provider"]];
		NSString * Gross_Weight = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Gross Weight"]];
		NSString * Sat_Fat_RDI = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Sat Fat RDI"]];
		NSString * Brand_Name = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Brand Name"]];
		NSString * Benefits = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Benefits"]];
		NSString * General_Desc = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"General Desc"]];
		NSString * Net_Content_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Net Content UOM"]];
		NSString * Pallet_Ti = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Pallet Ti"]];
		NSString * GPC_Code = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"GPC Code"]];
		NSString * Ingredients = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Ingredients"]];
		NSString * Iron_RDI = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Iron % RDI"]];
		NSString * Gr_Weight_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Gr Weight UOM"]];
		NSString * Total_Fat = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Total Fat"]];
		NSString * Storage_Temp_From_UOM  = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Storage Temp From UOM"]];
		NSString * Sodium_RDI = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Sodium % RDI"]];
		NSString * Depth = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Depth"]];
		NSString * Manufacturer = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Manufacturer"]];
		NSString * GTIN = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"GTIN"]];
		NSString * GPC_Description = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"GPC Description"]];
		NSString * Avg_Serving = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Avg. Serving"]];
		NSString * Vitamin_A_RDI = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Vitamin A % RDI"]];
		NSString * Carbohydrates = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Carbohydrates"]];
		NSString * Manufacturer_GLN = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Manufacturer GLN"]];
		NSString * Net_Content = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Net Content"]];
		NSString * Shelf_Life = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Shelf Life"]];
		NSString * Brand_Owner = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Brand Owner"]];
		NSString * Volume = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Volume"]];
		NSString * Country_Origin_of_Product = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Country Origin of Product"]];
		NSString * Info_Provider_GLN = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Info Provider GLN"]];
		NSString * Net_Weight_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Net Weight UOM"]];
		NSString * Total_Fat_RDI = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Total Fat % RDI"]];
		NSString * Volume_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Volume UOM"]];
		NSString * Depth_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Depth UOM"]];
		NSString * Sodium = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Sodium"]];
		NSString * Shelf_Life_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Shelf Life UOM"]];
		NSString * Prep_Cooking_Sugg = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Prep & Cooking Sugg."]];
		NSString * Pack_Storage_Info = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Pack & Storage Info"]];
		NSString * Storage_Temp_From = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Storage Temp From"]];
		NSString * Saturated_Fat = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Saturated Fat"]];
		NSString * MPC = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"MPC"]];
		NSString * Height_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Height UOM"]];
		NSString * Kosher = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Kosher"]];
		NSString * GRP_ID = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"GRP_ID"]];
		NSString * PRD_ID = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"PRD_ID"]];
		NSString * TPY_ID = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"TPY_ID"]];
		NSString * Calcium_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Calcium-UOM"]];
		NSString * Calories_Fat_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Calories (Fat)-UOM"]];
		NSString * Calories_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Calories-UOM"]];
		NSString * Carbohydrates_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Carbohydrates-UOM"]];
		NSString * Cholestrol_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Cholestrol-UOM"]];
		NSString * Iron_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Iron-UOM"]];
		NSString * PRD_IMAGE_LINK = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"PRD_IMAGE_LINK"]];
		NSString * Protein_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Protein-UOM"]];
		NSString * Saturated_Fat_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Saturated Fat-UOM"]];
		NSString * Sodium_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Sodium-UOM"]];
		NSString * Total_Diet_Fiber_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Total Diet Fiber-UOM"]];
		NSString * Total_Fat_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Total Fat-UOM"]];
		NSString * Total_Sugar_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Total Sugar-UOM"]];
		NSString * Trans_Fatty_Acid_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Trans Fatty Acid-UOM"]];
		NSString * Vitamin_A_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Vitamin A-UOM"]];
		NSString * Vitamin_C_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Vitamin C-UOM"]];
		NSString * Vitamin_D_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Vitamin D-UOM"]];
		
		NSString * GPCType = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"GPCType"]];
		NSString * MYROWNUM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"MYROWNUM"]];
		NSString * Serving_Size = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Serving Size"]];
		NSString * Serving_Size_UOM = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Serving Size UOM"]];
		NSString * Short_Name = [self setString:[[arr_temp objectAtIndex:i]valueForKey:@"Short Name"]];
		
		
		NSString * Long_Name_First_Char;
		if(![Long_Name isEqualToString:@""])
		{
		 Long_Name_First_Char = [self setString:[[[arr_temp objectAtIndex:i]valueForKey:@"Long Name"] substringToIndex:1]];
		}
		else 
		{
			Long_Name_First_Char = @"";
		}
		
		NSString * Brand_Name_First_Char;
		if(![Brand_Name isEqualToString:@""])
		{
			Brand_Name_First_Char = [self setString:[[[arr_temp objectAtIndex:i]valueForKey:@"Brand Name"] substringToIndex:1]];
		}
		else {
			Brand_Name_First_Char = @"";
		}
		
		Test1 *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Test1" inManagedObjectContext:[appDelegateObj managedObjectContext]];
		
		if(![Calories_Fat isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Calories_Fat floatValue]] forKey:@"Calories_Fat"];
		
		if(![Child_Nutrition_Flag isEqualToString:@""])
		[newManagedObject setValue:Child_Nutrition_Flag forKey:@"Child_Nutrition_Flag"];
		
		if(![Calories isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Calories floatValue]] forKey:@"Calories"];
		
		if(![Pallet_Hi isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Pallet_Hi floatValue]] forKey:@"Pallet_Hi"];
		
		if(![Total_Diet_Fiber isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Total_Diet_Fiber floatValue]] forKey:@"Total_Diet_Fiber"];
		
		if(![Carb_RDI isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Carb_RDI floatValue]] forKey:@"Carb_RDI"];
		
		if(![Calcium_RDI isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Calcium_RDI floatValue]] forKey:@"Calcium_RDI"];
		
		if(![Width isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Width floatValue]] forKey:@"Width"];
		
		if(![Total_Sugar isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Total_Sugar floatValue]] forKey:@"Total_Sugar"];
		
		if(![Width_UOM isEqualToString:@""])
		[newManagedObject setValue:Width_UOM forKey:@"Width_UOM"];
		
		if(![Protein isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Protein floatValue]] forKey:@"Protein"];
		
		if(![Storage_Temp_To isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Storage_Temp_To floatValue]] forKey:@"Storage_Temp_To"];
		
		if(![Storage_Temp_To_UOM isEqualToString:@""])
		[newManagedObject setValue:Storage_Temp_To_UOM forKey:@"Storage_Temp_To_UOM"];
		
		if(![Vitamin_C_RDI isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Vitamin_C_RDI floatValue]] forKey:@"Vitamin_C_RDI"];
		
		if(![Serving_Suggestion isEqualToString:@""])
		[newManagedObject setValue:Serving_Suggestion forKey:@"Serving_Suggestion"];
		
		if(![Height isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Height floatValue]] forKey:@"Height"];
		
		if(![Cholestrol isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Cholestrol floatValue]] forKey:@"Cholestrol"];
		
		if(![More_Info isEqualToString:@""])
		[newManagedObject setValue:More_Info forKey:@"More_Info"];
		
		if(![Trans_Fatty_Acid isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Trans_Fatty_Acid floatValue]] forKey:@"Trans_Fatty_Acid"];
		
		if(![Total_Diet_Fiber_RDI isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Total_Diet_Fiber_RDI floatValue]] forKey:@"Total_Diet_Fiber_RDI"];
		
		if(![Net_Weight isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Net_Weight floatValue]] forKey:@"Net_Weight"];
		
		if(![Cholestrol_RDI isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Cholestrol_RDI floatValue]] forKey:@"Cholestrol_RDI"];
		
		if(![Nxt_Lower_Lvl_Pack_Qty_CIR isEqualToString:@""])
		[newManagedObject setValue:Nxt_Lower_Lvl_Pack_Qty_CIR forKey:@"Nxt_Lower_Lvl_Pack_Qty_CIR"];
		
		if(![Brand_Owner_GLN isEqualToString:@""])
		[newManagedObject setValue:Brand_Owner_GLN forKey:@"Brand_Owner_GLN"];
		
		if(![Long_Name isEqualToString:@""])
		[newManagedObject setValue:Long_Name forKey:@"Long_Name"];
		
		if(![Info_Provider isEqualToString:@""])
		[newManagedObject setValue:Info_Provider forKey:@"Info_Provider"];
		
		if(![Gross_Weight isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Gross_Weight floatValue]] forKey:@"Gross_Weight"];
		
		if(![Sat_Fat_RDI isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Sat_Fat_RDI floatValue]] forKey:@"Sat_Fat_RDI"];
		
		if(![Brand_Name isEqualToString:@""])
		[newManagedObject setValue:Brand_Name forKey:@"Brand_Name"];
		
		if(![Benefits isEqualToString:@""])
		[newManagedObject setValue:Benefits forKey:@"Benefits"];
		
		if(![General_Desc isEqualToString:@""])
		[newManagedObject setValue:General_Desc forKey:@"General_Desc"];
		
		if(![Net_Content_UOM isEqualToString:@""])
		[newManagedObject setValue:Net_Content_UOM forKey:@"Net_Content_UOM"];
		
		if(![Pallet_Ti isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Pallet_Ti floatValue]] forKey:@"Pallet_Ti"];
		
		if(![GPC_Code isEqualToString:@""])
		[newManagedObject setValue:GPC_Code forKey:@"GPC_Code"];
		
		if(![Ingredients isEqualToString:@""])
		[newManagedObject setValue:Ingredients forKey:@"Ingredients"];
		
		if(![Iron_RDI isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Iron_RDI floatValue]] forKey:@"Iron_RDI"];
		
		if(![Gr_Weight_UOM isEqualToString:@""])
		[newManagedObject setValue:Gr_Weight_UOM forKey:@"Gr_Weight_UOM"];
		
		if(![Total_Fat isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Total_Fat floatValue]] forKey:@"Total_Fat"];
		
		if(![Storage_Temp_From_UOM isEqualToString:@""])
		[newManagedObject setValue:Storage_Temp_From_UOM forKey:@"Storage_Temp_From_UOM"];
		
		if(![Sodium_RDI isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Sodium_RDI floatValue]] forKey:@"Sodium_RDI"];
		
		if(![Depth isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Depth floatValue]] forKey:@"Depth"];
		
		if(![Manufacturer isEqualToString:@""])
		[newManagedObject setValue:Manufacturer forKey:@"Manufacturer"];
		
		if(![GTIN isEqualToString:@""])
		[newManagedObject setValue:GTIN forKey:@"GTIN"];
		
		if(![GPC_Description isEqualToString:@""])
		[newManagedObject setValue:GPC_Description forKey:@"GPC_Description"];
		
		if(![Avg_Serving isEqualToString:@""])
		[newManagedObject setValue:Avg_Serving forKey:@"Avg_Serving"];
		
		if(![Vitamin_A_RDI isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Vitamin_A_RDI floatValue]] forKey:@"Vitamin_A_RDI"];
		
		if(![Carbohydrates isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Carbohydrates floatValue]] forKey:@"Carbohydrates"];
		
		if(![Manufacturer_GLN isEqualToString:@""])
		[newManagedObject setValue:Manufacturer_GLN forKey:@"Manufacturer_GLN"];
		
		if(![Net_Content isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Net_Content floatValue]] forKey:@"Net_Content"];
		
		if(![Shelf_Life isEqualToString:@""])
		[newManagedObject setValue:Shelf_Life forKey:@"Shelf_Life"];
		
		if(![Brand_Owner isEqualToString:@""])
		[newManagedObject setValue:Brand_Owner forKey:@"Brand_Owner"];
		
		if(![Volume isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Volume floatValue]] forKey:@"Volume"];
		
		if(![Country_Origin_of_Product isEqualToString:@""])
		[newManagedObject setValue:Country_Origin_of_Product forKey:@"Country_Origin_of_Product"];
		
		if(![Info_Provider_GLN isEqualToString:@""])
		[newManagedObject setValue:Info_Provider_GLN forKey:@"Info_Provider_GLN"];
		
		if(![Net_Weight_UOM isEqualToString:@""])
		[newManagedObject setValue:Net_Weight_UOM forKey:@"Net_Weight_UOM"];
		
		if(![Total_Fat_RDI isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Total_Fat_RDI floatValue]] forKey:@"Total_Fat_RDI"];
		
		if(![Volume_UOM isEqualToString:@""])
		[newManagedObject setValue:Volume_UOM forKey:@"Volume_UOM"];
		
		if(![Depth_UOM isEqualToString:@""])
		[newManagedObject setValue:Depth_UOM forKey:@"Depth_UOM"];
		
		if(![Sodium isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Sodium floatValue]] forKey:@"Sodium"];
		
		if(![Shelf_Life_UOM isEqualToString:@""])
		[newManagedObject setValue:Shelf_Life_UOM forKey:@"Shelf_Life_UOM"];
		
		if(![Prep_Cooking_Sugg isEqualToString:@""])
		[newManagedObject setValue:Prep_Cooking_Sugg forKey:@"Prep_Cooking_Sugg"];
		
		if(![Pack_Storage_Info isEqualToString:@""])
		[newManagedObject setValue:Pack_Storage_Info forKey:@"Pack_Storage_Info"];
		
		if(![Storage_Temp_From isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Storage_Temp_From floatValue]] forKey:@"Storage_Temp_From"];
		
		if(![Saturated_Fat isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Saturated_Fat floatValue]] forKey:@"Saturated_Fat"];
		
		if(![MPC isEqualToString:@""])
		[newManagedObject setValue:MPC forKey:@"MPC"];
		
		if(![Height_UOM isEqualToString:@""])
		[newManagedObject setValue:Height_UOM forKey:@"Height_UOM"];
		
		if(![Kosher isEqualToString:@""])
		[newManagedObject setValue:Kosher forKey:@"Kosher"];
		
		if(![GRP_ID isEqualToString:@""])
		[newManagedObject setValue:GRP_ID forKey:@"GRP_ID"];
		
		if(![PRD_ID isEqualToString:@""])
		[newManagedObject setValue:PRD_ID forKey:@"PRD_ID"];
		
		if(![TPY_ID isEqualToString:@""])
		[newManagedObject setValue:TPY_ID forKey:@"TPY_ID"];
		
		if(![Calcium_UOM isEqualToString:@""])
		[newManagedObject setValue:Calcium_UOM forKey:@"Calcium_UOM"];
		
		if(![Calories_Fat_UOM isEqualToString:@""])
		[newManagedObject setValue:Calories_Fat_UOM forKey:@"Calories_Fat_UOM"];
		
		if(![Calories_UOM isEqualToString:@""])
		[newManagedObject setValue:Calories_UOM forKey:@"Calories_UOM"];
		
		if(![Carbohydrates_UOM isEqualToString:@""])
		[newManagedObject setValue:Carbohydrates_UOM forKey:@"Carbohydrates_UOM"];
		
		if(![Cholestrol_UOM isEqualToString:@""])
		[newManagedObject setValue:Cholestrol_UOM forKey:@"Cholestrol_UOM"];
		
		if(![Iron_UOM isEqualToString:@""])
		[newManagedObject setValue:Iron_UOM forKey:@"Iron_UOM"];
		
		if(![PRD_IMAGE_LINK isEqualToString:@""])
		[newManagedObject setValue:PRD_IMAGE_LINK forKey:@"PRD_IMAGE_LINK"];
		
		if(![Protein_UOM isEqualToString:@""])
		[newManagedObject setValue:Protein_UOM forKey:@"Protein_UOM"];
		
		if(![Saturated_Fat_UOM isEqualToString:@""])
		[newManagedObject setValue:Saturated_Fat_UOM forKey:@"Saturated_Fat_UOM"];
		
		if(![Sodium_UOM isEqualToString:@""])
		[newManagedObject setValue:Sodium_UOM forKey:@"Sodium_UOM"];
		
		if(![Total_Diet_Fiber_UOM isEqualToString:@""])
		[newManagedObject setValue:Total_Diet_Fiber_UOM forKey:@"Total_Diet_Fiber_UOM"];
		
		if(![Total_Fat_UOM isEqualToString:@""])
		[newManagedObject setValue:Total_Fat_UOM forKey:@"Total_Fat_UOM"];
		
		if(![Total_Sugar_UOM isEqualToString:@""])
		[newManagedObject setValue:Total_Sugar_UOM forKey:@"Total_Sugar_UOM"];
		
		if(![Trans_Fatty_Acid_UOM isEqualToString:@""])
		[newManagedObject setValue:Trans_Fatty_Acid_UOM forKey:@"Trans_Fatty_Acid_UOM"];
		
		if(![Vitamin_A_UOM isEqualToString:@""])
		[newManagedObject setValue:Vitamin_A_UOM forKey:@"Vitamin_A_UOM"];
		
		if(![Vitamin_C_UOM isEqualToString:@""])
		[newManagedObject setValue:Vitamin_C_UOM forKey:@"Vitamin_C_UOM"];
		
		if(![Vitamin_D_UOM isEqualToString:@""])
		[newManagedObject setValue:Vitamin_D_UOM forKey:@"Vitamin_D_UOM"];
		
		if(![Long_Name_First_Char isEqualToString:@""])
		[newManagedObject setValue:Long_Name_First_Char forKey:@"Long_Name_First_Char"];
		
		if(![Brand_Name_First_Char isEqualToString:@""])
		[newManagedObject setValue:Brand_Name_First_Char forKey:@"Brand_Name_First_Char"];
		
		if(![GPCType isEqualToString:@""])
		[newManagedObject setValue:GPCType forKey:@"GPCType"];
		
		if(![MYROWNUM isEqualToString:@""])
		[newManagedObject setValue:MYROWNUM forKey:@"MYROWNUM"];
		
		if(![Serving_Size isEqualToString:@""])
		[newManagedObject setValue:[NSNumber numberWithFloat:[Serving_Size floatValue]] forKey:@"Serving_Size"];
		
		if(![Serving_Size_UOM isEqualToString:@""])
		[newManagedObject setValue:Serving_Size_UOM forKey:@"Serving_Size_UOM"];
		
		if(![Short_Name isEqualToString:@""])
		[newManagedObject setValue:Short_Name forKey:@"Short_Name"];
		
		//[dict_temp setObject:@"0" forKey:@"is_select"];Long_Name_First_Char Brand_Name_First_Char
	
		NSError *error = nil;
		if (![[appDelegateObj managedObjectContext] save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
		//[dal insertRecord:dict_temp inTable:@"FSEnet"];
		
		//dict_temp = nil;
		//[dict_temp release];
	}
	
	arr_temp = nil;
	[arr_temp release];
	

	//[self hideHUD];
	
	if(Web_req)
	{
		[self manageWebService];
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


-(NSString*)setString:(id)str
{
	id value = str;
	NSString *myStr = @"";
	if(value != [NSNull null])
		myStr = (NSString *)value;
	
	return  myStr;
}

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
	
	//[dal release];
}


@end
