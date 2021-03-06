//
//  ItemQuestionDetailOwner.h
//  
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 ORG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemQuestionDetailOwner : NSObject {
    NSString *displayName;
    NSString *link;
    NSString *profileImage;
    NSNumber *reputation;
    NSNumber *userId;
    NSString *userType;
}

@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *profileImage;
@property (nonatomic, copy) NSNumber *reputation;
@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, copy) NSString *userType;

+ (ItemQuestionDetailOwner *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
