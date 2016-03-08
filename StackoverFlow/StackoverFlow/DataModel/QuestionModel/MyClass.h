//
//  MyClass.h
//  
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 ORG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject {
    BOOL hasMore;
    NSArray *items;
    NSNumber *quotaMax;
    NSNumber *quotaRemaining;
}

@property (nonatomic, assign) BOOL hasMore;
@property (nonatomic, copy) NSArray *items;
@property (nonatomic, copy) NSNumber *quotaMax;
@property (nonatomic, copy) NSNumber *quotaRemaining;

+ (MyClass *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
