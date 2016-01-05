//
//  ViewController.m
//  Fysio-ObjC
//
//  Created by RazorBit on 27-10-15.
//  Copyright © 2015 RazorBit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSURLConnection *connection;

@property (strong, nonatomic) IBOutlet UITextField *tfEmail;

@property (strong, nonatomic) IBOutlet UITextField *tfPassword;

@property (strong, nonatomic) NSMutableData *responseData;
@property (assign) int successful;


- (IBAction)btnLogin:(UIButton *)sender;

@end

@implementation ViewController



- (IBAction) btnLogin:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segLogin" sender:self];
    /*NSString *email = _tfEmail.text;
    NSString *password = _tfPassword.text;
    
    //if there is a connection going on just cancel it.
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
    //NSLog(self.receivedData);*/
}
/*
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

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[self.responseData length]);
    if([self.responseData length] > 0) {
        _successful = 1;
    }
    
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
    
    NSString *memberid = [res objectForKey:@"uuid"];
    NSLog(@"%@",memberid);
    [[NSUserDefaults standardUserDefaults] setValue:memberid forKey:@"memberid"];
    NSString *firstname = [res objectForKey:@"firstname"];
    [[NSUserDefaults standardUserDefaults] setValue:firstname forKey:@"firstname"];
    NSString *lastname = [res objectForKey:@"lastname"];
    [[NSUserDefaults standardUserDefaults] setValue:lastname forKey:@"lastname"];
    NSString *address = [res objectForKey:@"address"];
    [[NSUserDefaults standardUserDefaults] setValue:address forKey:@"address"];
    NSString *zip = [res objectForKey:@"zipcode"];
    [[NSUserDefaults standardUserDefaults] setValue:zip forKey:@"zip"];
    NSString *email = [res objectForKey:@"email"];
    [[NSUserDefaults standardUserDefaults] setValue:email forKey:@"email"];
    NSString *profilepic = [res objectForKey:@"photo"];
    [[NSUserDefaults standardUserDefaults] setValue:profilepic forKey:@"profilepic"];
    NSString *username = [NSString stringWithFormat:@"%@ %@",[res objectForKey:@"firstname"],[res objectForKey:@"lastname"]];
    [[NSUserDefaults standardUserDefaults] setValue:username forKey:@"username"];
     
    
    
    // extract specific value...
    //NSArray *results = [res objectForKey:@"results"];
    
    //for (NSDictionary *result in results) {
        //NSString *icon = [result objectForKey:@"icon"];
        //NSLog(@"icon: %@", icon);
    //}
    
    if (_successful == 1) {
        [self performSegueWithIdentifier:@"segLogin" sender:self];
    }
    
}
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    
}

@end
