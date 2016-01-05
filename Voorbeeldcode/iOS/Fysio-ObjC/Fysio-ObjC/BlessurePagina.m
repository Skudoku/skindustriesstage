//
//  BlessurePagina.m
//  Fysio-ObjC
//
//  Created by RazorBit on 28-10-15.
//  Copyright © 2015 RazorBit. All rights reserved.
//

#import "BlessurePagina.h"
#import "SWRevealViewController.h"
#import "Tip.h"

@interface BlessurePagina()

@property (strong, nonatomic) NSURLConnection *connection;

@property (strong, nonatomic) IBOutlet UILabel *lblCategory;

@property (strong, nonatomic) IBOutlet UITableView *injurytableView;

@property (strong, nonatomic) NSMutableData *responseData;

@property (strong, nonatomic) NSMutableArray *myTips;


@end

@implementation BlessurePagina

- (IBAction)btnBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:false completion:nil];
}


-(void) connect {
    //if there is a connection going on just cancel it.
        [self.connection cancel];
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.responseData = data;
    //[data release];
    
    //initialize url that is going to be fetched.
    NSURL *url = [NSURL URLWithString:@"http://www.evenementposter.nl/login/api.php?action=getTips"];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //set http method
    [request setHTTPMethod:@"POST"];
    //initialize a post data
    NSString *subcategory = [[[NSUserDefaults standardUserDefaults] stringForKey:@"subcategory"] lowercaseString];
    NSString *postData = [NSString stringWithFormat:@"json={\"categorie\":\"%@\"}", subcategory];
    NSLog(@"%@",[NSString stringWithFormat:@"%@", postData]);
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    //set post data of request
    [request setHTTPBody:[postData dataUsingEncoding:NSASCIIStringEncoding]];
    
    //initialize a connection from request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.connection = connection;
    
    //start the connection
    [connection start];
    //NSLog(self.receivedData);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog(@"%@",[NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[self.responseData length]);
    
    
    // convert to JSON
    NSError *myError = nil;
    NSString* string = [[[[NSString alloc] initWithData:self.responseData encoding:NSASCIIStringEncoding] stringByReplacingOccurrencesOfString:@"\t" withString:@""] stringByReplacingOccurrencesOfString:@"\0" withString:@""];
    self.responseData = [NSMutableData dataWithData:[string dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@", string);
    NSMutableDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableContainers | NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@", res);
    
    NSString *subcategory = [[[NSUserDefaults standardUserDefaults] stringForKey:@"subcategory"] lowercaseString];
    if( myError )
    {
        NSLog(@"%@", [myError localizedDescription]);
    }
    else {
        NSArray *injury = res[subcategory];
        for ( NSDictionary *theInjury in injury )
        {
            
            NSString *name = theInjury[@"Tipname"];
            NSString *category = subcategory;
            NSString *description = theInjury[@"Description"];
            NSString *image = theInjury[@"Image"];
            
            Tip *tip = [Tip new];
            [tip setName:name];
            [tip setCategory:category];
            [tip setDescription:description];
            [tip setImage:image];
            
            NSLog(@"Naam: %@, Beschrijving: %@, Categorie: %@", name, description, category);
            [self.myTips addObject:tip];
            
            //NSLog(@"Naam: %@, Beschrijving: %@, Categorie: %@", injury.name, injury.description, injury.category);
            
        }
        
        int count = (int)[self.myTips count];
        
        NSString *countstring = [NSString stringWithFormat:@"%d",count];
        
        NSLog(@"Count: %@", countstring);
        
        [self.injurytableView reloadData];
    }
    
    
    //Read more: http://www.intertech.com/Blog/basic-json-parsing-in-ios/#ixzz3prrm2llT
    //Follow us: @IntertechInc on Twitter | Intertech on Facebook
    
    // show all values
   
    
    // extract specific value...
    //NSArray *results = [res objectForKey:@"results"];
    
    //for (NSDictionary *result in results) {
    //NSString *icon = [result objectForKey:@"icon"];
    //NSLog(@"icon: %@", icon);
    //}
    
    
}


-(void) viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    self.myTips = [[NSMutableArray alloc] init];
    
    [self.injurytableView registerClass:UITableViewCell.self forCellReuseIdentifier:@"cellInjury"];
    
    [self.injurytableView setDataSource:self];
    [self.injurytableView setDelegate:self];
    NSString *subcategory = [[NSUserDefaults standardUserDefaults] stringForKey:@"subcategory"];
    
    [self.lblCategory setText:subcategory];
    [self connect];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myTips.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellInjury"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:@"cellInjury"];
        
    }
    if([self.myTips count] > 0) {
    
    Tip *currentTip = [self.myTips objectAtIndex:indexPath.row];
    
    NSLog(@"Naam: %@, Beschrijving: %@, Categorie: %@", currentTip.name, currentTip.description, currentTip.category);
    
    cell.textLabel.text = currentTip.name;
    cell.detailTextLabel.text = currentTip.description;
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Tip *currentTip = [self.myTips objectAtIndex:indexPath.row];
    
    NSString *image = @"";
    NSString *title = currentTip.name;
    NSString *description = currentTip.description;
    
    [[NSUserDefaults standardUserDefaults] setObject:image forKey:@"detailimage"];
    [[NSUserDefaults standardUserDefaults] setObject:title forKey:@"detailtitle"];
    [[NSUserDefaults standardUserDefaults] setObject:description forKey:@"detaildescription"];
    
    [self performSegueWithIdentifier:@"segDetailInjury" sender:self];
    
    
}


@end
