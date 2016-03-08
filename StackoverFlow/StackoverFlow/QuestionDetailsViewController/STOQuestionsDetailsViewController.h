//
//  STOQuestionsDetailsViewController.h
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STOQuestionsDetailsViewController : UIViewController

@property (nonatomic,strong) NSNumber *questionID;
@property (weak, nonatomic) IBOutlet UIWebView *textWebView;
@property (nonatomic,strong) NSString *answerBodyStr;



@end
