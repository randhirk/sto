//
//  HTTPDataLoad.h
//
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPDataLoadDelegate.h"

@interface HTTPDataLoad : NSObject

@property(nonatomic,strong)NSURLConnection *conn;
@property(nonatomic,strong)NSMutableData *receivedData;
@property (nonatomic) BOOL asynchronous;
@property (nonatomic, copy) NSString *mimeType;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, strong) NSDictionary *authenticationDetails;
@property (nonatomic, assign) id<HTTPDataLoadDelegate> delegate;
@property(nonatomic,strong)NSDictionary *userData;
@property (nonatomic,strong) NSDate *start;
@property (strong, nonatomic) NSDictionary *headerFields;

+(id)sharedInstance;

- (void)sendRequestTo:(NSURL *)url usingVerb:(NSString *)verb withParameters:(NSDictionary *)parameters;
- (void)uploadData:(NSData *)data toURL:(NSURL *)url;
- (void)cancelConnection;
- (NSDictionary *)responseAsPropertyList;
- (NSString *)responseAsText;

@end
