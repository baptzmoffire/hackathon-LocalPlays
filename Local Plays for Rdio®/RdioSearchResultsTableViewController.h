//
//  RdioSearchResultsTableViewController.h
//  Local Plays for Rdio®
//
//  Created by Fosco Marotto on 3/30/13.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RdioSearchResultsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) Rdio *rdio;
@property (strong, nonatomic) PFGeoPoint *geopoint;

@end
