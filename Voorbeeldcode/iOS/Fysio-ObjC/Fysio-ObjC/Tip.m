//
//  Blessure.m
//  Fysio-ObjC
//
//  Created by RazorBit on 28-10-15.
//  Copyright © 2015 RazorBit. All rights reserved.
//

#import "Tip.h"

@implementation Tip

@synthesize name, category, description, image;

-(id)initWithName:(NSString *)tipname andCategory:(NSString *)tipcategory andDescription:(NSString *)tipdescription andImage:(NSString *)tipimage {
    
    self = [super init];
    self.name = tipname;
    self.category = tipcategory;
    self.description = tipdescription;
    self.image = tipimage;
    return self;
}

@end
