//
//  TableViewController.h
//  TableSeach2013
//
//  Created by Jay Versluis on 01/03/2013.
//  Copyright (c) 2013 Jay Versluis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) NSArray *allData;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

// needed for iOS 5
// in iOS 6 the UISearchDisplayController in the storyboard needs no additional setup
@property (strong, nonatomic) UISearchDisplayController *controller;

- (IBAction)displaySearchBar:(id)sender;

@end
