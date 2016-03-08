//
//  STOIntroPageViewController.h
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STOIntroPageViewController : UIViewController

@property (nonatomic, strong)   NSString        *inputJsonFilename;         // Used with input files only
@property (nonatomic, strong)   NSDictionary    *jsonFromDataModel;         // Used with data model dictionaries only

@end
