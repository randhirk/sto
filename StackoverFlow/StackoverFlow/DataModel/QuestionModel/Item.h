//
//  Item.h
//  
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 ORG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ItemOwner;

@interface Item : NSObject {
    NSNumber *acceptedAnswerId;
    NSNumber *answerCount;
    NSNumber *closedDate;
    NSString *closedReason;
    NSNumber *creationDate;
    BOOL isAnswered;
    NSNumber *lastActivityDate;
    NSNumber *lastEditDate;
    NSString *link;
    ItemOwner *owner;
    NSNumber *question_id;
    NSNumber *protected_date;
    NSNumber *score;
    NSArray *tags;
    NSString *title;
    NSNumber *viewCount;
}

@property (nonatomic, copy) NSNumber *acceptedAnswerId;
@property (nonatomic, copy) NSNumber *answerCount;
@property (nonatomic, copy) NSNumber *closedDate;
@property (nonatomic, copy) NSString *closedReason;
@property (nonatomic, copy) NSNumber *creationDate;
@property (nonatomic, assign) BOOL isAnswered;
@property (nonatomic, copy) NSNumber *lastActivityDate;
@property (nonatomic, copy) NSNumber *lastEditDate;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, strong) ItemOwner *owner;
@property (nonatomic, copy) NSNumber *question_id;
@property (nonatomic, copy) NSNumber *protectedDate;
@property (nonatomic, copy) NSNumber *score;
@property (nonatomic, copy) NSArray *tags;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSNumber *viewCount;

+ (Item *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
