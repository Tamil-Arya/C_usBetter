//
//  CuBStartedRideViewController.m
//  C_usBetter
//
//  Created by Tamil Selvan R on 23/02/17.
//  Copyright © 2017 Tamil Selvan R. All rights reserved.
//

#import "CuBStartedRideViewController.h"
#import <MapKit/MapKit.h>

@interface CuBStartedRideViewController ()
- (IBAction)cancelRide_Btn:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation CuBStartedRideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)cancelRide_Btn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
