
//
//  BlessureMeldenPagina.m
//  Fysio-ObjC
//
//  Created by RazorBit on 04-11-15.
//  Copyright © 2015 RazorBit. All rights reserved.
//

#import "BlessureMeldenPagina.h"

@interface BlessureMeldenPagina()

@property (strong, nonatomic) IBOutlet UIPickerView *pvFysio;

@end

@implementation BlessureMeldenPagina

-(void) viewDidLoad {
    [super viewDidLoad];
    [self.pvFysio setDelegate:self];
    [self.pvFysio setDataSource:self];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 1;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"Choice-%ld",(long)row];
}

- (IBAction)btnBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:false completion:nil];
}




@end