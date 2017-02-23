//
//  CuBHomeViewController.m
//  C_usBetter
//
//  Created by Tamil Selvan R on 22/02/17.
//  Copyright © 2017 Tamil Selvan R. All rights reserved.
//

#import "CuBHomeViewController.h"
#import "CuBActiveUserCollectionViewCell.h"
#import "NetworkHandler.h"


@interface CuBHomeViewController () < UICollectionViewDelegate, UICollectionViewDataSource,UITextViewDelegate >

@property (weak, nonatomic) IBOutlet UICollectionView *activeUser_collectioView;
@property (nonatomic)NSMutableArray *profileImageArray;
@property (nonatomic)NSMutableArray *profileNameArray;
@property (weak, nonatomic) IBOutlet UIView *rideView;
@property (weak, nonatomic) IBOutlet UIButton *ride_Btn;
- (IBAction)ride_Btn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *sourceLocation_TextField;
@property (weak, nonatomic) IBOutlet UITextField *destination_TextField;
@property (weak, nonatomic) IBOutlet UILabel *title_Label;
@property (weak, nonatomic) IBOutlet UITextView *commnets_TextView;
@property (weak, nonatomic) IBOutlet UIButton *setting_Btn;
@property (weak, nonatomic) IBOutlet UIView *waitingRideView;

- (IBAction)setting_Btn:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *title_View;
@property (weak, nonatomic) IBOutlet UIButton *waitingRide_Btn;
- (IBAction)waitingRide_Btn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *waitingRide_Label;

@end

@implementation CuBHomeViewController
@synthesize activeUser_collectioView, profileImageArray, commnets_TextView, title_Label, destination_TextField, sourceLocation_TextField, ride_Btn, rideView, title_View, waitingRideView, profileNameArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    commnets_TextView.delegate=self;
    activeUser_collectioView.delegate=self;
    rideView.layer.borderColor=[UIColor whiteColor].CGColor;
    rideView.layer.borderWidth=0.4;
    
    title_View.layer.borderColor=[UIColor whiteColor].CGColor;
    title_View.layer.borderWidth=0.4;
    
    waitingRideView.layer.borderColor=[UIColor whiteColor].CGColor;
    waitingRideView.layer.borderWidth=0.4;
//
    activeUser_collectioView.layer.borderColor=[UIColor whiteColor].CGColor;
    activeUser_collectioView.layer.borderWidth=0.4;
   
    UITapGestureRecognizer *hideKeyBoard=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.title_View addGestureRecognizer:hideKeyBoard];
    [self.waitingRideView addGestureRecognizer:hideKeyBoard];
    [self.rideView addGestureRecognizer:hideKeyBoard];
    
    profileImageArray=[[ NSMutableArray alloc] initWithObjects:@"male.png",@"male.png",@"male.png",@"male.png",@"male.png",@"male.png",@"male.png",@"male.png",@"male.png",@"male.png",@"male.png",nil];
      profileNameArray=[[ NSMutableArray alloc] initWithObjects:@"Tamil",@"Vishwa",@"Nithin",@"Rajesh",@"Manoj",@"Adithya",@"Pabitra",@"Nagesh",@"Vamshi",@"Kiran",@"Karthik",nil];
    // Do any additional setup after loading the view.
    
    [self registerDevice];
    
}

-(void)registerDevice{
    //Register the device
    if ([NetworkHandler sharedInstance].deviceToken.length > 0) {
        [[NetworkHandler sharedInstance] registerDeviceTokenWithDetails:@{@"UserId":[NetworkHandler sharedInstance].loginUserID,@"Token":[NetworkHandler sharedInstance].deviceToken} withURL:@"details/SaveDeviceToken" withMethod:@"POST" completionHandler:^(NSDictionary *response, NSError *error) {
            if (!error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Success" message:@"Device registered successfully" preferredStyle:UIAlertControllerStyleAlert];
                    [alertVC addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self updateUserLocation];
                    }]];
                    [self presentViewController:alertVC animated:YES completion:nil];
                });
            }
        }];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Device registeration failed" preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertVC animated:YES completion:nil];
        });
    }
}


-(void)updateUserLocation{
    if ([NetworkHandler sharedInstance].userLocation) {
        
        __block NSString * location;
        CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:[NetworkHandler sharedInstance].userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *place = placemarks.firstObject;
            location = [NSString stringWithFormat:@"%@, %@",place.subLocality,place.locality];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sourceLocation_TextField.text = location;
            });
        }];
        
        
        __block NSString * latitute =[[NSNumber numberWithDouble:[NetworkHandler sharedInstance].userLocation.coordinate.latitude] stringValue];
        __block NSString * longitude = [[NSNumber numberWithDouble:[NetworkHandler sharedInstance].userLocation.coordinate.longitude] stringValue];
        [[NetworkHandler sharedInstance] updateLocationDetails:@{@"UserId":[NetworkHandler sharedInstance].loginUserID,@"Latitude":latitute,@"Longitude":longitude} withURL:@"details/SaveUserLocation" withMethod:@"POST" completionHandler:^(NSDictionary *response, NSError *error) {
            if (!error) {
                
            }
        }];
    }
}
-(void)hideKeyBoard{
    [commnets_TextView resignFirstResponder];
    [destination_TextField resignFirstResponder];
}
#pragma Collection View
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return profileImageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    CuBActiveUserCollectionViewCell *cell = [activeUser_collectioView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.profileCell.image = [UIImage imageNamed:[profileImageArray objectAtIndex:indexPath.row]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *message=[NSString stringWithFormat:@"%@ is in Online",[profileNameArray objectAtIndex:indexPath.row]];
    
    UIAlertController *alert1=[UIAlertController alertControllerWithTitle:@"Active User" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert1 addAction:ok];
    [self presentViewController:alert1 animated:YES completion:nil];
    
}

- (IBAction)ride_Btn:(id)sender {
    [self performSegueWithIdentifier:@"StartRide" sender:self];
}
- (IBAction)setting_Btn:(id)sender {
  
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Settings" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *Profile=[UIAlertAction actionWithTitle:@"Profile" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self performSegueWithIdentifier:@"ProfileVc" sender:self];

    }];
    UIAlertAction *Notification=[UIAlertAction actionWithTitle:@"Notification" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [self performSegueWithIdentifier:@"Notify" sender:self];
    }];
    
    UIAlertAction *logOut=[UIAlertAction actionWithTitle:@"Log Out" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self performSegueWithIdentifier:@"logOut" sender:self];
    }];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    [alert addAction:cancel];
    [alert addAction:Notification];
    [alert addAction:Profile];
    [alert addAction:logOut];
    [self presentViewController:alert animated:YES completion:nil];
 
}

-(BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if ([commnets_TextView.text isEqualToString:@"Share message,..."]) {
        commnets_TextView.text = @"";
        // self.totalTextCountLabel.text=@"";
        commnets_TextView.font=[UIFont systemFontOfSize:20];
        commnets_TextView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(commnets_TextView.text.length == 0){
        commnets_TextView.textColor = [UIColor blackColor];
        commnets_TextView.font=[UIFont systemFontOfSize:15];
        commnets_TextView.text = @"Share message,...";
        [commnets_TextView resignFirstResponder];
        
    }
}

- (IBAction)waitingRide_Btn:(id)sender {
    [self performSegueWithIdentifier:@"WaitingRide" sender:self];
}
@end
