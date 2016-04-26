//
//  SearchView.m
//  FSEnet
//
//  Created by apple on 3/20/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import "SearchView.h"


@implementation SearchView

@synthesize searchDisplayController,Cat_arr , BRAND_ARR , BRAND ,AllValuesArr ;


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

#pragma mark -
#pragma mark viewDidLoad

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[countLbl setText:[NSString stringWithFormat:@"%d",[self.BRAND_ARR count]]];
	
	appDelegateObj = (coredataAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	BRAND = [[NSMutableArray alloc]init];
	
	[tbl setContentOffset:CGPointMake(0, 44.f) animated:NO];
	UISearchBar *mySearchBar = [[UISearchBar alloc] init];
	mySearchBar.delegate = self;
	[mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
	[mySearchBar sizeToFit];
	tbl.tableHeaderView = mySearchBar;
	
	searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
	[searchDisplayController setDelegate:self];
	[searchDisplayController setSearchResultsDataSource:self];
	[searchDisplayController setSearchResultsDelegate:self];
	
	tempArray = [[NSMutableArray alloc] initWithObjects:@"",@"ALL",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
	tempArray_small = [[NSMutableArray alloc] initWithObjects:@"",@"ALL",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
	
	CGRect rect;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		
		rect=CGRectMake(0,94 ,768, 60);
	}else {
		rect=CGRectMake(0, 50 ,320, 30);
		
	}
    
	thumbScrollView=[[[UIScrollView alloc]initWithFrame:rect] autorelease];
	
	thumbScrollView.delegate = self;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		[thumbScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"scrollBk_ipad.png"]]];
	}else {
		[thumbScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"scrollBk.png"]]];
	}
	[thumbScrollView setCanCancelContentTouches:NO];
	thumbScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	thumbScrollView.showsHorizontalScrollIndicator=NO;
	thumbScrollView.clipsToBounds = YES;
	thumbScrollView.scrollEnabled = YES;
	thumbScrollView.alwaysBounceHorizontal=NO;
	[thumbScrollView setDecelerationRate:UIScrollViewDecelerationRateFast];
	[self.view addSubview:thumbScrollView];
	thumbScrollView.pagingEnabled=NO;
	[thumbScrollView setClipsToBounds:NO];
	
	
	topBar = [[UIImageView	alloc] init];

	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		topBar.image =[UIImage imageNamed:@"Layer11_ipad.png"];
		topBar.frame = CGRectMake(0, 94, 768, 22);
	}else {
		topBar.image =[UIImage imageNamed:@"Layer11.png"];
		topBar.frame = CGRectMake(0, 44, 320, 11);
	}
	
	[self.view addSubview:topBar];
	[self showMenu];
	
}

#pragma mark -
#pragma mark viewWillAppear

-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.hidden = TRUE;	
}

#pragma mark -
#pragma mark scrollView Methods

