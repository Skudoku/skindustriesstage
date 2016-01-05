//
//  BackTableViewController.m
//  Fysio-ObjC
//
//  Created by RazorBit on 27-10-15.
//  Copyright © 2015 RazorBit. All rights reserved.
//

#import "BackTableViewController.h"

@interface BackTableViewController()

@property (strong, nonatomic) NSArray *menuitems;


@end

@implementation BackTableViewController


- (void) viewDidLoad {
    [super viewDidLoad];
    self.menuitems = [NSArray arrayWithObjects:@"Home",@"Profiel",@"Tips",@"Contact",@"Mijn Blessures", @"Uitloggen", nil];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuitems.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.menuitems[indexPath.row]];

    cell.textLabel.text = self.menuitems[indexPath.row];
    
    return cell;
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.menuitems[indexPath.row]];
    if([cell.textLabel.text  isEqual: @"Uitloggen"]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"memberid"];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"firstname"];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"lastname"];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"address"];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"zip"];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"email"];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"profilepic"];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"username"];
        [self performSegueWithIdentifier:@"segUitloggen" sender:self];
    }
    
}


@end
