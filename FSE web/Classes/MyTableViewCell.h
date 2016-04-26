//
//  MyTableViewCell.h
//  ThreadAndOperation
//
//  Created by Sagar on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface MyTableViewCell : UITableViewCell <EGOImageViewDelegate> {
	UILabel *myLabel;
	UILabel *myLabel1;
	UILabel *myLabel2;
	UIWebView *myImageView;
	
	UIActivityIndicatorView *activity;
	
	UIButton *radioBtn;
	
	EGOImageView *myimageView2;
	
	
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activity;
@property (nonatomic, retain) IBOutlet UIButton *radioBtn;
@property (nonatomic, retain) IBOutlet UILabel *myLabel;
@property (nonatomic, retain) IBOutlet UILabel *myLabel1;
@property (nonatomic, retain) IBOutlet UILabel *myLabel2;
@property (nonatomic, retain) IBOutlet UIWebView *myImageView;


- (void)setThumbnailImage:(NSString *)logoURLString;

@end
