//
//  STOQuestionDetailsController.h
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STOQuestionDetailsController;

@protocol STOQuestionDetailsControllerDelegate <NSObject>

@optional
-(void) questionDetailController:(STOQuestionDetailsController *) questionDetailController HasNewData:(BOOL) hasData;

@end

@interface STOQuestionDetailsController : NSObject

@property (nonatomic, weak) id<STOQuestionDetailsControllerDelegate> delegate;
@property (nonatomic,strong) NSNumber *questionID;

//call this from viewWillAppear
- (void) checkForUpdates;

//get full questions
-(NSString *)getQuestionDetails;

//owner for answer to display
-(NSArray *)ownerForAnswers;

//get full answers
-(NSString *)getAnswerDetails: (int) row;



@end