-(void)showMenu{
    
	
	int diff;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		cxs = 349;
		diff=70;
	}else {
		cxs = 135;
		diff=50;
	}
	
	for(int j = 1; j < [tempArray count] ;j++)
	{
		UIView *mainView = [[UIView alloc]init];
		UIButton *thumbButton = [[UIButton alloc] init];
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
			thumbButton.frame = CGRectMake(5, 16, 60, 40);
			[thumbButton setBackgroundImage:[UIImage imageNamed:@"btnImg_ipad.png"] forState:UIControlStateNormal];
			[thumbButton setBackgroundImage:[UIImage imageNamed:@"btnImg2_ipad.png"] forState:UIControlStateSelected];
			
		}else {
			thumbButton.frame = CGRectMake(2, 2, 46, 26);
			[thumbButton setBackgroundImage:[UIImage imageNamed:@"btnImg.png"] forState:UIControlStateNormal];
			[thumbButton setBackgroundImage:[UIImage imageNamed:@"btnImg2.png"] forState:UIControlStateSelected];
			
		}
		
		[thumbButton setTitle:[NSString stringWithFormat:@"%@",[tempArray objectAtIndex:j]] forState:UIControlStateNormal];
		//thumbButton.userInteractionEnabled = FALSE;
		[thumbButton setTitleColor:[UIColor colorWithRed:63.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:1.0] forState:UIControlStateNormal];
		[thumbButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
		[mainView addSubview:thumbButton];
		[thumbButton addTarget:self action:@selector(scrollView_Btn_Clicked:) forControlEvents:UIControlEventTouchUpInside];
		thumbButton.titleLabel.textAlignment = UITextAlignmentCenter;
		thumbButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
		[thumbButton setTag:j];
		[thumbButton release];
		
		CGRect rect;
		rect.origin.x = cxs;
		cxs=cxs+diff;
		rect.origin.y = 0;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
			rect.size.height = 50;
			rect.size.width = 70;
		}else {
			rect.size.height = 30;
			rect.size.width =50;
		}
		
		
		//mainView.backgroundColor = [UIColor blueColor];
		mainView.clipsToBounds = NO;
		mainView.frame = rect;
		[mainView setContentMode:UIViewContentModeScaleAspectFill];
		
		[thumbScrollView addSubview:mainView];
		
	}
	int delta;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		delta=349;
	}else {
		delta=135;
	}
	
	[self selectBtnAtIndex:1];
	[thumbScrollView setContentSize:CGSizeMake(cxs+delta, [thumbScrollView bounds].size.height)];
	
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		if (scrollView == thumbScrollView) {
			[self MenuScrollCheckPad:scrollView];
		}
    }
    else {
		if (scrollView == thumbScrollView) {
			[self MenuScrollCheck:scrollView];
			
		}
	}
	
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (!decelerate) {
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
			if (scrollView == thumbScrollView) {
				[self MenuScrollCheckPad:scrollView];
			}
		}else {
			if (scrollView == thumbScrollView) {
				[self MenuScrollCheck:scrollView];
			}		
		}
	}
}
-(void)MenuScrollCheck:(UIScrollView*)scrollView{
	int a =[scrollView contentOffset].x;
	
	if (a < 25) {
		[scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
		[self showHUD];
		[self selectBtnAtIndex:1];
		[self performSelector:@selector(menuButtonClicked:) withObject:[NSString stringWithFormat:@"%d",1] afterDelay:0.5];
		return;
		
	}else
	{
		for (int i=0; i< [tempArray count]; i++) 
		{
			a2 = 	[self value:a inRange:NSMakeRange(25+(50*i), 50)];
			if (a2) 
			{
				[scrollView setContentOffset:CGPointMake(50*(i+1), 0) animated:YES];
				[self showHUD];
				[self selectBtnAtIndex:i+2];
				[self performSelector:@selector(menuButtonClicked:) withObject:[NSString stringWithFormat:@"%d",i+2] afterDelay:0.5];
				return;
			}
			
		}
	}
}

-(void)MenuScrollCheckPad:(UIScrollView*)scrollView{
	int a =[scrollView contentOffset].x;
	
	if (a < 35) {
		[scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
		[self showHUD];
		[self selectBtnAtIndex:1];
		[self performSelector:@selector(menuButtonClicked:) withObject:[NSString stringWithFormat:@"%d",1] afterDelay:0.5];
		return;
		
	}else
	{
		for (int i=0; i< [tempArray count]; i++) 
		{
			a2 = 	[self value:a inRange:NSMakeRange(35+(70*i), 70)];
			if (a2) 
			{
				[scrollView setContentOffset:CGPointMake(70*(i+1), 0) animated:YES];
				[self showHUD];
				[self selectBtnAtIndex:i+2];
				[self performSelector:@selector(menuButtonClicked:) withObject:[NSString stringWithFormat:@"%d",i+2] afterDelay:0.5];
				return;
			}
			
		}
	}
}

-(BOOL)value:(int)value inRange:(NSRange)range{
	
	if ((range.location < value)  && ((range.location+range.length) > value)) {
		return YES;
	}
	
	return NO;
}

-(void)scrollView_Btn_Clicked:(id)sender
{
	[self showHUD];
	UIButton *btn = (UIButton*)sender;
	int q = btn.tag;
	
	if(q == 1)
	{
		[thumbScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
	}
	else {
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
			[thumbScrollView setContentOffset:CGPointMake(70*(q-1), 0) animated:YES];
		}else {
			[thumbScrollView setContentOffset:CGPointMake(50*(q-1), 0) animated:YES];
		}
	}
	[self selectBtnAtIndex:q];
	[self performSelector:@selector(menuButtonClicked:) withObject:[NSString stringWithFormat:@"%d",q] afterDelay:0.5];
	
}

-(void)selectBtnAtIndex:(int)btnTag{
	for (int i=1; i<28; i++) {
		UIButton *btn = (UIButton*)[thumbScrollView viewWithTag:i];
		[btn setSelected:NO];
	}
	
	UIButton *btn = (UIButton*)[thumbScrollView viewWithTag:btnTag];
	[btn setSelected:YES];
	
}

-(void)menuButtonClicked:(NSString*)sender{
	
	NSString *sender1 = [tempArray objectAtIndex:[sender intValue]];
	NSString *sender2 = [tempArray_small objectAtIndex:[sender intValue]];
	
	if ([sender1 isEqualToString:@"ALL"]) {
		self.BRAND_ARR = self.AllValuesArr;		
	}
	else {
		self.BRAND_ARR = (NSMutableArray*)[self db_search2:@"Test1" where:@"Brand_Name_First_Char" contains1:sender1 contains2:sender2 withSortField:nil];
	}
	
	if ([self.BRAND_ARR count]==0) {
		noDataLbl.hidden = FALSE;
	}
	else {
		noDataLbl.hidden = TRUE;
	}
	
	[countLbl setText:[NSString stringWithFormat:@"%d",[self.BRAND_ARR count]]];
	
	[tbl setContentOffset:CGPointMake(0, 44.f) animated:NO];
	[self hideHUD];
	[tbl reloadData];
	
}


-(NSArray *) db_search2: (NSString *) table where: (NSString*) fieldKey contains1:(NSString*)value1 contains2:(NSString*)value2 withSortField: (NSString *) sortField{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test1" inManagedObjectContext:[appDelegateObj managedObjectContext]];
    [request setEntity:entity];
	[request setFetchBatchSize:10];
	[request setReturnsDistinctResults:YES];
	[request setResultType:NSDictionaryResultType];
	[request setPropertiesToFetch:[NSArray arrayWithObject:@"Brand_Name"]];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Brand_Name" ascending:YES]; 
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	
	if (fieldKey != nil){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(Brand_Name_First_Char = %@ OR Brand_Name_First_Char = %@)",value1,value2];
        [request setPredicate:predicate];
    }
	
    NSError *error;
	NSArray *arr = [[appDelegateObj managedObjectContext] executeFetchRequest:request error:&error];
	return arr;
}

#pragma mark -
#pragma mark Back

-(IBAction)Back_Btn_CLicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
	
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
		
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return  [BRAND count];
    }
	else
	{
        return  [self.BRAND_ARR count];
    }
}




// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    
		UIImageView *img_cell_bk;
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
			img_cell_bk = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellBg_ipad.png"]];
		}else {
			img_cell_bk = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellBg.png"]];
		}
		
		
		[cell.contentView addSubview:img_cell_bk];
		[img_cell_bk setContentMode:UIViewContentModeScaleAspectFill];
		[img_cell_bk release];
		
	}
	
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	//Test1 *product = nil;
	NSString *myStr;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
		myStr = [[BRAND objectAtIndex:indexPath.row] valueForKey:@"Brand_Name"];
	}
	else
	{
		myStr = [[self.BRAND_ARR objectAtIndex:indexPath.row] valueForKey:@"Brand_Name"];
	}

	
	
	//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.text = [NSString stringWithFormat:@"%@",myStr];
	[cell.textLabel setTextColor:[UIColor colorWithRed:84.0/255.0 green:84.0/255.0 blue:84.0/255.0 alpha:1.0]];
	return cell;
}



#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *catStr;
		if (tableView == self.searchDisplayController.searchResultsTableView)
		{
			catStr = [[BRAND objectAtIndex:indexPath.row] valueForKey:@"Brand_Name"];
		}
		else
		{
			catStr = [[self.BRAND_ARR objectAtIndex:indexPath.row] valueForKey:@"Brand_Name"];
			
		}
	
	ProductList *ProductListObj;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		ProductListObj = [[ProductList alloc]initWithNibName:@"ProductList_ipad" bundle:nil];
	}else {
		ProductListObj = [[ProductList alloc]initWithNibName:@"ProductList" bundle:nil];
	}
		
		ProductListObj.CatFlag = 2;
		ProductListObj.brandName = catStr;
		ProductListObj.product_arr = (NSMutableArray*)[self db_search:@"Test1" where:@"Brand_Name" contains:catStr withSortField:nil];
		ProductListObj.mailArr = ProductListObj.product_arr;
		if ([ProductListObj.product_arr count]==0) {
			[customealert showAlert:@"Alert" message:@"No product is present for the sellected brand." delegate:self];
		}else {
			[self.navigationController pushViewController:ProductListObj animated:YES];
		}

	[ProductListObj release];
}


-(NSArray *) db_search: (NSString *) table where: (NSString*) fieldKey contains: (NSString*) value withSortField: (NSString *) sortField{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test1" inManagedObjectContext:[appDelegateObj managedObjectContext]];
    [request setEntity:entity];
	[request setFetchBatchSize:10];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Long_Name" ascending:YES]; 
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	if (fieldKey != nil){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K = %@)",fieldKey,value];
        [request setPredicate:predicate];
    }
	
    NSError *error;
	
	NSArray *arr = [[appDelegateObj managedObjectContext] executeFetchRequest:request error:&error];
	return arr;
	
	
}

