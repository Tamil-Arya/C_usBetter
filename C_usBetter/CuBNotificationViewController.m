//
//  CuBNotificationViewController.m
//  C_usBetter
//
//  Created by Tamil Selvan R on 23/02/17.
//  Copyright © 2017 Tamil Selvan R. All rights reserved.
//

#import "CuBNotificationViewController.h"

@interface CuBNotificationViewController ()

@end

@implementation CuBNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancel_Btn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
