//
//  CuBStartedRideViewController.m
//  C_usBetter
//
//  Created by Tamil Selvan R on 23/02/17.
//  Copyright © 2017 Tamil Selvan R. All rights reserved.
//

#import "CuBStartedRideViewController.h"
#import <MapKit/MapKit.h>
#import "NetworkHandler.h"
@interface CuBStartedRideViewController ()
- (IBAction)cancelRide_Btn:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,strong)CLLocationManager *locationManager;

@end

@implementation CuBStartedRideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestAlwaysAuthorization];
    self.mapView.delegate = self;
    
//    [[NetworkHandler sharedInstance] getUserDetailsWithURL:url withMethod:@"GET" completionHandler:^(NSDictionary *response, NSError *error) {
//        if ([response[@"ErrorMessage"] isKindOfClass:[NSNull class]]) {
//            emailID_TextField.text=response[@"EmailId"];
//            name_TextField.text=response[@"FirstName"];
//            PhNumber_TextField.text=response[@"FirstName"];
//            gender_TextField.text=response[@"FirstName"];
//        }
//    }];
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
    [[NetworkHandler sharedInstance] endRideWithDetails:@{@"StartRiderUserId":[NetworkHandler sharedInstance].loginUserID,@"PickupRiderUserId":@0} withURL:@"details/EndRide" withMethod:@"POST" completionHandler:^(NSDictionary *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}


- (IBAction)zoom:(id)sender {
    [self zoomToUserLocation];
}

#pragma mark - Location delegate methods
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        self.mapView.showsUserLocation = YES;
    }
}

//func region(withGeotification geotification: Geotification) -> CLCircularRegion {
//    // 1
//    let region = CLCircularRegion(center: geotification.coordinate, radius: geotification.radius, identifier: geotification.identifier)
//    // 2
//    region.notifyOnEntry = (geotification.eventType == .onEntry)
//    region.notifyOnExit = !region.notifyOnEntry
//    return region
//}
//
//func startMonitoring(geotification: Geotification) {
//    // 1
//    if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
//        showAlert(withTitle:"Error", message: "Geofencing is not supported on this device!")
//        return
//    }
//    // 2
//    if CLLocationManager.authorizationStatus() != .authorizedAlways {
//        showAlert(withTitle:"Warning", message: "Your geotification is saved but will only be activated once you grant Geotify permission to access the device location.")
//    }
//    // 3
//    let region = self.region(withGeotification: geotification)
//    // 4
//    locationManager.startMonitoring(for: region)
//}


#pragma mark - MakpView
//- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay{
//    
//    if ([overlay isKindOfClass:[MKCircle class]]) {
//        MKCircleRenderer *renderer = [[MKCircleRenderer alloc ]initWithCircle:overlay];
//        renderer.lineWidth = 1.0;
//        renderer.strokeColor = [UIColor purpleColor];
//        renderer.fillColor = [[UIColor purpleColor] colorWithAlphaComponent:0.5];
//        return renderer;
//    }else{
//        return [[MKOverlayRenderer alloc] initWithOverlay:overlay];
//    }
//    
//}
//
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
//    if ([annotation isKindOfClass:[GeaNotify class]]) {
//        MKAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annoteIdentifier"];
//        if (annotationView == nil) {
//            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annoteIdentifier"];
//            annotationView.canShowCallout = YES;
//            UIButton *remove = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
//            [remove setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
//            [annotationView setLeftCalloutAccessoryView:remove];
//        }
//        else{
//            annotationView.annotation = annotation;
//        }
//        return annotationView;
//    }
//    return nil;
//}


-(void)zoomToUserLocation{
    MKCoordinateRegion mapRegion;
    mapRegion.center = self.mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.1;
    mapRegion.span.longitudeDelta = 0.1;
    
    [self.mapView setRegion:mapRegion animated: YES];
}
@end
