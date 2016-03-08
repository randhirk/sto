//
//  STOQuestionDetailsController.m
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import "STOQuestionDetailsController.h"
#import "HTTPDataLoad.h"
#import "QuestionDetailClass.h"
#import "ItemQuestionDetailOwner.h"
#import "Answer.h"
#import "AnswerOwner.h"
#import "ItemQuestionDetails.h"


#define WEB_SERVICE_QUESTIONS_DETAILS_ID  @"https://api.stackexchange.com/2.1/questions"

@interface STOQuestionDetailsController()<HTTPDataLoadDelegate>

@property (nonatomic,strong) QuestionDetailClass *myclass;
@property (nonatomic,strong) ItemQuestionDetails    *items;
@property (nonatomic,strong) ItemQuestionDetailOwner *itemOwner;
@property (nonatomic,strong) Answer *myAnswer;
@property (nonatomic,strong) AnswerOwner    *answerOwner;

@end

@implementation STOQuestionDetailsController

@synthesize questionID;
@synthesize myclass;
@synthesize items;
@synthesize itemOwner;
@synthesize myAnswer;
@synthesize answerOwner;



#pragma mark - Instance  Methods
// Call this method from the viewWillAppear method
- (void) checkForUpdates
{
    
//    NSLog(@"question id id %@",questionID);
    
    NSString *urlString =@"?order=desc&sort=activity&site=stackoverflow&filter=!-079JLGYVbFJ";
    NSString *finalUrlString =[NSString stringWithFormat:@"%@/%@/%@",WEB_SERVICE_QUESTIONS_DETAILS_ID,questionID,urlString  ];
    
    
//    NSLog(@"final url id %s %@",__PRETTY_FUNCTION__,[NSURL URLWithString: finalUrlString ]);

    
    dispatch_async( dispatch_get_main_queue(),
                   ^{
                       
                       [ [HTTPDataLoad sharedInstance] setDelegate: self];
                       [ [HTTPDataLoad sharedInstance] setDelegate: self];
                       [ [HTTPDataLoad sharedInstance] sendRequestTo: [NSURL URLWithString: finalUrlString ]
                                                           usingVerb: @"GET"
                                                      withParameters: nil];
                       
                       
                   } );
    
}


-(NSString *)getQuestionDetails
{

    ItemQuestionDetails *thisRow =[self.myclass.items objectAtIndex:0];
    
    
    NSArray *itemDictionaryArray =[self.myclass items];
    //    NSLog(@"itemDictionary array is  %@",itemDictionaryArray);
    

        NSDictionary *itemDetailsDict =[[NSDictionary alloc]init];
        itemDetailsDict =[itemDictionaryArray objectAtIndex:0];
        NSLog(@"Dictionary  inside for loop is %@",itemDetailsDict);
    
    NSString *questionDetailString =thisRow.body;
//        [titleArray addObject:[itemDetailsDict valueForKey:@"title"]];
        //        NSLog(@"TitleArray inside for loop is %@",titleArray);
        
    
    NSLog(@"DetailString is %@",questionDetailString);
    return questionDetailString;
    
}


-(NSString *)getAnswerDetails: (int) row
{
    
    NSArray *itemDictionaryArray =[self.myclass items];
    //    NSLog(@"itemDictionary array is  %@",itemDictionaryArray);
    
    
    NSDictionary *itemDetailsDict =[[NSDictionary alloc]init];
    NSDictionary *answerDetailsDict =[[NSDictionary alloc]init];
    
    itemDetailsDict =[itemDictionaryArray objectAtIndex:0];
    NSArray *answerArray =[itemDetailsDict valueForKey:@"answers"];
    
    NSLog(@"Answer Array is inside for loop is %@",answerArray);
        
        answerDetailsDict =[answerArray  objectAtIndex:row];
    
    return [answerDetailsDict valueForKey:@"body"];
    
}




-(NSArray *)ownerForAnswers
{
    
    NSArray *itemDictionaryArray =[self.myclass items];
    //    NSLog(@"itemDictionary array is  %@",itemDictionaryArray);
    
    NSMutableArray *titleArray =[[NSMutableArray alloc] initWithCapacity:1];
    
        NSDictionary *itemDetailsDict =[[NSDictionary alloc]init];
        NSDictionary *answerDetailsDict =[[NSDictionary alloc]init];

        itemDetailsDict =[itemDictionaryArray objectAtIndex:0];
        NSArray *answerArray =[itemDetailsDict valueForKey:@"answers"];
        
        NSLog(@"Answer Array is inside for loop is %@",answerArray);
    for (int i=0; i<[answerArray count]; i++) {
    
        answerDetailsDict =[answerArray  objectAtIndex:i];
        NSDictionary *ownerDict =[[NSDictionary alloc] init];
        ownerDict = [answerDetailsDict valueForKey:@"owner"];
        if ([answerDetailsDict valueForKey:@"is_accepted"] ) {
            [titleArray addObject:[ownerDict valueForKey:@"display_name"]];

        }
        else{
        [titleArray addObject:[ownerDict valueForKey:@"display_name"]];
        }
        //        NSLog(@"TitleArray inside for loop is %@",titleArray);
        
    }
    
    
    NSLog(@"TitleArray  from detail screen is %@",titleArray);
    return titleArray;
}

#pragma mark -HTTPDataLoadDelegate Methods


- (void)    httpDataLoad: (HTTPDataLoad *) httpdataload
         didRetrieveData: (NSData *) data
                 headers: (NSDictionary *) headers
{
    
//    NSLog(@"I am here hehe %s",__PRETTY_FUNCTION__);

    NSString       *responseString = [httpdataload responseAsText];
    NSData          *jsonData     = [responseString dataUsingEncoding: NSUTF8StringEncoding];
    NSError         *parsingError = nil;
    NSDictionary    *parsedData   = [NSJSONSerialization JSONObjectWithData: jsonData
                                                                    options: 0
                                                                      error: &parsingError];
    NSLog(@"main dictionary is %@",parsedData);
    self.myclass =[QuestionDetailClass instanceFromDictionary:parsedData];
//    NSLog(@"the data is %@",responseString);
//    NSArray *itemDictionaryArray =[self.myclass items];
//    NSLog(@"itemDictionary array is  %@",itemDictionaryArray);

    [self.delegate questionDetailController:self HasNewData: YES];
       
  
    
}





@end
