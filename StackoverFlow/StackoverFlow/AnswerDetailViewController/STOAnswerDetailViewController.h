//
//  STOAnswerDetailViewController.h
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STOAnswerDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *textWebView; //to display full answer without parsing HTML tags
@property (nonatomic,strong) NSString *answerBodyStr;


@end
