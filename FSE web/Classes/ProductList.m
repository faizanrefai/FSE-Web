//
//  ProductList.m
//  FSEnet
//
//  Created by apple on 3/20/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import "ProductList.h"


@implementation ProductList


@synthesize searchDisplayController,product_arr,PRODUCT_ARR,CatFlag,brandName,mailArr,PRODUCT;

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
	
	appDelegateObj = (coredataAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	[tbl setContentOffset:CGPointMake(0, 44.f) animated:NO];
	
	UISearchBar *mySearchBar = [[UISearchBar alloc] init];
	mySearchBar.delegate = self;
	[mySearchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"Name",@"GTIN",@"Code",nil]];
	[mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
	[mySearchBar sizeToFit];
	tbl.tableHeaderView = mySearchBar;
	
	searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
	[searchDisplayController setDelegate:self];
	[searchDisplayController setSearchResultsDataSource:self];
	[searchDisplayController setSearchResultsDelegate:self];
	
	tempArray = [[NSMutableArray alloc] initWithObjects:@"",@"ALL",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
	tempArray_small = [[NSMutableArray alloc] initWithObjects:@"",@"ALL",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
	
	PRODUCT = [[NSMutableArray alloc]init];
	
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
	//topBar = nil;
//	[topBar release];
	
	[self showMenu];
	
}

#pragma mark -
#pragma mark viewWillAppear

-(void)viewWillAppear:(BOOL)animated
{
	tbl.tag = 0;
	self.navigationController.navigationBar.hidden = TRUE;
	Limit = 50;
	[self reload_tbl_data];
}



#pragma mark -
#pragma mark scrollView methods

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
		}else {
			rect.size.height = 30;
		}
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
			rect.size.width = 70;
		}else {
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

-(void)selectBtnAtIndex:(int)btnTag{
	for (int i=1; i<28; i++) {
		UIButton *btn = (UIButton*)[thumbScrollView viewWithTag:i];
		[btn setSelected:NO];
	}
	
	UIButton *btn = (UIButton*)[thumbScrollView viewWithTag:btnTag];
	[btn setSelected:YES];
	
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

-(void)menuButtonClicked:(NSString*)sender{
	
	NSString *sender1 = [tempArray objectAtIndex:[sender intValue]];
	NSString *sender2 = [tempArray_small objectAtIndex:[sender intValue]];
	
	if ([sender1 isEqualToString:@"ALL"]) {
		self.product_arr = self.mailArr;
	}
	else
	{
		if (CatFlag == 1) 
		{
			self.product_arr = (NSMutableArray*)[self db_search:@"Test1" where:@"Long_Name_First_Char" contains1:sender1 contains2:sender2 withSortField:nil];
		}else
		if (CatFlag == 2) 
		{
			
			NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
			NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test1" inManagedObjectContext:[appDelegateObj managedObjectContext]];
			[request setEntity:entity];
			[request setFetchBatchSize:10];
			NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Long_Name" ascending:YES]; 
			NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
			[request setSortDescriptors:sortDescriptors];
			[sortDescriptor release];
			NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"(Brand_Name = %@ AND Long_Name_First_Char = %@ OR Long_Name_First_Char = %@)",brandName,sender1,sender2];
			[request setPredicate:predicate1];
			NSError *error;
			
			self.product_arr = (NSMutableArray*)[[appDelegateObj managedObjectContext] executeFetchRequest:request error:&error];
			
		}else
		if (CatFlag == 3) 
		{
			
			self.product_arr = (NSMutableArray*)[appDelegateObj advance_Search:appDelegateObj.key Cond:appDelegateObj.condition val1:appDelegateObj.value1 val2:appDelegateObj.value2 Char1:sender1 Char2:sender2];
			
		}
		
	}
	
	Limit = 50;
	[tbl setContentOffset:CGPointMake(0, 44.f) animated:NO];
	[self reload_tbl_data];
	[self hideHUD];
}


-(NSArray *) db_search: (NSString *) table where: (NSString*) fieldKey contains1:(NSString*)value1 contains2:(NSString*)value2 withSortField: (NSString *)sortField{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test1" inManagedObjectContext:[appDelegateObj managedObjectContext]];
    [request setEntity:entity];
	[request setFetchBatchSize:10];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Long_Name" ascending:YES]; 
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	if (fieldKey != nil){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K = %@ OR %K = %@)",fieldKey,value1,fieldKey,value2];
        [request setPredicate:predicate];
    }
	
    NSError *error;
	
	NSArray *arr = [[appDelegateObj managedObjectContext] executeFetchRequest:request error:&error];
	return arr;
	
	
}


