//
//  RdioSearchResultsTableViewController.m
//  Local Plays for Rdio®
//
//  Created by Fosco Marotto on 3/30/13.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "RdioSearchResultsTableViewController.h"
#import "AppDelegate.h"
#import "LocalPlaysTableViewController.h"

@interface RdioSearchResultsTableViewController ()

@end

@implementation RdioSearchResultsTableViewController

@synthesize searchResults, rdio, geopoint, tableData;

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

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 62.0f)];
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"resultsHeader"]];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTouchHeader:)];
    
    [headerView addGestureRecognizer:ges];
    
    self.tableView.tableHeaderView = headerView;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didTouchHeader:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    return searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SearchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBg"]];

    NSDictionary *cellData = [searchResults objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:[cellData objectForKey:@"icon"]];
    UIImageView *thumb = (UIImageView *)[cell viewWithTag:1];
    thumb.image = nil;
    [thumb setImageWithURL:url];
    
    UILabel *trackLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *artistLabel = (UILabel *)[cell viewWithTag:3];
    trackLabel.text = [cellData objectForKey:@"name"];
    artistLabel.text = [cellData objectForKey:@"artist"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellData = [searchResults objectAtIndex:indexPath.row];
    [rdio.player playSource:[cellData objectForKey:@"key"]];
    
    PFObject *entry = [[PFObject alloc] initWithClassName:@"LocalPlays"];
    [entry setObject:geopoint forKey:@"location"];
    [entry setObject:[cellData objectForKey:@"key"] forKey:@"sourceKey"];
    [entry setObject:[cellData objectForKey:@"icon"] forKey:@"icon"];
    [entry setObject:[cellData objectForKey:@"artist"] forKey:@"artist"];
    [entry setObject:[cellData objectForKey:@"name"] forKey:@"name"];
    [entry saveEventually];
    
    //tableData = [tableData arrayByAddingObject:entry];
    
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:tableData];
    [temp insertObject:entry atIndex:0];
    tableData = (NSArray *)temp;
    
    LocalPlaysTableViewController *lptvc = (LocalPlaysTableViewController *)[self.navigationController.viewControllers objectAtIndex:1];
    //AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [ad updateTableData:objects];
    lptvc.tableData = tableData;
    [lptvc.tableView reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 80.0f;
}

@end
