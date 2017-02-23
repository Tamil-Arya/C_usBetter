//
//  CuBLoginViewController.m
//  C_usBetter
//
//  Created by Tamil Selvan R on 22/02/17.
//  Copyright © 2017 Tamil Selvan R. All rights reserved.
//

#import "CuBLoginViewController.h"
#import "NetworkHandler.h"

@interface CuBLoginViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UITextField *email_TextField;
@property (weak, nonatomic) IBOutlet UITextField *password_TextField;
@property (weak, nonatomic) IBOutlet UIButton *login_Btn;
@property (weak, nonatomic) IBOutlet UIButton *forget_Btn;
@property (weak, nonatomic) IBOutlet UILabel *error_Label;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;

- (IBAction)forget_Btn:(id)sender;
- (IBAction)login_Btn:(id)sender;


@end

@implementation CuBLoginViewController
@synthesize forget_Btn, login_Btn, password_TextField, email_TextField, loginView, error_Label;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.progress.hidden = YES;
    UITapGestureRecognizer *hideKeyBoard=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:hideKeyBoard];
   
    // Do any additional setup after loading the view.
}
-(void)hideKeyBoard{
    [email_TextField resignFirstResponder];
    [password_TextField resignFirstResponder];
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

- (IBAction)login_Btn:(id)sender {
    
    if ([email_TextField.text length] > 0) {
        
        if ([password_TextField.text length] > 0) {
            self.progress.hidden = NO;
            
            [[NetworkHandler sharedInstance] loginUserwithDetails:@{@"Username":self.email_TextField.text,@"Password":self.password_TextField.text} withURL:@"Details/Login" withMethod:@"POST" completionHandler:^(NSDictionary *response, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.progress.hidden = YES;
                    if ([response[@"ErrorMessage"] isKindOfClass:[NSNull class]]) {
                        [NetworkHandler sharedInstance].loginUserID = response[@"UserId"];
                        NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:@"CuB"];
                        [defaults setObject:[NetworkHandler sharedInstance].loginUserID forKey:@"UserId"];
                        [defaults synchronize];
                        [self performSegueWithIdentifier:@"LoginVc" sender:self];
                    }
                    else{
                        error_Label.hidden=NO;
                        error_Label.text=response[@"ErrorMessage"];
                        [self performSelector:@selector(hideErrorLabel) withObject:nil afterDelay:3.0];
                    }
                });
                
            }];
            }
        else{
            error_Label.hidden=NO;
            error_Label.text=@"Please enter valid password";
            [self performSelector:@selector(hideErrorLabel) withObject:nil afterDelay:3.0];
        }
    }
    else{
        error_Label.hidden=NO;
        error_Label.text=@"Please enter valid email id";
        [self performSelector:@selector(hideErrorLabel) withObject:nil afterDelay:3.0];
    }
}
-(void)hideErrorLabel{
    error_Label.hidden=YES;
}
- (IBAction)forget_Btn:(id)sender {
}
@end
