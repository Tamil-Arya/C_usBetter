//
//  Profile_ViewController.h
//  C_usBetter
//
//  Created by Tamil Selvan R on 22/02/17.
//  Copyright © 2017 Tamil Selvan R. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CuBProfile_ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *ProfileView;
@property (weak, nonatomic) IBOutlet UITextField *emailID_TextField;
@property (weak, nonatomic) IBOutlet UITextField *name_TextField;
@property (weak, nonatomic) IBOutlet UITextField *PhNumber_TextField;
@property (weak, nonatomic) IBOutlet UIButton *profile_Btn;
- (IBAction)profile_Btn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *gender_TextField;
@property (weak, nonatomic) IBOutlet UIButton *edit_Btn;
- (IBAction)edit_Btn:(id)sender;

@end
