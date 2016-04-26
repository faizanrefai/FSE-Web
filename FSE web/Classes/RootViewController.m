//
//  RootViewController.m
//  coredata
//
//  Created by apple on 4/10/12.
//  Copyright 2012 fgbfg. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end


@implementation RootViewController

@synthesize managedObjectContext,arrInfo;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
}


// Implement viewWillAppear: to do additional setup before the view is presented.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	//NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test1" inManagedObjectContext:managedObjectContext];
//    [fetchRequest setEntity:entity];
//    NSError *error;
//    self.arrInfo = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    [fetchRequest release];
//	[self.tableView reloadData];
//	
//	
//	NSArray * results = [self db_search:@"Test1" where:@"Brand_Name" contains:@"f" withSortField:nil];
	
}


-(NSArray *) db_search: (NSString *) table where: (NSString*) fieldKey contains: (NSString*) value withSortField: (NSString *) sortField{
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Test1" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
	if (fieldKey != nil){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%K = %@)",fieldKey,value];
        [request setPredicate:predicate];
    }
	
    NSError *error;
	
	NSArray *arr = [managedObjectContext executeFetchRequest:request error:&error];
	return arr;
	
	
}



/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
   // NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    cell.textLabel.text = [[managedObject valueForKey:@"Long_Name"] description];
}


#pragma mark -
#pragma mark Add a new object

