//
//  DetailInjuryController.m
//  Fysio-ObjC
//
//  Created by RazorBit on 29-10-15.
//  Copyright © 2015 RazorBit. All rights reserved.
//

#import "DetailInjuryController.h"
#import "SWRevealViewController.h"

@interface DetailInjuryController()

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *ivDetail;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;


@end

@implementation DetailInjuryController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    NSString *title = [[NSUserDefaults standardUserDefaults] stringForKey:@"detailtitle"];
    NSString *description = [[NSUserDefaults standardUserDefaults] stringForKey:@"detaildescription"];
    
    [self.lblTitle setText:title];
    [self.lblDescription setText:description];
}

- (IBAction)btnBack:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:false completion:nil];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"detailtitle"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"detaildescription"];
}

@end
