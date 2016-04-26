//
//  AdvancedSearch.m
//  FSEnet
//
//  Created by apple on 3/26/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import "AdvancedSearch.h"


@implementation AdvancedSearch



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
	
	//arr = [[NSMutableArray alloc]initWithObjects:@"Brand Name",@"Brand Owner",@"Calories",@"Calories Fat",@"Carbohydrates",@"Depth",nil];
	
	//arr2 = [[NSMutableArray alloc]initWithObjects:@"is =",@"is > then",@"is < then",@"is null",@"is not null",nil];

	
	typeDict = [[NSMutableDictionary alloc]init];
	[typeDict setValue:@"Calories_Fat" forKey:@"Calories Fat"];
	[typeDict setValue:@"Child_Nutrition_Flag" forKey:@"Child Nutrition Flag"];
	[typeDict setValue:@"Calories" forKey:@"Calories"];
	[typeDict setValue:@"Pallet_Hi" forKey:@"Pallet Hi"];
	[typeDict setValue:@"Total_Diet_Fiber" forKey:@"Total Diet Fiber"];
	[typeDict setValue:@"Carb_RDI" forKey:@"Carb RDI"];
	[typeDict setValue:@"Calcium_RDI" forKey:@"Calcium RDI"];
	[typeDict setValue:@"Width" forKey:@"Width"];
	[typeDict setValue:@"Total_Sugar" forKey:@"Total Sugar"];
	[typeDict setValue:@"Protein" forKey:@"Protein"];
	[typeDict setValue:@"Storage_Temp_To" forKey:@"Storage Temp To"];
	[typeDict setValue:@"Vitamin_C_RDI" forKey:@"Vitamin C RDI"];
	[typeDict setValue:@"Serving_Suggestion" forKey:@"Serving Suggestion"];
	[typeDict setValue:@"Height" forKey:@"Height"];
	[typeDict setValue:@"Cholestrol" forKey:@"Cholestrol"];
	[typeDict setValue:@"More_Info" forKey:@"More Info"];
	[typeDict setValue:@"Trans_Fatty_Acid" forKey:@"Trans Fatty_Acid"];
	[typeDict setValue:@"Total_Diet_Fiber_RDI" forKey:@"Total Diet Fiber RDI"];
	[typeDict setValue:@"Net_Weight" forKey:@"Net Weight"];
	[typeDict setValue:@"Cholestrol_RDI" forKey:@"Cholestrol RDI"];
	[typeDict setValue:@"Nxt_Lower_Lvl_Pack_Qty_CIR" forKey:@"Nxt Lower Lvl Pack Qty CIR"];
	[typeDict setValue:@"Brand_Owner_GLN" forKey:@"Brand Owner GLN"];
	[typeDict setValue:@"Long_Name" forKey:@"Long Name"];
	[typeDict setValue:@"Info_Provider" forKey:@"Info Provider"];
	[typeDict setValue:@"Gross_Weight" forKey:@"Gross Weight"];
	[typeDict setValue:@"Sat_Fat_RDI" forKey:@"Sat Fat RDI"];
	[typeDict setValue:@"Brand_Name" forKey:@"Brand Name"];
	[typeDict setValue:@"Benefits" forKey:@"Benefits"];
	[typeDict setValue:@"General_Desc" forKey:@"General Desc"];
	[typeDict setValue:@"Pallet_Ti" forKey:@"Pallet Ti"];
	[typeDict setValue:@"GPC_Code" forKey:@"GPC Code"];
	[typeDict setValue:@"Ingredients" forKey:@"Ingredients"];
	[typeDict setValue:@"Iron_RDI" forKey:@"Iron RDI"];
	[typeDict setValue:@"Total_Fat" forKey:@"Total Fat"];
	[typeDict setValue:@"Sodium_RDI" forKey:@"Sodium RDI"];
	[typeDict setValue:@"Depth" forKey:@"Depth"];
	[typeDict setValue:@"Manufacturer" forKey:@"Manufacturer"];
	[typeDict setValue:@"GTIN" forKey:@"GTIN"];
	[typeDict setValue:@"GPC_Description" forKey:@"GPC Description"];
	[typeDict setValue:@"Avg_Serving" forKey:@"Avg Serving"];
	[typeDict setValue:@"Vitamin_A_RDI" forKey:@"Vitamin A RDI"];
	[typeDict setValue:@"Carbohydrates" forKey:@"Carbohydrates"];
	[typeDict setValue:@"Manufacturer_GLN" forKey:@"Manufacturer GLN"];
	[typeDict setValue:@"Net_Content" forKey:@"Net Content"];
	[typeDict setValue:@"Shelf_Life" forKey:@"Shelf Life"];
	[typeDict setValue:@"Brand_Owner" forKey:@"Brand Owner"];
	[typeDict setValue:@"Volume" forKey:@"Volume"];
	[typeDict setValue:@"Country_Origin_of_Product" forKey:@"Country Origin of Product"];
	[typeDict setValue:@"Info_Provider_GLN" forKey:@"Info Provider GLN"];
	[typeDict setValue:@"Total_Fat_RDI" forKey:@"Total Fat RDI"];
	[typeDict setValue:@"Sodium" forKey:@"Sodium"];
	[typeDict setValue:@"Prep_Cooking_Sugg" forKey:@"Prep Cooking Sugg"];
	[typeDict setValue:@"Pack_Storage_Info" forKey:@"Pack Storage Info"];
	[typeDict setValue:@"Storage_Temp_From" forKey:@"Storage Temp From"];
	[typeDict setValue:@"Saturated_Fat" forKey:@"Saturated Fat"];
	[typeDict setValue:@"MPC" forKey:@"MPC"];
	[typeDict setValue:@"Kosher" forKey:@"Kosher"];
	[typeDict setValue:@"GRP_ID" forKey:@"GRP ID"];
	[typeDict setValue:@"PRD_ID" forKey:@"PRD ID"];
	[typeDict setValue:@"TPY_ID" forKey:@"TPY ID"];
	

	arr = [[NSMutableArray alloc]initWithObjects:@"Avg Serving",@"Benefits",@"Brand Name",@"Brand Owner",@"Brand Owner GLN",@"Calories",@"Calories Fat",@"Carbohydrates",@"Carb RDI",@"Calcium RDI",@"Child Nutrition Flag",@"Cholestrol",@"Cholestrol RDI",@"Country Origin of Product",@"Depth",@"GTIN",@"Gross Weight",@"General Desc",@"GPC Code",@"GPC Description",@"Height",@"Ingredients",@"Info Provider",@"Info Provider GLN",@"Iron RDI",@"Kosher",@"Long Name",@"MPC",@"Manufacturer",@"Manufacturer GLN",@"More Info",@"Net Weight",@"Net Content",@"Nxt Lower Lvl Pack Qty CIR",@"Pallet Hi",@"Pallet Ti",@"Protein",@"Prep Cooking Sugg",@"Pack Storage Info",@"Saturated Fat",@"Sat Fat RDI",@"Serving Suggestion",@"Shelf Life",@"Sodium",@"Sodium RDI",@"Storage Temp To",@"Storage Temp From",@"Total Diet Fiber",@"Total Diet Fiber RDI",@"Trans Fatty_Acid",@"Total Fat",@"Total Fat RDI",@"Total Sugar",@"Volume",@"Vitamin A RDI",@"Vitamin C RDI",@"Width",nil];
	
	criteDict = [[NSMutableDictionary alloc]init];
	[criteDict setObject:@">" forKey:@"greater than"];
	[criteDict setValue:@"=[cd]" forKey:@"equals(disregard case)"];
	[criteDict setValue:@"!=[cd]" forKey:@"not equals(disregard case)"];
	[criteDict setValue:@"CONTAINS[cd]" forKey:@"contains"];
	[criteDict setValue:@"BEGINSWITH[cd]" forKey:@"starts with"];
	[criteDict setValue:@"ENDSWITH[cd]" forKey:@"ends with"];
	[criteDict setValue:@"contains[cd]" forKey:@"does not contain"];
	[criteDict setValue:@"beginswith[cd]" forKey:@"does not start with"];
	[criteDict setValue:@"endswith[cd]" forKey:@"does not end with"];
	[criteDict setValue:@"=" forKey:@"equals"];
	[criteDict setValue:@"!=" forKey:@"not equal"];
	[criteDict setValue:@"<" forKey:@"less than"];
	[criteDict setValue:@"<=" forKey:@"less than or equal to"];
	[criteDict setValue:@">=" forKey:@"greater than or equal to"];
	[criteDict setValue:@"between" forKey:@"between"];
	[criteDict setValue:@"=" forKey:@"is null"];
	[criteDict setValue:@"!=" forKey:@"is not null"];
	[criteDict setValue:@"MATCHES" forKey:@"matches other field"];
	[criteDict setValue:@"matches" forKey:@"differs from field"];
	[criteDict setValue:@">" forKey:@"greater than field"];
	[criteDict setValue:@"<" forKey:@"less than field"];
	[criteDict setValue:@">=" forKey:@"greater than or equal to field"];
	[criteDict setValue:@"<=" forKey:@"less than or equal to field"];
	
	arr2 = [[NSMutableArray alloc]init];
	[arr2 addObject:@"greater than"];
	[arr2 addObject:@"equals(disregard case)"];
	[arr2 addObject:@"not equals(disregard case)"];
	[arr2 addObject:@"contains"];
	[arr2 addObject:@"starts with"];
	[arr2 addObject:@"ends with"];
	[arr2 addObject:@"does not contain"];
	[arr2 addObject:@"does not start with"];
	[arr2 addObject:@"does not end with"];
	[arr2 addObject:@"equals"];
	[arr2 addObject:@"not equal"];
	[arr2 addObject:@"less than"];
	[arr2 addObject:@"less than or equal to"];
	[arr2 addObject:@"greater than or equal to"];
	[arr2 addObject:@"between"];
	[arr2 addObject:@"is null"];
	[arr2 addObject:@"is not null"];
	[arr2 addObject:@"matches other field"];
	[arr2 addObject:@"differs from field"];
	[arr2 addObject:@"greater than field"];
	[arr2 addObject:@"less than field"];
	[arr2 addObject:@"greater than or equal to field"];
	[arr2 addObject:@"less than or equal to field"];

	singleTxtView.hidden = FALSE;
	multiTxtView.hidden = TRUE;
	diffreView.hidden = TRUE;
	
	appDelegateObj.value1 = @"nil";
	appDelegateObj.value2 = @"";
	appDelegateObj.key = @"";
	appDelegateObj.condition = @"";
	
}