#pragma mark -
#pragma mark SearchView Methods

-(IBAction)Search_CLicked:(id)sender
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		[UIView animateWithDuration:.3f  animations:^{
			thumbScrollView.frame = CGRectMake(0, -94, 768, 60);
			tbl.frame = CGRectMake(0, 0, 768, 1004);
			topBar.frame = CGRectMake(0, -94, 768, 22);
			navi_view.frame = CGRectMake(0, -144, 768, 94);
		}];
	}else {
		[UIView animateWithDuration:.3f  animations:^{
			thumbScrollView.frame = CGRectMake(0, -50, 320, 30);
			topBar.frame = CGRectMake(0, -44, 320, 11);
			navi_view.frame = CGRectMake(0, -80, 320, 44);
			tbl.frame = CGRectMake(0, 0, 320, 460);
		}];
	}
	[self.view bringSubviewToFront:tbl];
	[tbl scrollRectToVisible:[[tbl tableHeaderView] bounds] animated:NO];
	[searchDisplayController setActive:YES animated:YES];
}

- (void)filterContentForSearchText:(NSString*)searchText{

	self.BRAND = (NSMutableArray*)[self db_search3:@"Test1" where:@"Brand_Name" contains:searchText withSortField:nil];
}

-(NSArray *) db_search3: (NSString *) table where: (NSString*) fieldKey contains: (NSString*) value withSortField: (NSString *) sortField{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test1" inManagedObjectContext:[appDelegateObj managedObjectContext]];
    [request setEntity:entity];
	[request setFetchBatchSize:10];
	[request setReturnsDistinctResults:YES];
	[request setResultType:NSDictionaryResultType];
	[request setPropertiesToFetch:[NSArray arrayWithObject:@"Brand_Name"]];
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:fieldKey ascending:YES]; 
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	if (fieldKey != nil){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K contains[cd] %@)",fieldKey,value];
        [request setPredicate:predicate];
    }
	
    NSError *error;
	
	NSArray *arr = [[appDelegateObj managedObjectContext] executeFetchRequest:request error:&error];
	return arr;
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (void) searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		[UIView animateWithDuration:.3f  animations:^{
			thumbScrollView.frame = CGRectMake(0, -94, 768, 60);
			tbl.frame = CGRectMake(0, 0, 768, 1004);
			topBar.frame = CGRectMake(0, -94, 768, 22);
			navi_view.frame = CGRectMake(0, -144, 768, 94);
		}];
	}else {
		[UIView animateWithDuration:.3f  animations:^{
			thumbScrollView.frame = CGRectMake(0, -50, 320, 30);
			topBar.frame = CGRectMake(0, -44, 320, 11);
			navi_view.frame = CGRectMake(0, -80, 320, 44);
			tbl.frame = CGRectMake(0, 0, 320, 460);
		}];
	}
	[self.view bringSubviewToFront:tbl];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContentForSearchText:searchString];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]];
    return YES;
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller{
	[self.searchDisplayController.searchResultsTableView setDelegate:self];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
	[tbl setContentOffset:CGPointMake(0, 44.f) animated:NO];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		[UIView animateWithDuration:.3f  animations:^{
			tbl.frame = CGRectMake(0, 154, 768, 841);
			thumbScrollView.frame = CGRectMake(0, 94, 768, 60);
			topBar.frame = CGRectMake(0, 94, 768, 22);
			navi_view.frame = CGRectMake(0, 0, 768, 94);
		}];
	}else {
		[UIView animateWithDuration:.3f  animations:^{
			thumbScrollView.frame = CGRectMake(0, 50, 320, 30);
			topBar.frame = CGRectMake(0, 44, 320, 11);
			navi_view.frame = CGRectMake(0, 0, 320, 44);
			tbl.frame = CGRectMake(0, 80, 320, 376);
		}];
	}
	[self.view bringSubviewToFront:tbl];
}

#pragma mark -
#pragma mark HUD

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

#pragma mark -

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
	
	tempArray=nil;
	[tempArray release];
	
	BRAND_ARR=nil;
	[BRAND_ARR release];
	
	BRAND=nil;
	[BRAND release];
	
	AllValuesArr=nil;
	[AllValuesArr release];
	
	thumbScrollView=nil;
	[thumbScrollView release];
	
	topBar = nil;
	[topBar release];
}


@end
