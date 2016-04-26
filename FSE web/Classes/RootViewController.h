//
//  RootViewController.h
//  coredata
//
//  Created by apple on 4/10/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Test1.h"


@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

@private
    //NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext;
	
	NSArray *arrInfo;
	
	
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property ( nonatomic , retain )NSArray *arrInfo;


-(NSArray *) db_search: (NSString *) table where: (NSString*) fieldKey contains: (NSString*) value withSortField: (NSString *) sortField;
	
	
@end
