//
//  MenuViewController.m
//  MathHackFour
//
//  Created by Ben Butler on 8/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "OperationsViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

@synthesize operations = _operations;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
                      
}

- (void)viewDidUnload
{
//    [self setMenuLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _operations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCell";
    
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleDefault 
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSArray *keys = _operations.allKeys;
    cell.textLabel.text = (NSString *)[keys objectAtIndex:indexPath.row];
    return cell;
}

+ (NSString *)description
{
    return @"This is a MenuViewController";
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toOperations"]) {
        UITableViewCell *sourceCell = (UITableViewCell *)sender;
        OperationsViewController *ovc = segue.destinationViewController;
        NSString *op = sourceCell.textLabel.text;
        NSString *hint = [_operations objectForKey:op];
        ovc.operation = op;
        [ovc setProblemFromSegue:op withHint:hint];

//        self.navigationController.navigationItem.titleView.
        NSLog(@"MVC prepareForSegue -- %@ -- %@", op, hint);
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
