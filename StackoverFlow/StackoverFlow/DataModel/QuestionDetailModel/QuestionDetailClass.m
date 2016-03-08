//
// QuestionDetailClass.m
//  
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 ORG. All rights reserved.
//

#import "QuestionDetailClass.h"

#import "ItemQuestionDetails.h"

@implementation QuestionDetailClass

@synthesize hasMore;
@synthesize items;
@synthesize quotaMax;
@synthesize quotaRemaining;

+ (QuestionDetailClass *)instanceFromDictionary:(NSDictionary *)aDictionary {

    QuestionDetailClass *instance = [[QuestionDetailClass alloc] init];
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

    if ([key isEqualToString:@"items"]) {

        if ([value isKindOfClass:[NSArray class]]) {

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
              ItemQuestionDetails *populatedMember = [ItemQuestionDetails instanceFromDictionary:valueMember];
                [myMembers addObject:populatedMember];
            }

            self.items = myMembers;

        }

    } else {
        [super setValue:value forKey:key];
    }

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    /*if ([key isEqualToString:@"has_more"]) {
        [self setValue:value forKey:@"hasMore"];
    } else if ([key isEqualToString:@"quota_max"]) {
        [self setValue:value forKey:@"quotaMax"];
    } else if ([key isEqualToString:@"quota_remaining"]) {
        [self setValue:value forKey:@"quotaRemaining"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }*/

}


@end
