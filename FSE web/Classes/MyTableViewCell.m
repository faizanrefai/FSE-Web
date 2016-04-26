//
//  MyTableViewCell.m
//  ThreadAndOperation
//
//  Created by Sagar on 7/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MyTableViewCell.h"


@implementation MyTableViewCell

@synthesize myLabel,myLabel1,myLabel2,radioBtn;
@synthesize myImageView,activity;


- (void)setThumbnailImage:(NSString *)logoURLString {
	
	//myimageView2.image = nil;
	//if(!myimageView2)
//	{
//		myimageView2 = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"place_img.png"]];
//		myimageView2.frame = CGRectMake(0.0f, 0.0f, 82.0f, 80.0f);
//		myimageView2.delegate = self;
//		//myImageView.layer.cornerRadius = 10.0;
//		//myImageView.layer.borderColor = [UIColor grayColor].CGColor;
//		//myImageView.layer.borderWidth = 1;
//		[myImageView.layer setMasksToBounds:YES];
//		[myImageView addSubview:myimageView2];
//	}
	if (![logoURLString isEqualToString:@""]) {
		NSURL *url = [NSURL URLWithString:logoURLString];
		myImageView.scalesPageToFit = TRUE;
		NSString *htmlString = [NSString stringWithFormat:
								 @"<html>"
								 "<head>"
								 "<script type=\"text/javascript\" >"
								 "function display(img){"
								 "var imgOrigH = document.getElementById('image').offsetHeight;"
								 "var imgOrigW = document.getElementById('image').offsetWidth;"
								 "var bodyH = window.innerHeight;"
								 "var bodyW = window.innerWidth;"
								 "if((imgOrigW/imgOrigH) > (bodyW/bodyH))"
								 "{"
								 "document.getElementById('image').style.width = bodyW + 'px';"
								 "document.getElementById('image').style.top = (bodyH - document.getElementById('image').offsetHeight)/2  + 'px';"
								 "}"
								 "else"
								 "{"
								 "document.getElementById('image').style.height = bodyH + 'px';"
								 "document.getElementById('image').style.marginLeft = (bodyW - document.getElementById('image').offsetWidth)/2  + 'px';"
								 "}"
								 "}"
								 "</script>"                         
								 "</head>"
								 "<body style=\"margin:0;width:100%;height:100%;\" >"
								 "<img id=\"image\" src=\"%@\" onload=\"display()\" style=\"position:relative\" />"
								 "</body>"
								 "</html>",url
								 ];
		
		[myImageView sizeToFit];
		[myImageView loadHTMLString:htmlString baseURL:nil];
		//myimageView2.imageURL = [NSURL URLWithString:logoURLString];
	}
	else {
		NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"noimage" ofType:@"png"]];
		myImageView.scalesPageToFit = TRUE;
		NSString *htmlString = [NSString stringWithFormat:
								@"<html>"
								"<head>"
								"<script type=\"text/javascript\" >"
								"function display(img){"
								"var imgOrigH = document.getElementById('image').offsetHeight;"
								"var imgOrigW = document.getElementById('image').offsetWidth;"
								"var bodyH = window.innerHeight;"
								"var bodyW = window.innerWidth;"
								"if((imgOrigW/imgOrigH) > (bodyW/bodyH))"
								"{"
								"document.getElementById('image').style.width = bodyW + 'px';"
								"document.getElementById('image').style.top = (bodyH - document.getElementById('image').offsetHeight)/2  + 'px';"
								"}"
								"else"
								"{"
								"document.getElementById('image').style.height = bodyH + 'px';"
								"document.getElementById('image').style.marginLeft = (bodyW - document.getElementById('image').offsetWidth)/2  + 'px';"
								"}"
								"}"
								"</script>"                         
								"</head>"
								"<body style=\"margin:0;width:100%;height:100%;\" >"
								"<img id=\"image\" src=\"%@\" onload=\"display()\" style=\"position:relative\" />"
								"</body>"
								"</html>",url
								];
		
		[myImageView sizeToFit];
		[myImageView loadHTMLString:htmlString baseURL:nil];
		//myimageView2.image = [UIImage imageNamed:@"noimage.png"];
	}

}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

	[activity startAnimating];
	
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[activity stopAnimating];
}

- (void)dealloc {
		
	self.myLabel = nil;
	self.myImageView = nil;
	
	
    [super dealloc];
}


@end
