//
//  AppDelegate.m
//  Local Plays for Rdio®
//
//  Created by Fosco Marotto on 3/30/13.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize rdio, tableData;

+ (Rdio*)rdioInstance {
    return [(AppDelegate*)[[UIApplication sharedApplication] delegate] rdio];
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"6KU2krjXKi7Prw47DtIVpzPPu4i5m5IvIdtnrhm8"
                  clientKey:@"mmYX3XvPh60EAO1lnKsQHKmu5U4wlK7bL6ygT7QT"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [PFUser enableAutomaticUser];
    [[PFUser currentUser] incrementKey:@"RunCount"];
    [[PFUser currentUser] saveInBackground];
    
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];

    rdio = [[Rdio alloc] initWithConsumerKey:@"ej7vsbxdm6k75mymprama4f6" andSecret:@"qsu7EvMJ8s" delegate:nil];
    
    return YES;
}

@end
