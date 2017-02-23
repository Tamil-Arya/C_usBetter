//
//  CuBHUDManager.h
//  CuB
//
//  Created by vishwavijet on 2/23/17.
//  Copyright © 2017 Tamil Selvan R. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface CuBHUDManager : NSObject

+(CuBHUDManager *)sharedInstance;

-(MBProgressHUD *)progressHudWithColor:(UIColor *)color withView:(UIView *)view withMessage:(NSString *)message;

@end