#pragma mark -
#pragma mark reload_tbl_data

-(void)reload_tbl_data
{
	[countLbl setText:[NSString stringWithFormat:@"%d",[self.product_arr count]]];
	
	if([self.product_arr count]<50)
	{
		self.PRODUCT_ARR = self.product_arr;
	}
	else {
		
		if( Limit > [self.product_arr count] )
		{
			Limit = [self.product_arr count];
		}

		NSMutableArray *tArr = [[NSMutableArray alloc]init];
		for (int i = 0; i < Limit; i++) {
			[tArr addObject:[self.product_arr objectAtIndex:i]];
		}
		
		if(Limit<[self.product_arr count])
		{
			[tArr addObject:[NSNull null]];	
		}
		
		self.PRODUCT_ARR = tArr;
		
		tArr = nil;
		[tArr release];
	}
	
	if ([self.PRODUCT_ARR count]==0) {
		noDataLbl.hidden = FALSE;
	}
	else {
		noDataLbl.hidden = TRUE;
	}


	[tbl reloadData];
}

#pragma mark -
#pragma mark Back

-(IBAction)Back_Btn_CLicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}



#pragma mark -
#pragma mark Mail

-(IBAction)do_mail_btn_clicked:(id)sender
{
	productMailView *productMailViewObj;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		productMailViewObj = [[productMailView alloc]initWithNibName:@"productMailView_ipad" bundle:nil];
	}else {
		productMailViewObj = [[productMailView alloc]initWithNibName:@"productMailView" bundle:nil];
	}
	productMailViewObj.valueArray = self.mailArr;
	productMailViewObj.allValArr = self.mailArr;
	productMailViewObj.brandTxt = brandName;
	productMailViewObj.CatFlag = self.CatFlag;
	productMailViewObj.view.alpha = 0.f;
	productMailViewObj.view.transform = CGAffineTransformMakeScale(.1f, .1f);
	[UIView animateWithDuration:.3f  animations:^{
		productMailViewObj.view.alpha = 1.f;
		productMailViewObj.view.transform = CGAffineTransformIdentity;
	}];

	[self.view addSubview:productMailViewObj.view];
	
}



