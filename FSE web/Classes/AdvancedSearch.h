//
//  AdvancedSearch.h
//  FSEnet
//
//  Created by apple on 3/26/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductList.h"
#import "customealert.h"
//#import "DAL.h"

#import "coredataAppDelegate.h"

@class coredataAppDelegate;

@interface AdvancedSearch : UIViewController <UITextFieldDelegate , UIPickerViewDelegate , UIActionSheetDelegate , UIPickerViewDataSource>{
	
	coredataAppDelegate *appDelegateObj;
	//DAL *dal;
	
	NSMutableArray *arr;
	NSMutableArray *arr2;
	
	NSMutableDictionary *typeDict;
	NSMutableDictionary *criteDict;
	
	IBOutlet UIButton *btn_type;
	IBOutlet UIButton *btn_cond;
	IBOutlet UIButton *btn_differ;
	 
	IBOutlet UILabel *typeLbl;
	IBOutlet UILabel *criteLbl;
	IBOutlet UILabel *differLbl;
	
	IBOutlet UITextField* text_val;
	
	UIActionSheet *actionSheetType;
	UIPickerView *pickerViewType;
	
	UIActionSheet *actionSheetCond;
	UIPickerView *pickerViewCond;
	
	UIActionSheet *actionSheetDiffer;
	UIPickerView *pickerViewDiffer;
	
	
	IBOutlet UIView *singleTxtView;
	IBOutlet UIView *multiTxtView;
	IBOutlet UIView *diffreView;
	
	IBOutlet UITextField *v1Txt;
	IBOutlet UITextField *v2Txt;
	
}

-(IBAction)Back_Btn_CLicked:(id)sender;
-(IBAction)btn_search_clicked:(id)sender;
-(IBAction)btn_type_clicked:(id)sender;
-(IBAction)btn_cond_clicked:(id)sender;
-(IBAction)btn_Differ_clicked:(id)sender;

//-(NSArray*)advance_Search:(NSString*)keyVal Cond:(NSString*)cond val1:(NSString*)val1 val2:(NSString*)val2;

@end
