//
//  Tips.m
//  Fysio-ObjC
//
//  Created by RazorBit on 27-10-15.
//  Copyright © 2015 RazorBit. All rights reserved.
//

#import "Tips.h"
#import "SWRevealViewController.h"

@interface Tips()

@property (strong, nonatomic) IBOutlet UITableView *tiptableView;
@property (strong, nonatomic) NSArray *category;


@end

@implementation Tips

@synthesize tiptableView;

-(void) viewDidLoad {
    [super viewDidLoad];
    self.category = [NSArray arrayWithObjects:@"Hoofd", @"Schouder", @"Torso", @"Rug", @"Arm", @"Been", @"Voet", nil];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    [self.tiptableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"cellTips"];
    
    [self.tiptableView setDataSource:self];
    [self.tiptableView setDelegate:self];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _category.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.category[indexPath.row]];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.category[indexPath.row]];
    
    cell.textLabel.text = self.category[indexPath.row];
    
    return cell;
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *categoryinjury = self.category[indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:categoryinjury forKey:@"subcategory"];
    
    [self performSegueWithIdentifier:@"segSubTips" sender:self];
}

@end
