//
//  Specification.h
//  FSEnet
//
//  Created by apple on 3/20/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coredataAppDelegate.h"
#import "Test1.h"
#import "EGOCache.h"

@class coredataAppDelegate;

@interface Specification : UIViewController < UIScrollViewDelegate , UITableViewDelegate , UITableViewDataSource>{

	coredataAppDelegate *appDelegateObj;
	
	IBOutlet UITableView *myTable;
	
	IBOutlet UILabel *product_name_lbl;
	
	NSMutableArray *valueArr;
	NSMutableArray *displayData;
	
	IBOutlet UIImageView *noDataImg;
}

@property ( nonatomic , retain ) NSMutableArray *valueArr;

-(IBAction)Back_Btn_CLicked:(id)sender;
-(IBAction)Logout_Btn_CLicked:(id)sender;

@end
