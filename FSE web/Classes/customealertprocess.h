//
//  customealert.h
//  popalock
//
//  Created by apple on 12/1/11.
//  Copyright 2011 fgbfg. All rights reserved.
//




#import <UIKit/UIKit.h>
#import "OverlayView.h"


@protocol ProcessDelegate <NSObject>
@optional
-(void)ConfirmLogout;
@end

@interface customealertprocess : OverlayView {
	
	UILabel *lblAlertTitle;
	UILabel *lblAlertMessage;
	id<ProcessDelegate>_processDelegate;
}

@property(nonatomic, retain) IBOutlet UILabel *lblAlertTitle;
@property(nonatomic, retain) IBOutlet UILabel *lblAlertMessage;
@property(nonatomic, assign)id<ProcessDelegate>_processDelegate;

-(IBAction)Logout;
+(void)showAlert:(NSString*)strHeader message:(NSString*)strMessage delegate:(id)sender;


@end