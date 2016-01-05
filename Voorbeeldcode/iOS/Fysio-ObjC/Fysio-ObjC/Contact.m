//
//  Contact.m
//  Fysio-ObjC
//
//  Created by RazorBit on 04-11-15.
//  Copyright © 2015 RazorBit. All rights reserved.
//

#import "Contact.h"
#import "SWRevealViewController.h"

@interface Contact()

@property (strong, nonatomic) IBOutlet UIPickerView *pvFysio;
@property (strong, nonatomic) IBOutlet UILabel *lblPhonenumber;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblCity;
@property (strong, nonatomic) IBOutlet UILabel *lblZip;


@end

@implementation Contact

-(void) viewDidLoad {
    [super viewDidLoad];
    [self.pvFysio setDelegate:self];
    [self.pvFysio setDataSource:self];
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];

}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 1;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"";
}

@end
