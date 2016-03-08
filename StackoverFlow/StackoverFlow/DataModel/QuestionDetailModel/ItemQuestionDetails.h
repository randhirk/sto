//
//  ItemQuestionDetails.h
//  
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 ORG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ItemQuestionDetailOwner ;

@interface ItemQuestionDetails : NSObject {
    NSNumber *answerCount;
    NSArray *answers;
    NSString *body;
    NSNumber *closedDate;
    NSString *closedReason;
    NSNumber *creationDate;
    BOOL isAnswered;
    NSNumber *lastActivityDate;
    NSNumber *lastEditDate;
    NSString *link;
    ItemQuestionDetailOwner *owner;
    NSNumber *questionId;
    NSNumber *score;
    NSArray *tags;
    NSString *title;
    NSNumber *viewCount;
}

@property (nonatomic, copy) NSNumber *answerCount;
@property (nonatomic, copy) NSArray *answers;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSNumber *closedDate;
@property (nonatomic, copy) NSString *closedReason;
@property (nonatomic, copy) NSNumber *creationDate;
@property (nonatomic, assign) BOOL isAnswered;
@property (nonatomic, copy) NSNumber *lastActivityDate;
@property (nonatomic, copy) NSNumber *lastEditDate;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, strong) ItemQuestionDetailOwner  *owner;
@property (nonatomic, copy) NSNumber *questionId;
@property (nonatomic, copy) NSNumber *score;
@property (nonatomic, copy) NSArray *tags;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSNumber *viewCount;

+ (ItemQuestionDetails *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

@end
