//
//  ASIHttpParser.m
//  WACLighting
//
//  Created by Openxcelltech on 1/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ASIHttpParser.h"
#import "JSON.h"


@implementation ASIHttpParser
@synthesize MainHandler,targetSelectorS,targetSelectorE,myUrl;

-(id)initWithRequestWithURL:(NSString*)urlString selSuccess:(SEL)seletorSucess selError:(SEL)seletorError andHandler:(NSObject*)handler{
	if (self=[super init]) {
		
		self.targetSelectorS = seletorSucess;
		self.targetSelectorE = seletorError;
		self.MainHandler = handler;
		//self.rq=urlReq;
		self.myUrl = urlString;
		//[self startParsingReq:urlString];
	}
	return self;
}

-(void)cancelReq{

	[myrequest cancel];
}
-(NSError*)startParsingReq{

	 myrequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:self.myUrl]];
	[myrequest setDelegate:self];
	[myrequest setNumberOfTimesToRetryOnTimeout:6];
	[myrequest setTimeOutSeconds:60];
	[myrequest startAsynchronous];
	
	return nil;
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSData *responseData = [request responseData];
	
	NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSDictionary *results = [jsonString JSONValue];
	
	[MainHandler performSelector:targetSelectorS withObject:results];


}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	
//	[MainHandler performSelector:targetSelectorE withObject:nil];


}

- (void)dealloc {
    [super dealloc];
}


@end
