//
//  LocalPlaysTableViewController.h
//  Local Plays for Rdio®
//
//  Created by Fosco Marotto on 3/30/13.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalPlaysTableViewController : UITableViewController <RdioDelegate, RDAPIRequestDelegate>

@property (strong, nonatomic) NSArray *tableData;
@property (strong, nonatomic) Rdio *rdio;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) NSString *searchValue;
@property (strong, nonatomic) NSArray *searchResults;

@end
