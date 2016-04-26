//
//  ProductList.h
//  FSEnet
//
//  Created by apple on 3/20/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "coredataAppDelegate.h"
#import "Specification.h"
#import "productMailView.h"
#import "Product.h"
#import "MBProgressHUD.h"
#import "MyTableViewCell.h"
#import "EGOCache.h"
#import "Test1.h"


@class coredataAppDelegate;

@interface ProductList : UIViewController <UISearchDisplayDelegate, UISearchBarDelegate , UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate>{
	
	coredataAppDelegate *appDelegateObj;
	MBProgressHUD *HUD;
	
	UISearchDisplayController	*searchDisplayController;
	
	UIImageView *topBar;
	IBOutlet UITableView *tbl;
	IBOutlet UIView *navi_view;
	IBOutlet UIButton *do_mail_btn;
	
	NSMutableArray *product_arr;
	NSMutableArray *PRODUCT_ARR;
	NSMutableArray *PRODUCT;
	NSMutableArray *mailArr;
	NSMutableArray *tempArray;
	NSMutableArray *tempArray_small;
	
	int cxs;
	int a2;
	UIScrollView *thumbScrollView;
	
	int CatFlag;
	NSString *brandName;
	
	int Limit;
	
	IBOutlet UILabel *noDataLbl;
	NSMutableDictionary *dic;
	
	IBOutlet UILabel *countLbl;
}

@property (nonatomic, retain) NSMutableArray *PRODUCT;
@property (nonatomic, retain) NSMutableArray *mailArr;
@property (nonatomic, retain) NSMutableArray *PRODUCT_ARR;
@property (nonatomic, assign) int CatFlag;
@property (nonatomic, retain) NSString *brandName;


-(IBAction)Back_Btn_CLicked:(id)sender;
-(IBAction)Search_CLicked:(id)sender;

-(IBAction)do_mail_btn_clicked:(id)sender;
-(NSString*)setString:(id)str;
-(void)reload_tbl_data;

-(void)showMenu;
-(void)MenuScrollCheck:(UIScrollView*)scrollView;
-(void)MenuScrollCheckPad:(UIScrollView*)scrollView;
-(BOOL)value:(int)value inRange:(NSRange)range;
-(void)menuButtonClicked:(NSString*)sender;
-(void)selectBtnAtIndex:(int)btnTag;

-(void)showHUD;
-(void)hideHUD;

-(NSArray *) db_search: (NSString *) table where: (NSString*) fieldKey contains1: (NSString*)value1 contains2:(NSString*)value2 withSortField: (NSString *) sortField;
//-(NSArray *) db_search: (NSString *) table where: (NSString*) fieldKey contains: (NSString*) value withSortField: (NSString *) sortField;
-(NSArray *) db_search3: (NSString *) table where: (NSString*) fieldKey contains: (NSString*) value withSortField: (NSString *) sortField;

//@property (nonatomic) BOOL catFlag;
//@property (nonatomic, retain) NSString *catStr;

@property (nonatomic, retain) NSMutableArray *product_arr;
@property (nonatomic, retain) UISearchDisplayController	*searchDisplayController;

@end
