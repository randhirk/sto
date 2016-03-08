//
//  STONetworkConnection.m
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//


#import "STONetworkConnection.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#define KEY_DATA_INITIALIZED        @"KEY_DATA_INITIALIZED"
#define KEY_LOGGING_ENABLED         @"KEY_LOGGING_ENABLED"
#define KEY_SEARCH_ITEMS_SHOWN      @"KEY_SEARCH_ITEMS_SHOWN"
#define KEY_SEARCH_TEXT             @"KEY_SEARCH_TEXT"
#define KEY_SHOWN                   @"KEY_SHOWN"
#define KEY_SOUNDS_ENABLED          @"KEY_SOUNDS_ENABLED"
#define KEY_USER_LOGGED_ON          @"KEY_USER_LOGGED_ON"
#define KEY_VIBRATE_ENABLED         @"KEY_VIBRATE_ENABLED"
#define kNetworkUnreachableMsg      @"Please try again from another location."
#define kNetworkUnreachableTitle    @"Network Unreachable!"
#define kOkButtonTitle              @"OK"

@interface STONetworkConnection ()<UIAlertViewDelegate>

- (id) init;

@end

@implementation STONetworkConnection

@synthesize loggingEnabled          = _loggingEnabled;
@synthesize searchItemsShown        = _searchItemsShown;
@synthesize searchText              = _searchText;
@synthesize shown                   = _shown;
@synthesize soundsEnabled           = _soundsEnabled;
@synthesize userLoggedOn            = _userLoggedOn;
@synthesize vibrateEnabled          = _vibrateEnabled;

#pragma mark - Getters & Setters

#pragma mark - Initialization

- (id) init
{
    if ( self = [super init] )
    {
        
        }
    
    return self;
}



@end
