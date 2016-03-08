//
//  STOIntroPageViewController.m
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import "STOIntroPageViewController.h"
#import "HTTPDataLoad.h"
#import "STOCommonUtility.h"
#import "STONetworkConnection.h"
#import "STOQuestionDataController.h"

#define WEB_SERVICE_QUESTIONS_TAG  @"https://api.stackexchange.com/2.1/search/advanced?order=desc&sort=activity&tagged=Objective-C&site=stackoverflow"

@interface STOIntroPageViewController ()

@property (nonatomic, strong)       NSString                *fullURL;
@property (nonatomic, strong)       STOQuestionDataController *datacontroller;

@end

@implementation STOIntroPageViewController
@synthesize inputJsonFilename;
@synthesize jsonFromDataModel;
@synthesize fullURL;
@synthesize datacontroller;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.datacontroller =[[STOQuestionDataController alloc] init];
	// Do any additional setup after loading the view.
}
#pragma 
#pragma call webservice for getting questions

- (IBAction)tagButtonPressed:(id)sender
{
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
