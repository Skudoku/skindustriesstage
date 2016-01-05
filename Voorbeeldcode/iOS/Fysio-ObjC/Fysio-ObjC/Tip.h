//
//  Blessure.h
//  Fysio-ObjC
//
//  Created by RazorBit on 28-10-15.
//  Copyright © 2015 RazorBit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tip : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *image;

- (id) initWithName:(NSString *) name andCategory:(NSString *) category andDescription:(NSString *) description andImage:(NSString *) image;

//+(instancetype) tipWithName:(NSString *) name andCategory:(NSString *) category andDescription:(NSString *) description andImage:(NSString *) image;

@end
