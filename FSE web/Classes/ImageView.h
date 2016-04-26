//
//  ImageView.h
//  FSEnet
//
//  Created by apple on 3/20/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "coredataAppDelegate.h"
#import "EGOImageView.h"
#import "EGOCache.h"
#import "Test1.h"
#import <QuartzCore/QuartzCore.h>

@interface ImageView : UIViewController < UIWebViewDelegate , EGOImageViewDelegate , UIScrollViewDelegate>{
	
	coredataAppDelegate *appDelegateObj;
	EGOImageView *myimageView2;
	
	//IBOutlet UIWebView *myWebView;
	IBOutlet UIScrollView *productZoomScroll;
	
	IBOutlet UIImageView *myImgView;
	IBOutlet UILabel *product_name_lbl;
	
	NSMutableArray* valueDict;
	
	IBOutlet UIView *swiprView;
}

@property ( nonatomic , retain )NSMutableArray* valueDict;

-(IBAction)Back_Btn_CLicked:(id)sender;
-(IBAction)Logout_Btn_CLicked:(id)sender;

@end
