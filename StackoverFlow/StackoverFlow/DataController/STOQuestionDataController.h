//
//  STOQuestionDataController.h
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STOQuestionDataController;

@protocol STOQuestionDataControllerDelegate <NSObject>

@optional
-(void) questionDataController: (STOQuestionDataController *) questionDataController HasNewData: (BOOL)hasData;
@end


@interface STOQuestionDataController : NSObject

@property (nonatomic, weak) id<STOQuestionDataControllerDelegate> delegate;


// Call this method from the viewWillAppear method
- (void) checkForUpdates;

// gives titles for questions
-(NSArray *)titlesForQuestions;

//get questionID for next webservice call
-(NSArray *)getQuestionIDForRow: (int) row;

//to fetch next page

-(void)getNextPage;




@end
