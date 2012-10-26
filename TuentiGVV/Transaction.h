//
//  Transaction.h
//  TuentiGVV
//
//  Created by Gustavo Vidal Vicent on 14/07/2012.
//  Copyright (c) 2012 Hochschule Luzern. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject <NSCoding>{
    NSString *name;
    NSString *amount;
     NSString *currency;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic,copy) NSString *amount;
@property (nonatomic,copy)  NSString *currency;

@end