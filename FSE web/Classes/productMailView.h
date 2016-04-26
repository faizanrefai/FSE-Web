//
//  productMailView.h
//  FSEnet
//
//  Created by apple on 3/28/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Product.h"
#import "MyTableViewCell.h"
#import "coredataAppDelegate.h"
#import "Test1.h"
#import "MBProgressHUD.h"



@class coredataAppDelegate;

@interface productMailView : UIViewController <MFMailComposeViewControllerDelegate , UIScrollViewDelegate> {

	coredataAppDelegate *appDelegateObj;
	MBProgressHUD *HUD;

	IBOutlet UITableView *myTbl;
	
	NSMutableArray *allValArr;
	NSMutableArray *valueArray;
	NSMutableArray *VALUE_ARR;
	NSMutableArray *select_arr;
	NSMutableArray *select_arr_name;
	NSMutableDictionary *select_dict;
	NSMutableArray *tempArray_small;
	
	
	int Limit;
	
	NSMutableArray *tempArray;
	int cxs;
	int a2;
	UIScrollView *thumbScrollView;
	
	NSString *indexStr;
	
	int CatFlag;
	NSString *brandTxt;
	
	IBOutlet UILabel *countLbl;
	
	IBOutlet UILabel *noDataLbl;
	
}



@property ( nonatomic , assign ) int CatFlag;

@property ( nonatomic , retain ) NSString *brandTxt;
@property ( nonatomic , retain ) NSMutableArray *allValArr;
@property ( nonatomic , retain ) NSMutableArray *valueArray;
@property ( nonatomic , retain ) NSMutableArray *VALUE_ARR;
@property ( nonatomic , retain ) IBOutlet UITableView *myTbl;

-(IBAction)cancel_btn_clicked;
-(IBAction)mail_btn_clicked;
-(NSString*)setString:(id)str;
-(void)reload_tbl_data;

-(void)showMenu;
-(void)MenuScrollCheck:(UIScrollView*)scrollView;
-(void)MenuScrollCheckPad:(UIScrollView*)scrollView;
-(BOOL)value:(int)value inRange:(NSRange)range;
-(void)menuButtonClicked:(id)sender;
-(void)selectBtnAtIndex:(int)btnTag;

-(void)showHUD;
-(void)hideHUD;

-(NSArray *) db_search: (NSString *) table where: (NSString*) fieldKey contains1: (NSString*) value1 contains2: (NSString*) value2 withSortField: (NSString *) sortField;

@end
