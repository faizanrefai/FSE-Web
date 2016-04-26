//
//  LoginView.h
//  FSEnet
//
//  Created by apple on 3/17/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "coredataAppDelegate.h"
#import "ASIHttpParser.h";
#import "customealert.h"
#import "ProductCategory.h"
#import <CoreData/CoreData.h>
#import "MBProgressHUD.h"

#import "ResourceLoader.h"
#import "ResourceToken.h"

@class coredataAppDelegate;

@interface LoginView : UIViewController <UITextFieldDelegate>{

	coredataAppDelegate *appDelegateObj;
	ASIHttpParser *Web_req;
	MBProgressHUD *HUD;
	
	NSMutableArray *Login_Arr;
	
	IBOutlet UITextField *U_name_txt;
	IBOutlet UITextField *U_Password_txt;
	
	NSManagedObjectContext *managedObjectContext;
	
	id<ResourceToken> token;
	
}

@property (nonatomic, retain) id<ResourceToken> token;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property( nonatomic , retain ) NSMutableArray *Login_Arr;

-(void)showHUD;
-(void)hideHUD;
-(IBAction)Btn_Login_clicked:(id)sender;
- (void) deleteAllObjects: (NSString *) entityDescription;

@end
