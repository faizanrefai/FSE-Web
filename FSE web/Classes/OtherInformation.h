//
//  OtherInformation.h
//  FSEnet
//
//  Created by apple on 3/20/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coredataAppDelegate.h"
#import "Test1.h"
#import "EGOCache.h"

@interface OtherInformation : UIViewController {

	coredataAppDelegate *appDelegateObj;
	
	IBOutlet UILabel *product_name_lbl;
	
	NSMutableArray *valueArr;
	
	IBOutlet UITableView *myTable;
	NSMutableArray *displayData;
	
	IBOutlet UIImageView *noDataImg;
	
}

@property ( nonatomic , retain ) NSMutableArray *valueArr;

-(IBAction)Back_Btn_CLicked:(id)sender;
-(int)size:(NSString*)string;
-(int)sizeIpad:(NSString*)string;
-(IBAction)Logout_Btn_CLicked:(id)sender;

@end
