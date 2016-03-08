//
//  Answer.h
//  
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 ORG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AnswerOwner;

@interface Answer : NSObject {
    NSNumber *answerId;
    NSString *body;
    NSNumber *creationDate;
    BOOL is_accepted;
    NSNumber *lastActivityDate;
    AnswerOwner *owner;
    NSNumber *questionId;
    NSNumber *score;
}

@property (nonatomic, copy) NSNumber *answerId;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSNumber *creationDate;
@property (nonatomic, assign) BOOL is_accepted;
@property (nonatomic, copy) NSNumber *lastActivityDate;
@property (nonatomic, strong) AnswerOwner *owner;
@property (nonatomic, copy) NSNumber *questionId;
@property (nonatomic, copy) NSNumber *score;

+ (Answer *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
