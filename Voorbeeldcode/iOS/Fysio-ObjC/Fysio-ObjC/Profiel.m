//
//  Profiel.m
//  Fysio-ObjC
//
//  Created by RazorBit on 27-10-15.
//  Copyright © 2015 RazorBit. All rights reserved.
//

#import "Profiel.h"
#import "SWRevealViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface Profiel()

@property (strong, nonatomic) NSURLConnection *connection;

@property (strong, nonatomic) NSMutableData *responseData;

@property (strong, nonatomic) IBOutlet UIImageView *ivProfile;

@property (strong, nonatomic) IBOutlet UITextField *tfVoornaam;

@property (strong, nonatomic) IBOutlet UITextField *tfAchternaam;

@property (strong, nonatomic) IBOutlet UITextField *tfEmail;

@property (strong, nonatomic) IBOutlet UITextField *tfTelefoonSporter;

@property (strong, nonatomic) IBOutlet UITextField *tfAdres;

@property (strong, nonatomic) IBOutlet UITextField *tfPostcode;

@property (strong, nonatomic) IBOutlet UITextField *tfStad;

@property (strong, nonatomic) IBOutlet UITextField *tfClubnaam;

@property (strong, nonatomic) IBOutlet UITextField *tfContactpersoon;

@property (strong, nonatomic) IBOutlet UITextField *tfTelefoonClub;


@end

@implementation Profiel

-(void) viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    [self getUserData];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog(@"%@",[NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

-(void) getUserData {
    [self.connection cancel];
    
    
    
    //initialize new mutable data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.responseData = data;
    //[data release];
    
    //initialize url that is going to be fetched.
    NSURL *url = [NSURL URLWithString:@"http://api.gildeict.nl/fysioapp_1.0.php"];
    
    //initialize a request from url
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[url standardizedURL]];
    
    //set http method
    [request setHTTPMethod:@"POST"];
    //initialize a post data
    NSString *postData = [NSString stringWithFormat:@"{\"serviceName\":\"AthleteService\", \"methodName\":\"details\",\"parameters\": [{\"athlete_uuid\":\"580e1d52-51dd-4962-a00d-54bfac39da73\",\"club_uuid\":\"8bfdb653-4e71-48f5-9585-4506605b4c1c\",\"apikey\":\"10\",\"apisecurity\":\"10\"}]}"];
    NSLog(@"%@",[postData dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]);
    
    NSData *jsonData = [postData dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    //set post data of request
    [request setHTTPBody:jsonData];
    
    //initialize a connection from request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.connection = connection;
    
    //start the connection
    [connection start];

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    
    NSString *jsonString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    NSString *jsonEscaped = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    jsonEscaped = [jsonEscaped substringWithRange:NSMakeRange(1, jsonEscaped.length -2)];
    NSData *jsonData = [jsonEscaped dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves | NSJSONWritingPrettyPrinted error:&myError];
    
    
    // show all values
    for(id key in res) {
        id value = [res objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
    }
    
    NSString *firstname = [res objectForKey:@"firstname"];
    [[self tfVoornaam] setText:firstname];
    NSString *lastname = [res objectForKey:@"lastname"];
    [[self tfAchternaam] setText:lastname];
    NSString *email = [res objectForKey:@"athleteemail"];
    [[self tfEmail] setText:email];
    NSString *phoneathlete = [res objectForKey:@"mobile"];
    [[self tfTelefoonSporter] setText:phoneathlete];
    NSString *address = [res objectForKey:@"athleteaddress"];
    [[self tfAdres] setText:address];
    NSString *zip = [res objectForKey:@"athletezipcode"];
    [[self tfPostcode] setText:zip];
    NSString *city = [res objectForKey:@"athletecity"];
    [[self tfStad] setText:city];
    NSString *clubname = [res objectForKey:@"name"];
    [[self tfClubnaam] setText:clubname];
    NSString *clubcontact = [res objectForKey:@"contactname"];
    [[self tfContactpersoon] setText:clubcontact];
    NSString *phoneclub = [res objectForKey:@"contactphone"];
    [[self tfTelefoonClub] setText:phoneclub];
    
    
}

-(void) viewDidAppear:(BOOL)animated {
    NSString *profilepic = [NSString stringWithFormat:@"http://www.evenementposter.nl%@", [[NSUserDefaults standardUserDefaults] stringForKey:@"profilepic"]];
    
    [self.tfVoornaam setText:[[NSUserDefaults standardUserDefaults] stringForKey:@"firstname"]];
    [self.tfAchternaam setText:[[NSUserDefaults standardUserDefaults] stringForKey:@"lastname"]];
    [self.tfEmail setText:[[NSUserDefaults standardUserDefaults] stringForKey:@"email"]];
    [self.tfAdres setText:[[NSUserDefaults standardUserDefaults] stringForKey:@"address"]];
    [self.tfPostcode setText:[[NSUserDefaults standardUserDefaults] stringForKey:@"zip"]];
    [self.ivProfile setImageWithURL:[NSURL URLWithString:profilepic]];
}

@end
