//
//  ItemQuestionDetailOwner.m
//  
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 ORG. All rights reserved.
//

#import "ItemQuestionDetailOwner.h"

@implementation ItemQuestionDetailOwner

@synthesize displayName;
@synthesize link;
@synthesize profileImage;
@synthesize reputation;
@synthesize userId;
@synthesize userType;

+ (ItemQuestionDetailOwner *)instanceFromDictionary:(NSDictionary *)aDictionary {

    ItemQuestionDetailOwner *instance = [[ItemQuestionDetailOwner alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

   /* if ([key isEqualToString:@"display_name"]) {
        [self setValue:value forKey:@"displayName"];
    } else if ([key isEqualToString:@"profile_image"]) {
        [self setValue:value forKey:@"profileImage"];
    } else if ([key isEqualToString:@"user_id"]) {
        [self setValue:value forKey:@"userId"];
    } else if ([key isEqualToString:@"user_type"]) {
        [self setValue:value forKey:@"userType"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }*/

}


@end
