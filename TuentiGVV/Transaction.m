//
//  Transaction.m
//  TuentiGVV
//
//  Created by Gustavo Vidal Vicent on 14/07/2012.
//  Copyright (c) 2012 Hochschule Luzern. All rights reserved.
//

#import "Transaction.h"

@implementation Transaction



@synthesize name;
@synthesize amount;
@synthesize currency;



- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.amount = [decoder decodeObjectForKey:@"amount"];
        self.currency = [decoder decodeObjectForKey:@"currency"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:name forKey:@"name"];
    [encoder encodeObject:amount forKey:@"amount"];
    [encoder encodeObject:currency forKey:@"currency"];
}

@end