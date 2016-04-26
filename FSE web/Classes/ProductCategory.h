//
//  ProductCategory.h
//  FSEnet
//
//  Created by apple on 3/19/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductList.h"
#import "SearchView.h"
#import "SettingView.h"
#import "AdvancedSearch.h"
#import "DAL.h"
#import "ASIHttpParser.h"
#import "MBProgressHUD.h"
#import "coredataAppDelegate.h"
#import "Test1.h"

#import "ResourceLoader.h"
#import "ResourceToken.h"


@class coredataAppDelegate;

@interface ProductCategory : UIViewController <SettingDelegate>{
	
	//IBOutlet UITableView *cat_tbl;
	
	coredataAppDelegate *appDelegateObj;
	ASIHttpParser *Web_req;
	MBProgressHUD *HUD;
	
	NSString *databasePath;
	
	int recordStart;
	int recordEnd;
	
	NSString *dateStr;
	
	NSString *syncCount;
	
	NSManagedObjectContext *managedObjectContext;
	
	NSTimer *S_timer;
	
	id<ResourceToken> token;
	
}

@property (nonatomic, retain) id<ResourceToken> token;

@property (nonatomic)int recordStart;
@property (nonatomic)int recordEnd;

@property (nonatomic, retain) NSString *dateStr;
@property (nonatomic, retain)ASIHttpParser *Web_req;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


- (void) deleteAllObjects: (NSString *) entityDescription;


-(void)showHUD;
-(void)hideHUD;

-(IBAction)Product_Btn_Clicked:(id)sender;
-(IBAction)Brand_Btn_Clicked:(id)sender;
-(IBAction)AdvSearch_Btn_Clicked:(id)sender;

-(IBAction)LogOut_Btn_clicked:(id)sender;
-(IBAction)Setting_Btn_clicked:(id)sender;

-(NSString*)setString:(id)str;
-(void)Synchronize_data;

@end
