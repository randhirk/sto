//
//  ItemQuestionDetails.m
//  
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 ORG. All rights reserved.
//

#import "ItemQuestionDetails.h"

#import "Answer.h"
#import "ItemQuestionDetailOwner.h"

@implementation ItemQuestionDetails

@synthesize answerCount;
@synthesize answers;
@synthesize body;
@synthesize closedDate;
@synthesize closedReason;
@synthesize creationDate;
@synthesize isAnswered;
@synthesize lastActivityDate;
@synthesize lastEditDate;
@synthesize link;
@synthesize owner;
@synthesize questionId;
@synthesize score;
@synthesize tags;
@synthesize title;
@synthesize viewCount;

+ (ItemQuestionDetails *)instanceFromDictionary:(NSDictionary *)aDictionary {

    ItemQuestionDetails *instance = [[ItemQuestionDetails alloc] init];
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

    if ([key isEqualToString:@"answers"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                Answer *populatedMember = [Answer instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }

            self.answers = myMembers;

        }

    } else if ([key isEqualToString:@"owner"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.owner = [ItemQuestionDetailOwner instanceFromDictionary:value];
        }

    } else if ([key isEqualToString:@"tags"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                [myMembers addObject:valueMember];
            }

            self.tags = myMembers;

        }

    } else {
        [super setValue:value forKey:key];
    }

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

  /*  if ([key isEqualToString:@"answer_count"]) {
        [self setValue:value forKey:@"answerCount"];
    } else if ([key isEqualToString:@"closed_date"]) {
        [self setValue:value forKey:@"closedDate"];
    } else if ([key isEqualToString:@"closed_reason"]) {
        [self setValue:value forKey:@"closedReason"];
    } else if ([key isEqualToString:@"creation_date"]) {
        [self setValue:value forKey:@"creationDate"];
    } else if ([key isEqualToString:@"is_answered"]) {
        [self setValue:value forKey:@"isAnswered"];
    } else if ([key isEqualToString:@"last_activity_date"]) {
        [self setValue:value forKey:@"lastActivityDate"];
    } else if ([key isEqualToString:@"last_edit_date"]) {
        [self setValue:value forKey:@"lastEditDate"];
    } else if ([key isEqualToString:@"question_id"]) {
        [self setValue:value forKey:@"questionId"];
    } else if ([key isEqualToString:@"view_count"]) {
        [self setValue:value forKey:@"viewCount"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }*/

}


@end
