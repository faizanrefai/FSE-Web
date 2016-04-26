//
//  productMailView.m
//  FSEnet
//
//  Created by apple on 3/28/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import "productMailView.h"


@implementation productMailView

@synthesize VALUE_ARR,valueArray,myTbl,allValArr,CatFlag,brandTxt;

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
	
	self.navigationController.navigationBar.hidden = TRUE;
	select_arr = [[NSMutableArray alloc]init];
	select_arr_name = [[NSMutableArray alloc]init];
	select_dict = [[NSMutableDictionary alloc]init];
	
	indexStr = @"ALL";
	Limit = 50;
	[self reload_tbl_data];
	
	
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
	
	
	UIImageView *topBar = [[UIImageView	alloc] init];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
		topBar.image =[UIImage imageNamed:@"Layer11_ipad.png"];
		topBar.frame = CGRectMake(0, 94, 768, 22);
	}else {
		topBar.image =[UIImage imageNamed:@"Layer11.png"];
		topBar.frame = CGRectMake(0, 44, 320, 11);
	}
	[self.view addSubview:topBar];
	[self showMenu];
	topBar = nil;
	[topBar release];
	

}

#pragma mark -
#pragma mark viewWillAppear

-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBar.hidden = TRUE;	
}

#pragma mark -
#pragma mark reload_tbl_data

-(void)reload_tbl_data
{
	
	[countLbl setText:[NSString stringWithFormat:@"%d",[self.valueArray count]]];
	
	if([self.valueArray count]<50)
	{
		self.VALUE_ARR = self.valueArray;
	}
	else {
		
		if( Limit > [self.valueArray count] )
		{
			Limit = [self.valueArray count];
		}
		
		NSMutableArray *tArr = [[NSMutableArray alloc]init];
		for (int i = 0; i < Limit; i++) {
			[tArr addObject:[self.valueArray objectAtIndex:i]];
		}
		
		if(Limit<[self.valueArray count])
		{
			[tArr addObject:[NSNull null]];	
		}
		
		self.VALUE_ARR = tArr;
		
		if ([self.VALUE_ARR count]==0) {
			noDataLbl.hidden = FALSE;
		}
		else {
			noDataLbl.hidden = TRUE;
		}
		
		tArr = nil;
		[tArr release];
	}
	
	[myTbl reloadData];
}


#pragma mark -
#pragma mark Back

