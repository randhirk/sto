//
//  STONetworkConnection.h
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STONetworkConnection : NSObject

// Our Public Properties
@property                     BOOL                  loggingEnabled;
@property (nonatomic, strong) NSString             *searchItemsShown;
@property (readonly, strong)  NSString             *searchText;
@property (readonly, strong)  NSString             *shown;
@property                     BOOL                  soundsEnabled;
@property                     BOOL                  userLoggedOn;
@property                     BOOL                  vibrateEnabled;


@end