- (void)insertNewObject {
    
	for (int i = 0; i < 10; i++) {
		
	Test1 *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Test1" inManagedObjectContext:managedObjectContext];
		
	[newManagedObject setValue:@"a" forKey:@"Calories_Fat"];
	[newManagedObject setValue:@"b" forKey:@"Child_Nutrition_Flag"];
	[newManagedObject setValue:@"c" forKey:@"Calories"];
	[newManagedObject setValue:@"d" forKey:@"Pallet_Hi"];
	[newManagedObject setValue:@"a" forKey:@"Total_Diet_Fiber"];
	[newManagedObject setValue:@"s" forKey:@"Carb_RDI"];
	[newManagedObject setValue:@"a" forKey:@"Calcium_RDI"];
	[newManagedObject setValue:@"s" forKey:@"Width"];
	[newManagedObject setValue:@"a" forKey:@"Total_Sugar"];
	[newManagedObject setValue:@"s" forKey:@"Width_UOM"];
	[newManagedObject setValue:@"a" forKey:@"Protein"];
	[newManagedObject setValue:@"s" forKey:@"Storage_Temp_To"];
	[newManagedObject setValue:@"a" forKey:@"Storage_Temp_To_UOM"];
	[newManagedObject setValue:@"s" forKey:@"Vitamin_C_RDI"];
	[newManagedObject setValue:@"a" forKey:@"Serving_Suggestion"];
	[newManagedObject setValue:@"s" forKey:@"Height"];
	[newManagedObject setValue:@"a" forKey:@"Cholestrol"];
	[newManagedObject setValue:@"s" forKey:@"More_Info"];
	[newManagedObject setValue:@"a" forKey:@"Trans_Fatty_Acid"];
	[newManagedObject setValue:@"sa" forKey:@"Total_Diet_Fiber_RDI"];
	[newManagedObject setValue:@"a" forKey:@"Net_Weight"];
	[newManagedObject setValue:@"s" forKey:@"Cholestrol_RDI"];
	[newManagedObject setValue:@"s" forKey:@"Nxt_Lower_Lvl_Pack_Qty_CIR"];
	[newManagedObject setValue:@"s" forKey:@"Brand_Owner_GLN"];
	[newManagedObject setValue:@"dArShAn" forKey:@"Long_Name"];
	[newManagedObject setValue:@"f" forKey:@"Info_Provider"];
	[newManagedObject setValue:@"g" forKey:@"Gross_Weight"];
	[newManagedObject setValue:@"h" forKey:@"Sat_Fat_RDI"];
	[newManagedObject setValue:@"f" forKey:@"Brand_Name"];
	[newManagedObject setValue:@"d" forKey:@"Benefits"];
	[newManagedObject setValue:@"s" forKey:@"General_Desc"];
	[newManagedObject setValue:@"s" forKey:@"Net_Content_UOM"];
	[newManagedObject setValue:@"d" forKey:@"Pallet_Ti"];
	[newManagedObject setValue:@"d" forKey:@"GPC_Code"];
	[newManagedObject setValue:@"e" forKey:@"Ingredients"];
	[newManagedObject setValue:@"w" forKey:@"Iron_RDI"];
	[newManagedObject setValue:@"r" forKey:@"Gr_Weight_UOM"];
	[newManagedObject setValue:@"e" forKey:@"Total_Fat"];
	[newManagedObject setValue:@"r" forKey:@"Storage_Temp_From_UOM"];
	[newManagedObject setValue:@"t" forKey:@"Sodium_RDI"];
	[newManagedObject setValue:@"y" forKey:@"Depth"];
	[newManagedObject setValue:@"u" forKey:@"Manufacturer"];
	[newManagedObject setValue:@"i" forKey:@"GTIN"];
	[newManagedObject setValue:@"i" forKey:@"GPC_Description"];
	[newManagedObject setValue:@"o" forKey:@"Avg_Serving"];
	[newManagedObject setValue:@"p" forKey:@"Vitamin_A_RDI"];
	[newManagedObject setValue:@"u" forKey:@"Carbohydrates"];
	[newManagedObject setValue:@"y" forKey:@"Manufacturer_GLN"];
	[newManagedObject setValue:@"t" forKey:@"Net_Content"];
	[newManagedObject setValue:@"r" forKey:@"Shelf_Life"];
	[newManagedObject setValue:@"d" forKey:@"Brand_Owner"];
	[newManagedObject setValue:@"d" forKey:@"Volume"];
	[newManagedObject setValue:@"ds" forKey:@"Country_Origin_of_Product"];
	[newManagedObject setValue:@"s" forKey:@"Info_Provider_GLN"];
	[newManagedObject setValue:@"s" forKey:@"Net_Weight_UOM"];
	[newManagedObject setValue:@"s" forKey:@"Total_Fat_RDI"];
	[newManagedObject setValue:@"s" forKey:@"Volume_UOM"];
	[newManagedObject setValue:@"d" forKey:@"Depth_UOM"];
	[newManagedObject setValue:@"f" forKey:@"Sodium"];
	[newManagedObject setValue:@"f" forKey:@"Shelf_Life_UOM"];
	[newManagedObject setValue:@"g" forKey:@"Prep_Cooking_Sugg"];
	[newManagedObject setValue:@"h" forKey:@"Pack_Storage_Info"];
	[newManagedObject setValue:@"d" forKey:@"Storage_Temp_From"];
	[newManagedObject setValue:@"s" forKey:@"Saturated_Fat"];
	[newManagedObject setValue:@"s" forKey:@"MPC"];
	[newManagedObject setValue:@"d" forKey:@"Height_UOM"];
	[newManagedObject setValue:@"a" forKey:@"Kosher"];
	[newManagedObject setValue:@"z" forKey:@"GRP_ID"];
	[newManagedObject setValue:@"cx" forKey:@"PRD_ID"];
	[newManagedObject setValue:@"v" forKey:@"TPY_ID"];
	[newManagedObject setValue:@"x" forKey:@"Biotin_UOM"];
	[newManagedObject setValue:@"x" forKey:@"Calcium_UOM"];
	[newManagedObject setValue:@"z" forKey:@"Calories_Fat_UOM"];
	[newManagedObject setValue:@"s" forKey:@"Calories_UOM"];
	[newManagedObject setValue:@"w" forKey:@"Carbohydrates_UOM"];
	[newManagedObject setValue:@"a" forKey:@"Chloride_UOM"];
	[newManagedObject setValue:@"s" forKey:@"Cholestrol_UOM"];
	[newManagedObject setValue:@"f" forKey:@"Chromium_UOM"];
	[newManagedObject setValue:@"g" forKey:@"Copper_UOM"];
	[newManagedObject setValue:@"v" forKey:@"Folate_UOM"];
	[newManagedObject setValue:@"b" forKey:@"Insoluble_Fiber_UOM"];
	[newManagedObject setValue:@"c" forKey:@"Iodine_UOM"];
	[newManagedObject setValue:@"c" forKey:@"Iron_UOM"];
	[newManagedObject setValue:@"x" forKey:@"Magnesium_UOM"];
	[newManagedObject setValue:@"" forKey:@"Manganese_UOM"];
	[newManagedObject setValue:@"m" forKey:@"Molybdenum_UOM"];
	[newManagedObject setValue:@"n" forKey:@"Monosaturated_Fat_UOM"];
	[newManagedObject setValue:@"b" forKey:@"Niacin_UOM"];
	[newManagedObject setValue:@"v" forKey:@"Other_Carbohydrates_UOM"];
	[newManagedObject setValue:@"c" forKey:@"PRD_IMAGE_LINK"];
	[newManagedObject setValue:@"x" forKey:@"Pantothenic_UOM"];
	[newManagedObject setValue:@"z" forKey:@"Phosphorous_UOM"];
	[newManagedObject setValue:@"c" forKey:@"Polyunsaturated_Fat_UOM"];
	[newManagedObject setValue:@"v" forKey:@"Potassium_UOM"];
	[newManagedObject setValue:@"b" forKey:@"Protein_UOM"];
	[newManagedObject setValue:@"n" forKey:@"Riboflovin_B2_UOM"];
	[newManagedObject setValue:@"n" forKey:@"Saturated_Fat_UOM"];
	[newManagedObject setValue:@"m" forKey:@"Selenium_UOM"];
	[newManagedObject setValue:@"b" forKey:@"Sodium_UOM"];
	[newManagedObject setValue:@"b" forKey:@"Soluble_Fiber_UOM"];
	[newManagedObject setValue:@"f" forKey:@"Thiamin_UOM"];
	[newManagedObject setValue:@"f" forKey:@"Total_Diet_Fiber_UOM"];
	[newManagedObject setValue:@"d" forKey:@"Total_Fat_UOM"];
	[newManagedObject setValue:@"s" forKey:@"Total_Sugar_UOM"];
	[newManagedObject setValue:@"d" forKey:@"Trans_Fatty_Acid_UOM"];
	[newManagedObject setValue:@"f" forKey:@"Vitamin_A_UOM"];
	[newManagedObject setValue:@"g" forKey:@"Vitamin_B12_UOM"];
	[newManagedObject setValue:@"h" forKey:@"Vitamin_B6_UOM"];
	[newManagedObject setValue:@"j" forKey:@"Vitamin_C_UOM"];
	[newManagedObject setValue:@"k" forKey:@"Vitamin_D_UOM"];
	[newManagedObject setValue:@"k" forKey:@"Vitamin_E_UOM"];
	[newManagedObject setValue:@"h" forKey:@"Vitamin_K_UOM"];
	[newManagedObject setValue:@"g" forKey:@"Zinc_UOM"];
	
	
    
    // Save the context.
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
		
	}
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated {

    // Prevent new objects being added when in editing mode.
    [super setEditing:(BOOL)editing animated:(BOOL)animated];
    self.navigationItem.rightBarButtonItem.enabled = !editing;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrInfo count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
	
	Test1 *obj =  [arrInfo objectAtIndex:indexPath.row];
	
    cell.textLabel.text =  obj.Long_Name; 
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

  


#pragma mark -
#pragma mark Fetched results controller delegate


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    //[fetchedResultsController_ release];
    [managedObjectContext release];
    [super dealloc];
}


@end

