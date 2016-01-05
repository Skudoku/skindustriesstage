//
//  MijnBlessures.m
//  Fysio-ObjC
//
//  Created by RazorBit on 29-10-15.
//  Copyright © 2015 RazorBit. All rights reserved.
//

#import "MijnBlessures.h"
#import "SWRevealViewController.h"

@interface MijnBlessures()

@property (strong, nonatomic) IBOutlet UITableView *myinjurytableView;


@end


@implementation MijnBlessures


-(void) viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    [self.myinjurytableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"cellMyInjury"];
    
    [self.myinjurytableView setDataSource:self];
    [self.myinjurytableView setDelegate:self];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellMyInjury"];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellMyInjury"];
    
    cell.textLabel.text = @"test";
    
    return cell;

}

@end
