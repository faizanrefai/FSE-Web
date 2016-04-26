//
//  SearchView.h
//  FSEnet
//
//  Created by apple on 3/20/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductList.h"
#import "customealert.h"
#import "MBProgressHUD.h"
#import "coredataAppDelegate.h"

@class coredataAppDelegate;

@interface SearchView : UIViewController <UISearchDisplayDelegate, UISearchBarDelegate , UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate>{

	coredataAppDelegate *appDelegateObj;
	
	IBOutlet UITableView *tbl;
	
	IBOutlet UIView *navi_view;
	
	UIImageView *topBar;
	
	UISearchDisplayController	*searchDisplayController;
		
	NSMutableArray *tempArray_small;
	NSMutableArray *tempArray;
	NSMutableArray *BRAND_ARR;
	NSMutableArray *BRAND;
	NSMutableArray *AllValuesArr;
	
	int cxs;
	int a2;
	UIScrollView *thumbScrollView;
	
	MBProgressHUD *HUD;
	
	IBOutlet UILabel *noDataLbl;
	
	IBOutlet UILabel *countLbl;
	
	
}

-(void)showMenu;
-(void)MenuScrollCheck:(UIScrollView*)scrollView;
-(void)MenuScrollCheckPad:(UIScrollView*)scrollView;
-(BOOL)value:(int)value inRange:(NSRange)range;
-(void)menuButtonClicked:(id)sender;
-(void)selectBtnAtIndex:(int)btnTag;

-(void)showHUD;
-(void)hideHUD;

-(IBAction)Back_Btn_CLicked:(id)sender;
-(IBAction)Search_CLicked:(id)sender;


-(NSArray *) db_search2: (NSString *) table where: (NSString*) fieldKey contains1:(NSString*)value1 contains2:(NSString*)value2 withSortField: (NSString *) sortField;
-(NSArray *) db_search: (NSString *) table where: (NSString*) fieldKey contains: (NSString*) value withSortField: (NSString *) sortField;
//-(NSArray *) db_search2: (NSString *) table where: (NSString*) fieldKey contains: (NSString*) value withSortField: (NSString *) sortField;
-(NSArray *) db_search3: (NSString *) table where: (NSString*) fieldKey contains: (NSString*) value withSortField: (NSString *) sortField;

@property (nonatomic, retain) NSMutableArray *AllValuesArr;
@property (nonatomic, retain) NSMutableArray *BRAND;
@property (nonatomic, retain) NSMutableArray *BRAND_ARR;
@property (nonatomic, retain) NSMutableArray *Cat_arr;
@property (nonatomic, retain) UISearchDisplayController	*searchDisplayController;

@end