#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {	
	if ([self.PRODUCT_ARR count] || [PRODUCT_ARR count] ) {
		
		if (tableView == self.searchDisplayController.searchResultsTableView)
		{
			return [PRODUCT count];
		}
		else
		{
			return [self.PRODUCT_ARR count];
		}
	}
	return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		return 100;
	}else
	{
		return 100;
	}
	
	return tbl.rowHeight;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	static NSString *CellNib;
	
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		CellNib = @"MyTableViewCell_ipad";
	}
	else {
	    CellNib = @"MyTableViewCell";
	}
	
	
	MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
		cell = (MyTableViewCell *)[nib objectAtIndex:0];
		[cell retain];
	}
	
	//[cell.activity startAnimating];
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
		
			
	if (tableView != self.searchDisplayController.searchResultsTableView)
	{
		if (indexPath.row == [self.PRODUCT_ARR count]-1 && Limit < [self.product_arr count]) 
		{
			Limit = Limit + 50;
			cell.textLabel.text = @"Loading";
			[cell.textLabel setTextAlignment:UITextAlignmentCenter];
			[self performSelector:@selector(reload_tbl_data) withObject:nil afterDelay:0.1];
		}
		else 
		{
			Test1 *product = nil;
			if (tableView == self.searchDisplayController.searchResultsTableView)
			{
				product = [PRODUCT objectAtIndex:indexPath.row];
			}
			else
			{
				product = [self.PRODUCT_ARR objectAtIndex:indexPath.row];
			}

			[cell setThumbnailImage:[NSString stringWithFormat:@"%@",[self setString:product.PRD_IMAGE_LINK]]];
			[cell.myLabel setText:[NSString stringWithFormat:@"%@",[self setString:product.Long_Name]]];
			[cell.myLabel1 setText:[NSString stringWithFormat:@"%@",[self setString:product.MPC]]];
			[cell.myLabel2 setText:[NSString stringWithFormat:@"%@",[self setString:product.GTIN]]];
		}
	}
	else 
	{
		Test1 *product = nil;
		if (tableView == self.searchDisplayController.searchResultsTableView)
		{
			product = [PRODUCT objectAtIndex:indexPath.row];
		}
		else
		{
			product = [self.PRODUCT_ARR objectAtIndex:indexPath.row];
		}
		
		[cell setThumbnailImage:[NSString stringWithFormat:@"%@",[self setString:product.PRD_IMAGE_LINK]]];
		[cell.myLabel setText:[NSString stringWithFormat:@"%@",[self setString:product.Long_Name]]];
		[cell.myLabel1 setText:[NSString stringWithFormat:@"%@",[self setString:product.MPC]]];
		[cell.myLabel2 setText:[NSString stringWithFormat:@"%@",[self setString:product.GTIN]]];
		
		
	}

	
    return cell;
}


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	tbl.tag=111;
	[[NSURLCache sharedURLCache] removeAllCachedResponses];
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	
	Test1 *product = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        product = [PRODUCT objectAtIndex:indexPath.row];
    }
	else
	{
        product = [self.PRODUCT_ARR objectAtIndex:indexPath.row];
    }
	
	appDelegateObj.product_name = [NSString stringWithFormat:@"%@",product.Long_Name];
	appDelegateObj.valueDetail = (NSMutableArray*)product;
	
	//[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:1.0];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
	[appDelegateObj.tabBarController setSelectedIndex:0];
	[self.navigationController pushViewController:[appDelegateObj.tabBarController retain] animated:YES];
	[appDelegateObj.tabBarController setSelectedIndex:0];
	//[UIView commitAnimations];
	

}


-(NSString*)setString:(id)str
{
	id value = str;
	NSString *myStr = @"";
	if(value != [NSNull null])
		myStr = (NSString *)value;
	
	return  myStr;
}


#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString *)scope {
	
	[searchText retain];
	if (searchText == nil || [searchText isEqualToString:@""]) {
		return;
	}
	
	NSString *key;
	
	if ([scope isEqualToString:@"Name"]) {
		key = @"Long_Name";
	}
	
	if ([scope isEqualToString:@"GTIN"]) {
		key = @"GTIN";
	}
	
	if ([scope isEqualToString:@"Code"]) {
		key = @"MPC";
	}
	
	
	self.PRODUCT = (NSMutableArray*)[self db_search3:@"Test1" where:key contains:searchText withSortField:nil];
}

-(NSArray *) db_search3: (NSString *) table where: (NSString*) fieldKey contains: (NSString*) value withSortField: (NSString *) sortField{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test1" inManagedObjectContext:[appDelegateObj managedObjectContext]];
    [request setEntity:entity];
	[request setFetchBatchSize:10];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:fieldKey ascending:YES]; 
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor release];
	if (fieldKey != nil)
	{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K contains[cd] %@)",fieldKey,value];
        [request setPredicate:predicate];
    }
	
    NSError *error;
	
	NSArray *arr = [[appDelegateObj managedObjectContext] executeFetchRequest:request error:&error];
	return arr;
	
	
}

#pragma mark -
#pragma mark Search

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
    [self filterContentForSearchText:searchString scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
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
}



/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */
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
	
	[[EGOCache currentCache] clearCache];
	[[NSURLCache sharedURLCache] removeAllCachedResponses];

    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	
	PRODUCT_ARR = nil;
	[PRODUCT_ARR release];
	
	PRODUCT=nil;
	[PRODUCT release];
	
	product_arr=nil;
	[product_arr release];
	
	thumbScrollView=nil;
	[thumbScrollView release];
	
	mailArr = nil;
	[mailArr release];
	
	tempArray=nil;
	[tempArray release];
	
	topBar = nil;
	[topBar release];
}


@end
