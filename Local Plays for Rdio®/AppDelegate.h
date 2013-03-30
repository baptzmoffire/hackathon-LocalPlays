//
//  AppDelegate.h
//  Local Plays for Rdio®
//
//  Created by Fosco Marotto on 3/30/13.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Rdio *rdio;
@property (strong, nonatomic) NSArray *tableData;

+ (Rdio*)rdioInstance;

@end