-(IBAction)cancel_btn_clicked
{
	[[NSURLCache sharedURLCache] removeAllCachedResponses];
	
	[UIView animateWithDuration:.3f animations:^{
        self.view.alpha = 0.f;
        self.view.transform = CGAffineTransformMakeScale(.1f, .1f);
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}


#pragma mark -
#pragma mark Send Mail
-(IBAction)mail_btn_clicked
{
	if ([MFMailComposeViewController canSendMail]) 
	{
		MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
		//NSArray *toRecipients = [NSArray arrayWithObject:@"sales@waclighting.com"];
		//[mail setToRecipients:toRecipients];
		//NSMutableData *pdfData = [[NSMutableData alloc]init];
		
		NSString *subName = @"";
		for(NSString *str1 in select_arr_name)
		{
			subName = [subName stringByAppendingString:[NSString stringWithFormat:@"\n%@",str1]];
		}
		
		NSString *msg=@"";
		for(NSString *str in select_arr)
		{
			msg = [msg stringByAppendingString:[NSString stringWithFormat:@"\n%@",str]];
		}
		
		//NSString *pdfstr = @"http://sandbox.fsenet.com/FSEMobileServices/sellSheet?PRD_ID=1717782&TPY_ID=0";
		//NSURL *url = [NSURL URLWithString:pdfstr];
		
		//NSError *error = nil;
		//NSData *pdfData = [NSData dataWithContentsOfURL:url options:NSUncachedRead error:&error];
		//[mail addAttachmentData:pdfData mimeType:@"application/pdf" fileName:@"test.pdf"];
		//[mail setSubject:[NSString stringWithFormat:@"%@",]]
		[mail setSubject:[NSString stringWithFormat:@"%@",subName]];
		[mail setMessageBody:[NSString stringWithString:msg] isHTML:NO];
		[mail setMailComposeDelegate:self];
		[self presentModalViewController:mail animated:YES];
		[mail release];
	}
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[self dismissModalViewControllerAnimated:YES];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.VALUE_ARR count];
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
	return myTbl.rowHeight;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	static NSString *CellNib;
	
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		CellNib = @"MyTableViewCell_ipad_select";
	}
	else {
	    CellNib = @"MyTableViewCell_select";
	}
	
	
	MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellNib owner:self options:nil];
		cell = (MyTableViewCell *)[nib objectAtIndex:0];
		[cell retain];
	}
	
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	
	if (indexPath.row == [self.VALUE_ARR count]-1 && Limit < [self.valueArray count]) {
		Limit = Limit + 50;
		cell.textLabel.text = @"Loading";
		[cell.textLabel setTextAlignment:UITextAlignmentCenter];
		[self performSelector:@selector(reload_tbl_data) withObject:nil afterDelay:0.1];
	}
	else 
	{
		Test1 *product = nil;
		product = [self.VALUE_ARR objectAtIndex:indexPath.row];
		
	
		[cell setThumbnailImage:[NSString stringWithFormat:@"%@",[self setString:product.PRD_IMAGE_LINK]]];
		[cell.myLabel setText:[NSString stringWithFormat:@"%@",[self setString:product.Long_Name]]];
		[cell.myLabel1 setText:[NSString stringWithFormat:@"%@",[self setString:product.MPC]]];
		[cell.myLabel2 setText:[NSString stringWithFormat:@"%@",[self setString:product.GTIN]]];
		
	
	
	}

	
	if ([[select_dict objectForKey:[NSString stringWithFormat:@"%d,%@",indexPath.row,indexStr]] isEqualToString:@"1"]) 
	{
		cell.radioBtn.selected = TRUE;
	}
	else {
		cell.radioBtn.selected = FALSE;
	}

    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	Test1 *product = nil;
	product = [self.VALUE_ARR objectAtIndex:indexPath.row];
	
	NSString *str = [NSString stringWithFormat:@"http://sandbox.fsenet.com/FSEMobileServices/sellSheet?PRD_ID=%@&TPY_ID=%@&GPCType=%@",product.PRD_ID,product.TPY_ID,product.GPCType];
	
	NSString *name = [NSString stringWithFormat:@"%@",product.Long_Name];
	
	if([[select_dict objectForKey:[NSString stringWithFormat:@"%d,%@",indexPath.row,indexStr]] isEqualToString:@"1"])
	{
		[select_arr removeObject:str];
		[select_arr_name removeObject:name];
		[select_dict setObject:@"0" forKey:[NSString stringWithFormat:@"%d,%@",indexPath.row,indexStr]];
		[myTbl reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
	}else {
		[select_arr addObject:str];
		[select_arr_name addObject:name];
		[select_dict setObject:@"1" forKey:[NSString stringWithFormat:@"%d,%@",indexPath.row,indexStr]];
		[myTbl reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
	}
		
	
	
	//[myTbl reloadData];
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
		
		[thumbButton setBackgroundImage:[UIImage imageNamed:@"btnImg.png"] forState:UIControlStateNormal];
		[thumbButton setBackgroundImage:[UIImage imageNamed:@"btnImg2.png"] forState:UIControlStateSelected];
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
	
	indexStr = [tempArray objectAtIndex:[sender intValue]];
	
	NSString *sender1 = [tempArray objectAtIndex:[sender intValue]];
	NSString *sender2 = [tempArray_small objectAtIndex:[sender intValue]];
		
	if ([sender1 isEqualToString:@"ALL"]) {
		self.valueArray = self.allValArr;
	}
	else
	{
		if (CatFlag == 1) 
		{
			self.valueArray = (NSMutableArray*)[self db_search:@"Test1" where:@"Long_Name_First_Char" contains1:sender1 contains2:sender2 withSortField:nil];
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
			NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"(Brand_Name = %@ AND Long_Name_First_Char = %@ OR Long_Name_First_Char = %@)",brandTxt,sender1,sender2];
			[request setPredicate:predicate1];
			NSError *error;
			
			self.valueArray = (NSMutableArray*)[[appDelegateObj managedObjectContext] executeFetchRequest:request error:&error];
			
		}else
		if (CatFlag == 3) 
		{			
			self.valueArray = (NSMutableArray*)[appDelegateObj advance_Search:appDelegateObj.key Cond:appDelegateObj.condition val1:appDelegateObj.value1 val2:appDelegateObj.value2 Char1:sender1 Char2:sender2];
		}
	}
	
	Limit = 50;
	[myTbl setContentOffset:CGPointMake(0, 0) animated:NO];
	[self reload_tbl_data];
	[self hideHUD];
}


-(NSArray *) db_search: (NSString *) table where: (NSString*) fieldKey contains1: (NSString*) value1 contains2: (NSString*) value2 withSortField: (NSString *) sortField{
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
	
	self.valueArray = nil;
	[self.valueArray release];
	
	self.VALUE_ARR = nil;
	[self.VALUE_ARR release];
	
	select_dict = nil;
	[select_dict release];
	
	select_arr=nil;
	[select_arr release];
	
	tempArray = nil;
	[tempArray release];
	
	thumbScrollView = nil;
	[thumbScrollView release];
	
	select_arr_name = nil;
	[select_arr_name release];
}


@end
