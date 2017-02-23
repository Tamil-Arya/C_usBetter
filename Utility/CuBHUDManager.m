//
//  CuBHUDManager.m
//  CuB
//
//  Created by vishwavijet on 2/23/17.
//  Copyright © 2017 Tamil Selvan R. All rights reserved.
//

#import "CuBHUDManager.h"
static CuBHUDManager *sharedContextManager = nil;

@implementation CuBHUDManager

+ (void) initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedContextManager = [[CuBHUDManager alloc] init];
    });
}


+ (CuBHUDManager *)sharedInstance
{
    return sharedContextManager;
}


-(MBProgressHUD *)progressHudWithColor:(UIColor *)color withView:(UIView *)view withMessage:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.contentColor = color;
    hud.label.text = message;
    
    return hud;
}
@end
