//
//  ViewController.m
//  Local Plays for Rdio®
//
//  Created by Fosco Marotto on 3/30/13.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize loginButton, rdio;

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    rdio = ad.rdio;
    rdio.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapLogin:(id)sender {
    [rdio authorizeFromController:self];
}

- (void)rdioDidAuthorizeUser:(NSDictionary *)user withAccessToken:(NSString *)accessToken {
    NSLog(@"%@",user);
    PFUser *curUser = [PFUser currentUser];
    [curUser setObject:[NSString stringWithFormat:@"%@ %@", [user valueForKey:@"firstName"], [user valueForKey:@"lastName"]] forKey:@"rdioName"];
    [curUser setObject:[user objectForKey:@"key"] forKey:@"rdioToken"];
    [curUser saveEventually];
    [self queryLocalData];
}

/**
 * Authentication failed so we should alert the user.
 */
- (void)rdioAuthorizationFailed:(NSString *)message {
    NSLog(@"Rdio authorization failed: %@", message);
}

- (void)queryLocalData {
    NSLog(@"Querying for Local Plays");
    [self performSegueWithIdentifier:@"splashToMain" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"About to segue...");
    
}
@end
