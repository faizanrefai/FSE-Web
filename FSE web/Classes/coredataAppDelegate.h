//
//  coredataAppDelegate.h
//  coredata
//
//  Created by apple on 4/10/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Reachability.h"

#import "ProductCategory.h"
#import "customealertprocess.h"

//@class ProductCategory;

@interface coredataAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	
	UITabBarController *tabBarController;
	NSString * product_id;
	NSString * product_name;
	
	//int countNum;
	
	NSMutableArray *valueDetail;
	
	NSString *key;
	NSString *condition;
	NSString *value1;
	NSString *value2;
	
	NSString *isFse;
	NSString *pyId;
	

@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
	
	id objectValue;
}

@property (nonatomic, retain)NSString *isFse;
@property (nonatomic, retain)NSString *pyId;

@property (nonatomic, retain)NSString *key;
@property (nonatomic, retain)NSString *condition;
@property (nonatomic, retain)NSString *value1;
@property (nonatomic, retain)NSString *value2;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSString * product_id;
@property (nonatomic, retain) NSString * product_name;
//@property (nonatomic , assign ) int countNum;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain)NSMutableArray *valueDetail;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic,retain) id objectValue;

-(BOOL)checkInternet;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;
-(void)ConfirmLogout;
-(void)Logout;
-(NSArray*)advance_Search:(NSString*)keyVal Cond:(NSString*)cond val1:(NSString*)val1 val2:(NSString*)val2 Char1:(NSString*)character1 Char2:(NSString*)character2;
@end

