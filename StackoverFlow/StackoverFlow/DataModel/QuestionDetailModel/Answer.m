//
//  Answer.m
//  
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 ORG. All rights reserved.
//

#import "Answer.h"

#import "AnswerOwner.h"

@implementation Answer

@synthesize answerId;
@synthesize body;
@synthesize creationDate;
@synthesize is_accepted;
@synthesize lastActivityDate;
@synthesize owner;
@synthesize questionId;
@synthesize score;


+ (Answer *)instanceFromDictionary:(NSDictionary *)aDictionary {

    Answer *instance = [[Answer alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forKey:(NSString *)key {

    if ([key isEqualToString:@"owner"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.owner = [AnswerOwner instanceFromDictionary:value];
        }

    } else {
        [super setValue:value forKey:key];
    }

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

   /* if ([key isEqualToString:@"answer_id"]) {
        [self setValue:value forKey:@"answerId"];
    } else if ([key isEqualToString:@"creation_date"]) {
        [self setValue:value forKey:@"creationDate"];
    } else if ([key isEqualToString:@"is_accepted"]) {
        [self setValue:value forKey:@"isAccepted"];
    } else if ([key isEqualToString:@"last_activity_date"]) {
        [self setValue:value forKey:@"lastActivityDate"];
    } else if ([key isEqualToString:@"question_id"]) {
        [self setValue:value forKey:@"questionId"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }*/

}


@end
