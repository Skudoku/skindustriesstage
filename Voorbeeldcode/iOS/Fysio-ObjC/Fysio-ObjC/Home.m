//
//  Home.m
//  Fysio-ObjC
//
//  Created by RazorBit on 27-10-15.
//  Copyright © 2015 RazorBit. All rights reserved.
//

#import "Home.h"
#import "SWRevealViewController.h"

@interface Home()

@property (strong, nonatomic) IBOutlet UILabel *lblWelcome;


@end

@implementation Home

- (void) viewDidLoad {
    [super viewDidLoad];
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    SWRevealViewController *revealController = [self revealViewController];
    //self.view.backgroundColor = [UIColor whiteColor];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
}

- (void) viewDidAppear:(BOOL)animated {
    //NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
    //[self.lblWelcome setText:[NSString stringWithFormat:@"   Welkom, %@", username]];
}

@end
