//
// HTTPDataLoadDelegate.h
// 
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTTPDataLoad;

@protocol HTTPDataLoadDelegate <NSObject>


@optional
- (void)httpDataLoad:(HTTPDataLoad *)httpdataload didRetrieveData:(NSData *)data headers:(NSDictionary *)headers;
- (void)httpDataLoadHasBadCredentials:(HTTPDataLoad *)httpdataload;
- (void)httpDataLoad:(HTTPDataLoad *)httpdataload didCreateResourceAtURL:(NSString *)url;
- (void)httpDataLoad:(HTTPDataLoad *)httpdataload didFailWithError:(NSError *)error;
- (void)httpDataLoad:(HTTPDataLoad *)httpdataload didReceiveStatusCode:(NSInteger)statusCode;

@end
