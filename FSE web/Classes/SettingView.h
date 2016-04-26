//
//  SettingView.h
//  FSEnet
//
//  Created by apple on 3/20/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayView.h"

@protocol SettingDelegate <NSObject>
@optional

-(void)select_on_off_mode:(int)val;

@end


@interface SettingView : OverlayView {

	int onAndoff;
	
	IBOutlet UIButton *on_btn;
	IBOutlet UIButton *off_btn;
	
	id<SettingDelegate>_userDelegate;

}

@property( nonatomic )int onAndoff;
@property(nonatomic, assign)id<SettingDelegate>_userDelegate;

+(void)showAlert:(int)OnOff delegate:(id)sender;
-(IBAction)onAndoff_btn_clicked:(id)sender;

@end
