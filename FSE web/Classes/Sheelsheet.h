//
//  Sheelsheet.h
//  FSEnet
//
//  Created by apple on 4/10/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coredataAppDelegate.h"
#import "Test1.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "MBProgressHUD.h"
#import "EGOCache.h"

@interface Sheelsheet : UIViewController <UIWebViewDelegate , MFMailComposeViewControllerDelegate>{
	
	coredataAppDelegate *appDelegateObj;

	IBOutlet UIWebView *myWebView;
	IBOutlet UILabel *product_name_lbl;
	
	NSMutableArray* valueDict;
	
	NSString *Pdfstr;
	
	IBOutlet UIActivityIndicatorView *act;
	
	MBProgressHUD *HUD;
	
	IBOutlet UIButton *PdfMailBtn;
	
}

@property ( nonatomic , retain )NSMutableArray* valueDict;

-(IBAction)Back_Btn_CLicked:(id)sender;
-(IBAction)Logout_Btn_CLicked:(id)sender;
-(IBAction)mail_btn_clicked;

-(void)showHUD;
-(void)hideHUD;

@end
