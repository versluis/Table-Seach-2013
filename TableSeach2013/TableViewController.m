//
//  TableViewController.m
//  TableSeach2013
//
//  Created by Jay Versluis on 01/03/2013.
//  Copyright (c) 2013 Jay Versluis. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

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
    
    // in itializes our sample array
    [self createData];
    self.searchResults = [[NSMutableArray alloc]init];
    
    // needed for iOS 5
    // in iOS 6 we can use the UISearchDisplayController in the storyboard and don't need this setup
    self.controller = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    self.controller.searchResultsDataSource = self;
    self.controller.searchResultsDelegate = self;

}

- (void)viewWillAppear:(BOOL)animated {
    
    // scroll the search bar off-screen
    CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + self.searchBar.bounds.size.height;
    self.tableView.bounds = newBounds;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        // Return the number of rows in the section.
        return self.allData.count;
    } else {
    
        [self filterData];
        return self.searchResults.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]init];
    }
    
    if (tableView == self.tableView) {
       
        cell.textLabel.text = [self.allData objectAtIndex:indexPath.row];
        
    } else {
        
        cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
    }
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        self.title = [self.allData objectAtIndex:indexPath.row];
    } else {
        self.title = [self.searchResults objectAtIndex:indexPath.row];
    }
}


- (void)createData {
    
    self.allData = [[NSArray alloc]initWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", @"Six",
                    @"Seven", @"Eight", @"Nine", @"Ten", @"Eleven", @"Twelve",
                    @"Thirteen", @"Fourteen", @"Fifteen", @"Sixteen", @"Seventeen", @"Eighteen",
                    @"Ninteteen", @"Twenty", @"Twentyone", @"Twentytwo", @"Twentythree", @"Twentyfour",
                    nil];
    
}

- (void)viewDidUnload {
    [self setSearchBar:nil];
    [self setSearchBar:nil];
    [super viewDidUnload];
}

- (void)filterData {
    
    self.searchResults = nil;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [cd] %@", self.searchBar.text];
    self.searchResults = [[self.allData filteredArrayUsingPredicate:predicate] mutableCopy];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self.searchDisplayController setActive:YES];
    [self filterData];
    
}



- (IBAction)displaySearchBar:(id)sender {
    
    // makes the search bar visible
    [self.searchBar becomeFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    // hide the search bar when users are finished
    // we could implement the same code as in viewDidAppear
    // or even easier: just call that method
    [self viewWillAppear:YES];
    
}






@end