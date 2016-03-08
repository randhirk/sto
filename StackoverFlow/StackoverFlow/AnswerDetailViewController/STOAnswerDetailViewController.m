//
//  STOAnswerDetailViewController.m
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import "STOAnswerDetailViewController.h"

@interface STOAnswerDetailViewController ()

@end

@implementation STOAnswerDetailViewController

@synthesize answerBodyStr;
@synthesize textWebView;

#pragma mark - UIViewController Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *text =   self.answerBodyStr;
    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@"<p>"];
    NSLog(@"New String : %@", text);
    NSString *cssString = [NSString stringWithFormat:@".title {font-family: HelveticaNeue; text-decoration: bold; font-size: %fpt; color:red;} .news {font-family: Arial; font-size: %fpt; color:black;}",8.0, 10.0];
	NSString *htmlString = [NSString stringWithFormat:@"<html> <head> <style type=\"text/css\"> %@ </style> </head> <body> <p> <span class=\"news\">%@</span> </p> </body> </html>", cssString, text];
    [self.textWebView loadHTMLString:htmlString baseURL:nil];
    
}


@end