-(void)viewWillAppear:(BOOL)animated
{
	
}

-(IBAction)Back_Btn_CLicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
	
}


-(IBAction)btn_search_clicked:(id)sender
{
	if (![singleTxtView isHidden]) {
		//appDelegateObj.value1 = text_val.text;
		appDelegateObj.value1 = [text_val.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	}
	else if (![multiTxtView isHidden]){
		appDelegateObj.value1 = v1Txt.text;
		appDelegateObj.value2 = v2Txt.text;
		appDelegateObj.value1 = [appDelegateObj.value1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		appDelegateObj.value2 = [appDelegateObj.value2 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	}
	else if (![diffreView isHidden]){
		appDelegateObj.value1 = [typeDict valueForKey:[NSString stringWithFormat:@"%@",differLbl.text]];
	}
	
	
	
	
	//if ([self.value isEqualToString:@""] || [typeLbl.text isEqualToString:@""] || [typeLbl.text isEqualToString:@"Select"] || [criteLbl.text isEqualToString:@"Select"] || [criteLbl.text isEqualToString:@""]) {
//		[customealert showAlert:@"Alert" message:@"Value missing..!!" delegate:self];
//		return;
//	}
	
	
	
	
	ProductList *ProductListObj;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		ProductListObj = [[ProductList alloc]initWithNibName:@"ProductList_ipad" bundle:nil];
	}else {
		ProductListObj = [[ProductList alloc]initWithNibName:@"ProductList" bundle:nil];
	}
	
	ProductListObj.product_arr = (NSMutableArray*)[appDelegateObj advance_Search:appDelegateObj.key Cond:appDelegateObj.condition val1:appDelegateObj.value1 val2:appDelegateObj.value2 Char1:@"" Char2:@""];
	ProductListObj.mailArr = ProductListObj.product_arr;
	ProductListObj.CatFlag = 3;
	if ([ProductListObj.product_arr count]==0) {
		[customealert showAlert:@"Alert" message:@"No products found." delegate:self];
	}else {
		[self.navigationController pushViewController:ProductListObj animated:YES];
	}
	[ProductListObj release];
		
}


-(IBAction)btn_type_clicked:(id)sender
{
	[text_val resignFirstResponder];
	if (!actionSheetType)
	{
		actionSheetType = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
		[actionSheetType setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
		
		CGRect pickerFrame;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			pickerFrame = CGRectMake(0, 40, 768, 300);
		else
			pickerFrame = CGRectMake(0, 40, 320, 200);
		
		pickerViewType = [[UIPickerView alloc] initWithFrame:pickerFrame];
		pickerViewType.showsSelectionIndicator = YES;
		pickerViewType.userInteractionEnabled = TRUE;
		pickerViewType.dataSource = self;
		pickerViewType.delegate = self;
		[actionSheetType addSubview:pickerViewType];
		
		UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
		closeButton.momentary = YES;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			closeButton.frame = CGRectMake(700, 7.0f, 50.0f, 30.0f);
		else
			closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
		
		closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
		closeButton.tintColor = [UIColor blackColor];
		[closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
		[actionSheetType addSubview:closeButton];
		[closeButton release];
		
		CGRect frame;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			frame = CGRectMake(self.view.frame.origin.x, 750, 768.0f,350.0f);
		else
			frame = CGRectMake(self.view.frame.origin.x, 200, 480.0f,300.0f);
		
		[actionSheetType setFrame:frame];
		[self.view addSubview:actionSheetType];
	}
}


-(IBAction)btn_cond_clicked:(id)sender
{
	[text_val resignFirstResponder];
	
	if (!actionSheetCond)
	{
		actionSheetCond = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
		[actionSheetCond setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
		
		CGRect pickerFrame;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			pickerFrame = CGRectMake(0, 40, 768, 300);
		else
			pickerFrame = CGRectMake(0, 40, 320, 200);
		
		pickerViewCond = [[UIPickerView alloc] initWithFrame:pickerFrame];
		pickerViewCond.showsSelectionIndicator = YES;
		pickerViewCond.userInteractionEnabled = TRUE;
		pickerViewCond.dataSource = self;
		pickerViewCond.delegate = self;
		[actionSheetCond addSubview:pickerViewCond];
		
		UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
		closeButton.momentary = YES;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			closeButton.frame = CGRectMake(700, 7.0f, 50.0f, 30.0f);
		else
			closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
		
		closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
		closeButton.tintColor = [UIColor blackColor];
		[closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
		[actionSheetCond addSubview:closeButton];
		[closeButton release];
		
		CGRect frame;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			frame = CGRectMake(self.view.frame.origin.x, 750, 768.0f,350.0f);
		else
			frame = CGRectMake(self.view.frame.origin.x, 200, 480.0f,300.0f);
		
		[actionSheetCond setFrame:frame];
		[self.view addSubview:actionSheetCond];
	}
}

-(IBAction)btn_Differ_clicked:(id)sender
{
	[text_val resignFirstResponder];
	
	if (!actionSheetDiffer)
	{
		actionSheetDiffer = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
		[actionSheetDiffer setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
		
		CGRect pickerFrame;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			pickerFrame = CGRectMake(0, 40, 768, 300);
		else
			pickerFrame = CGRectMake(0, 40, 320, 200);
		
		pickerViewDiffer = [[UIPickerView alloc] initWithFrame:pickerFrame];
		pickerViewDiffer.showsSelectionIndicator = YES;
		pickerViewDiffer.userInteractionEnabled = TRUE;
		pickerViewDiffer.dataSource = self;
		pickerViewDiffer.delegate = self;
		[actionSheetDiffer addSubview:pickerViewDiffer];
		
		UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Close"]];
		closeButton.momentary = YES;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			closeButton.frame = CGRectMake(700, 7.0f, 50.0f, 30.0f);
		else
			closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
		
		closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
		closeButton.tintColor = [UIColor blackColor];
		[closeButton addTarget:self action:@selector(dismissActionSheet) forControlEvents:UIControlEventValueChanged];
		[actionSheetDiffer addSubview:closeButton];
		[closeButton release];
		
		CGRect frame;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			frame = CGRectMake(self.view.frame.origin.x, 750, 768.0f,350.0f);
		else
			frame = CGRectMake(self.view.frame.origin.x, 200, 480.0f,300.0f);
		
		[actionSheetDiffer setFrame:frame];
		[self.view addSubview:actionSheetDiffer];
	}
}

-(void)dismissActionSheet
{	
	actionSheetType.hidden = TRUE;
    [actionSheetType release];
    actionSheetType=nil;
	
	actionSheetCond.hidden = TRUE;
    [actionSheetCond release];
    actionSheetCond=nil;
	
	actionSheetDiffer.hidden = TRUE;
    [actionSheetDiffer release];
    actionSheetDiffer=nil;
	
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView == pickerViewType || pickerViewCond || actionSheetDiffer) {
        return 1;
    }
	
	return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == pickerViewType)
    {
		appDelegateObj.key = [NSString stringWithFormat:@"%@",[typeDict valueForKey:[NSString stringWithFormat:@"%@",[arr objectAtIndex:row]]]];
		
		[typeLbl setText:[arr objectAtIndex:row]];
    }
	
	if (pickerView == pickerViewCond)
    {
		
		[criteLbl setText:[arr2 objectAtIndex:row]];
		
		NSString *cStr = [arr2 objectAtIndex:row];
		appDelegateObj.condition = [NSString stringWithFormat:@"%@",[criteDict valueForKey:[NSString stringWithFormat:@"%@",criteLbl.text]]];
		
		if ([cStr isEqualToString:@"between"]) {
			singleTxtView.hidden = TRUE;
			multiTxtView.hidden = FALSE;
			diffreView.hidden = TRUE;
		}else
		if ([cStr isEqualToString:@"is null"]) {
			appDelegateObj.value1 = [NSString stringWithFormat:@"nil"];
			appDelegateObj.value2 = @"";
			singleTxtView.hidden = TRUE;
			multiTxtView.hidden = TRUE;
			diffreView.hidden = TRUE;
		}
		else
		if ([cStr isEqualToString:@"is not null"]) {
			appDelegateObj.value1 = @"nil";
			appDelegateObj.value2 = @"";
			singleTxtView.hidden = TRUE;
			multiTxtView.hidden = TRUE;
			diffreView.hidden = TRUE;
		}
		else
		if([cStr isEqualToString:@"matches other field"] || [cStr isEqualToString:@"differs from field"])
		{
			appDelegateObj.value1 = @"nil";
			appDelegateObj.value2 = @"";
			singleTxtView.hidden = TRUE;
			multiTxtView.hidden = TRUE;
			diffreView.hidden = FALSE;
		}
		else
		{
			singleTxtView.hidden = FALSE;
			multiTxtView.hidden = TRUE;
			diffreView.hidden = TRUE;
		}
    }
	
	if (pickerView == pickerViewDiffer)
    {
		//appDelegateObj.differStr = [NSString stringWithFormat:@"%@",[typeDict valueForKey:[NSString stringWithFormat:@"%@",[[arr objectAtIndex:0] objectAtIndex:row]]]];
		
		[differLbl setText:[arr objectAtIndex:row]];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

{
    if(pickerView == pickerViewType)
    {
        if (component==0)
        {
            return [arr count];
        }
    }
	if(pickerView == pickerViewCond)
    {
        if (component==0)
        {
            return [arr2 count];
        }
    }
	if(pickerView == pickerViewDiffer)
    {
        if (component==0)
        {
            return [arr count];
        }
    }
	return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

{
    if(pickerView == pickerViewType)
    {
        if (component==0)
        {
            return [arr objectAtIndex:row];
        }
    }
	if(pickerView == pickerViewCond)
    {
        if (component==0)
        {
            return [arr2 objectAtIndex:row];
        }
    }
	if(pickerView == pickerViewDiffer)
    {
        if (component==0)
        {
            return [arr objectAtIndex:row];
        }
    }
	return 0;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
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
