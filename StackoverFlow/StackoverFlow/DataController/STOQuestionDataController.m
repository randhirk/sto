//
//  STOQuestionDataController.m
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import "STOQuestionDataController.h"
#import "HTTPDataLoad.h"
#import "MyClass.h"
#import "Item.h"
#import "ItemOwner.h"


#define WEB_SERVICE_QUESTIONS_TAG  @"https://api.stackexchange.com/2.1/search/advanced?page="
#define WEB_SERVICE_QUESTION_TAG1  @"&order=desc&sort=creation&tagged=Objective-C&site=stackoverflow"
#define PAGE                       @1


@interface STOQuestionDataController()<HTTPDataLoadDelegate>
@property (nonatomic,strong) MyClass    *myclass;
@property (nonatomic)        int        pageIncrement;
@property (nonatomic)        int        currentPage;
@property (nonatomic)        int        pageForNextPageFetch;
@property (nonatomic,strong) Item       *items;
@property (nonatomic,strong) ItemOwner  *itemOwner;


@end

@implementation STOQuestionDataController

@synthesize myclass;
@synthesize items;
@synthesize pageIncrement;
@synthesize currentPage;
@synthesize pageForNextPageFetch;







#pragma mark - Initialization methods

- (id)init
{
    
    if ( self = [super init] )
    {
        self.currentPage   = 0;
        self.pageIncrement = 0;
        self.pageIncrement = 1;  // We always start at 1
    }
    return self;
}

#pragma mark - Instance Methods

// Call this method from the viewWillAppear method
- (void) checkForUpdates
{
   
    NSString *finalUrlString =[NSString stringWithFormat:@"%@%@%@",WEB_SERVICE_QUESTIONS_TAG,PAGE,WEB_SERVICE_QUESTION_TAG1 ];
    
  

    NSLog(@"final url is %@",[NSURL URLWithString: finalUrlString]);
    
    dispatch_async( dispatch_get_main_queue(),
                   ^{
                      
                       [ [HTTPDataLoad sharedInstance] setDelegate: self];
                       [ [HTTPDataLoad sharedInstance] setDelegate: self];
                       [ [HTTPDataLoad sharedInstance] sendRequestTo: [NSURL URLWithString: finalUrlString]
                                                           usingVerb: @"GET"
                                                      withParameters: nil];

                       
                   } );
    
}


-(NSArray *)titlesForQuestions
{
    
    if (0==[[self.myclass items] count]) {
        return @[];
    }
    else{
    NSArray *itemDictionaryArray =[self.myclass items];
//    NSLog(@"itemDictionary array is  %@",itemDictionaryArray);

    NSMutableArray *titleArray =[[NSMutableArray alloc] initWithCapacity:1];
    for (int i=0; i<[itemDictionaryArray count]; i++) {
        NSDictionary *itemDetailsDict =[[NSDictionary alloc]init];
        itemDetailsDict =[itemDictionaryArray objectAtIndex:i];
//        NSLog(@"Dictionary  inside for loop is %@",itemDetailsDict);

       [titleArray addObject:[itemDetailsDict valueForKey:@"title"]];
//        NSLog(@"TitleArray inside for loop is %@",titleArray);

    }

//    NSLog(@"TitleArray is %@",titleArray);
    return titleArray;
    }
}

-(NSArray *)getQuestionIDForRow: (int) row
{
    Item *thisRow =nil;
    if (self.myclass.items.count >0) {
        thisRow =[self.myclass.items objectAtIndex:row];
       }
    
    if (nil ==thisRow.question_id) {
        return @[];
    }
    
    else{
        return @[thisRow.question_id];
    }

}


- (void) getNextPage
{
    
    self.pageIncrement = 1;
    self.pageForNextPageFetch = self.pageForNextPageFetch + self.pageIncrement;
    
    NSString *finalUrlString =[NSString stringWithFormat:@"%@%d%@",WEB_SERVICE_QUESTIONS_TAG, self.pageForNextPageFetch,WEB_SERVICE_QUESTION_TAG1 ];
    
    dispatch_async( dispatch_get_main_queue(),
                   ^{
                       
                       [ [HTTPDataLoad sharedInstance] setDelegate: self];
                       [ [HTTPDataLoad sharedInstance] setDelegate: self];
                       [ [HTTPDataLoad sharedInstance] sendRequestTo: [NSURL URLWithString: finalUrlString]
                                                           usingVerb: @"GET"
                                                      withParameters: nil];
                       
                       
                   } );

    
    
       
}




#pragma HTTPDelegate Methods

- (void)    httpDataLoad: (HTTPDataLoad *) httpdataload
         didRetrieveData: (NSData *) data
                 headers: (NSDictionary *) headers
{
    NSString       *responseString = [httpdataload responseAsText];
    
    NSData          *jsonData     = [responseString dataUsingEncoding: NSUTF8StringEncoding];
    NSError         *parsingError = nil;
    NSDictionary    *parsedData   = [NSJSONSerialization JSONObjectWithData: jsonData
                                                                    options: 0
                                                                      error: &parsingError];
    
//    NSLog(@"main dictionary is %@",parsedData);
    
    self.myclass =[MyClass instanceFromDictionary:parsedData];
    
    [self.delegate questionDataController:self HasNewData: YES];

    
//    NSArray *itemDictionaryArray =[self.myclass items];
//    NSLog(@"itemDictionary array is  %@",itemDictionaryArray);
//    
//    NSLog(@"the data is %@",responseString);
    
}






@end
