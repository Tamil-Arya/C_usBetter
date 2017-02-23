//
//  AppDelegate.h
//  C_usBetter
//
//  Created by Tamil Selvan R on 22/02/17.
//  Copyright © 2017 Tamil Selvan R. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>

@interface CuBAppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

