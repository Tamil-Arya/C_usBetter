//
//  CuBWaitingRideViewController.m
//  C_usBetter
//
//  Created by Tamil Selvan R on 23/02/17.
//  Copyright © 2017 Tamil Selvan R. All rights reserved.
//

#import "CuBWaitingRideViewController.h"

@interface CuBWaitingRideViewController ()
- (IBAction)Dismiss:(id)sender;

@end

@implementation CuBWaitingRideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *hideKeyBoard=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:hideKeyBoard];
  
    // Do any additional setup after loading the view.
}
-(void)hideKeyBoard{
//    [email_TextField resignFirstResponder];
//    [password_TextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
