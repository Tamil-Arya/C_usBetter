//
//  Profile_ViewController.m
//  C_usBetter
//
//  Created by Tamil Selvan R on 22/02/17.
//  Copyright © 2017 Tamil Selvan R. All rights reserved.
//

#import "CuBProfile_ViewController.h"

@interface CuBProfile_ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *profile_Title;
@property (weak, nonatomic) IBOutlet UIButton *cancel_Btn;
- (IBAction)cancel_Btn:(id)sender;

@end

@implementation CuBProfile_ViewController
@synthesize emailID_TextField,name_TextField, ProfileView, PhNumber_TextField, profile_Btn, gender_TextField, edit_Btn;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    emailID_TextField.text=@"tamil.selvan@mobinius.com";
    name_TextField.text=@"Tamil";
    PhNumber_TextField.text=@"8050961727";
    gender_TextField.text=@"Male";
    
    emailID_TextField.enabled=NO;
    name_TextField.enabled=NO;
    PhNumber_TextField.enabled=NO;
    gender_TextField.enabled=NO;
    
    [edit_Btn setTitle:@"Save" forState:UIControlStateSelected];
    [edit_Btn setTitle:@"Edit" forState:UIControlStateNormal];
    
    UITapGestureRecognizer *hideKeyBoard=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:hideKeyBoard];
    
    
    // Do any additional setup after loading the view.
}
-(void)hideKeyBoard{
    [emailID_TextField resignFirstResponder];
    [name_TextField resignFirstResponder];
    [PhNumber_TextField resignFirstResponder];
    [gender_TextField resignFirstResponder];
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

- (IBAction)edit_Btn:(id)sender {
    if([sender isSelected]){
        emailID_TextField.enabled=NO;
        name_TextField.enabled=NO;
        PhNumber_TextField.enabled=NO;
        gender_TextField.enabled=NO;
        [sender setSelected:NO];
    } else {
        emailID_TextField.enabled=YES;
        name_TextField.enabled=YES;
        PhNumber_TextField.enabled=YES;
        gender_TextField.enabled=YES;
       
        [sender setSelected:YES];
    }

}
- (IBAction)profile_Btn:(id)sender {
}
- (IBAction)cancel_Btn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
