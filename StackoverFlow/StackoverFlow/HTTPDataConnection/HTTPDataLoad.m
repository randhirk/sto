//
//  HTTPDataLoad.m
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import "HTTPDataLoad.h"

@interface HTTPDataLoad ()

-(void)startConnection:(NSURLRequest *)request;

@end

@implementation HTTPDataLoad

@synthesize receivedData = _receivedData;
@synthesize asynchronous = _asynchronous;
@synthesize mimeType = _mimeType;
@synthesize username = _username;
@synthesize password = _password;
@synthesize delegate = _delegate;
@synthesize authenticationDetails;
@synthesize conn = _conn;
@synthesize userData;
@synthesize headerFields;
@synthesize start = _start;


#pragma mark - Constructor and destructor

static HTTPDataLoad *_sharedInstance;

+(HTTPDataLoad *)sharedInstance
{
    @synchronized(self)
    {
        if(!_sharedInstance)
        {
            _sharedInstance = [[self alloc] init];
            _sharedInstance.receivedData = [NSMutableData data];
            _sharedInstance.conn = nil;
            _sharedInstance.asynchronous = YES;
            _sharedInstance.mimeType = @"application/json";
            _sharedInstance.username = @"";
            _sharedInstance.password = @"";
        }
    }
    return _sharedInstance;
}

- (id)init
{
    if(self = [super init])
    {
    }
    
    return self;
}

#pragma mark -
#pragma mark Public methods


static NSString * AFPercentEscapedQueryStringPairMemberFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    static NSString * const kAFCharactersToBeEscaped = @":/?&=;+!@#$()~";
    static NSString * const kAFCharactersToLeaveUnescaped = @"[].";
    
	return (__bridge   NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, ( CFStringRef)string, ( CFStringRef)kAFCharactersToLeaveUnescaped, ( CFStringRef)kAFCharactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(encoding));
}



- (void)sendRequestTo:(NSURL *)url usingVerb:(NSString *)verb withParameters:(NSDictionary *)parameters
{
 
    NSData *body = nil;
    NSMutableString *params = nil;
    NSMutableString *params2=nil;
  
    NSString *contentType = @"application/x-www-form-urlencoded";
    NSURL *finalURL = url;
    if (parameters != nil)
    {
        params2 =[[NSMutableString alloc]init];
        params = [[NSMutableString alloc] init];
        
        
        for (id key in parameters)
        {
            
            
            NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            CFStringRef value = (__bridge CFStringRef)[[parameters objectForKey:key] copy];
            
            // Escape even the "reserved" characters for URLs
            // as defined in http://www.ietf.org/rfc/rfc2396.txt
            CFStringRef encodedValue = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                               value,
                                                                               NULL,
                                                                               (CFStringRef)@"!*'();:&=+$,@/?%#[]",
                                                                               kCFStringEncodingUTF8);
            [params appendFormat:@"%@=%@&", encodedKey, encodedValue];
                        
            static NSString * const kAFCharactersToBeEscaped = @":/?&=;+!@#$()~";
            
            CFStringRef value1= (__bridge CFStringRef)[[parameters objectForKey:key] copy];
            // Escape even the "reserved" characters for URLs
            // as defined in http://www.ietf.org/rfc/rfc2396.txt
            CFStringRef encodedValue1 = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                value1,
                                                                                NULL,
                                                                                (CFStringRef)kAFCharactersToBeEscaped,
                                                                                kCFStringEncodingUTF8);
            
            
            [params2  appendString:[NSString stringWithFormat: @"%@/", encodedValue1]];
          
            
            CFRelease(value);
            CFRelease(encodedValue);
            
        }
        
        
    }
    
    
    [params deleteCharactersInRange:NSMakeRange([params length] - 1, 1)];
    
    [params2 deleteCharactersInRange:NSMakeRange([params2 length] - 1, 1)];
    
    
    
    if ([verb isEqualToString:@"POST"] || [verb isEqualToString:@"PUT"])
    {
        NSString *postParams = [params stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        body = [postParams dataUsingEncoding:NSUTF8StringEncoding];
    }
    else
    {
        if (parameters != nil)
        {
           
            
           // NSString *testString= @"";
            
            NSString *urlWithParams = [[url absoluteString] stringByAppendingFormat:@"/%@",params2];
                      
            finalURL = [NSURL URLWithString:urlWithParams];
           
        }
    }
    NSMutableDictionary* headers = [[NSMutableDictionary alloc] init];
    [headers setValue:contentType forKey:@"Content-Type"];
    [headers setValue:[_sharedInstance mimeType] forKey:@"Accept"];
    [headers setValue:@"no-cache" forKey:@"Cache-Control"];
    [headers setValue:@"no-cache" forKey:@"Pragma"];
    [headers setValue:@"close" forKey:@"Connection"]; // Avoid HTTP 1.1 "keep alive" for the connection
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:finalURL
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    NSArray *cookies;
    NSDictionary *cookieHeaders;
    cookies = [[ NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:finalURL ];
    cookieHeaders = [ NSHTTPCookie requestHeaderFieldsWithCookies: cookies];
    request = [[ NSMutableURLRequest alloc ] initWithURL:finalURL ] ;
    [request setValue: [cookieHeaders objectForKey: @"Cookie" ]forHTTPHeaderField:@"Cookie" ];
    [request setHTTPMethod:verb];
    [request setAllHTTPHeaderFields:headers];
    
    if(parameters !=nil){
        
        [request setHTTPBody:body];
        
    }
    @synchronized(self)
    {
        _sharedInstance.start = [NSDate date];
    }
    [self startConnection:request];
}

- (void)uploadData:(NSData *)data toURL:(NSURL *)url
{
    NSMutableDictionary* headers = [[NSMutableDictionary alloc] init] ;
    [headers setValue:[_sharedInstance mimeType] forKey:@"Content-Type"];
    [headers setValue:[_sharedInstance mimeType] forKey:@"Accept"];
    [headers setValue:@"no-cache" forKey:@"Cache-Control"];
    [headers setValue:@"no-cache" forKey:@"Pragma"];
    [headers setValue:@"close" forKey:@"Connection"];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    
    NSMutableData* postData = [NSMutableData dataWithCapacity:[data length] + 512];
    [postData appendData:data];

    [request setHTTPBody:postData];
    
    [self startConnection:request];
}

- (void)cancelConnection
{
    @synchronized(self)
    {
        [_sharedInstance.conn cancel];
        _sharedInstance.conn = nil;
    }
}

- (NSDictionary *)responseAsPropertyList
{
    NSString *errorStr = nil;
    NSPropertyListFormat format;
    NSDictionary *propertyList = [NSPropertyListSerialization propertyListFromData:[_sharedInstance receivedData]
                                                                  mutabilityOption:NSPropertyListImmutable
                                                                            format:&format
                                                                  errorDescription:&errorStr];
    return propertyList;
}

- (NSString *)responseAsText
{
    return [[NSString alloc] initWithData:[_sharedInstance receivedData]
                                 encoding:NSUTF8StringEncoding];
}

#pragma mark -
#pragma mark Private methods

- (void)startConnection:(NSURLRequest *)request
{
    if (self.asynchronous)
    {
        [self cancelConnection];
        _sharedInstance.conn = [[NSURLConnection alloc] initWithRequest:request
                                                                delegate:_sharedInstance
                                                        startImmediately:YES] ;
        
        if (!_sharedInstance.conn)
        {
            if ([[_sharedInstance delegate] respondsToSelector:@selector(httpDataLoad:didFailWithError:)])
            {
                NSMutableDictionary* info = [NSMutableDictionary dictionaryWithObject:[request URL] forKey:NSURLErrorFailingURLStringErrorKey];
                [info setObject:@"Could not open connection" forKey:NSLocalizedDescriptionKey];
                NSError* error = [NSError errorWithDomain:@"HTTPDataLoad" code:1 userInfo:info];
                
                [[_sharedInstance delegate] httpDataLoad:_sharedInstance didFailWithError:error];
            }
        }
    }
    else
    {
        NSURLResponse* response = [[NSURLResponse alloc] init];
        NSError* error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
        [[_sharedInstance receivedData] appendData:data];
    }
}

#pragma mark -
#pragma mark NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    
    NSInteger count = [challenge previousFailureCount];
    if (count == 0)
    {
        NSURLCredential* credential =[NSURLCredential credentialWithUser:@"Username"
                                                                  password:@"Password"
                                                               persistence:NSURLCredentialPersistenceNone] ;
        [[challenge sender] useCredential:credential
               forAuthenticationChallenge:challenge];
    }
    else
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
        if ([[_sharedInstance delegate] respondsToSelector:@selector(httpDataLoadHasBadCredentials:)])
        {
            [[_sharedInstance delegate] httpDataLoadHasBadCredentials:_sharedInstance];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
    NSHTTPURLResponse  *httpResponse = (NSHTTPURLResponse *)response;
    self.headerFields = [httpResponse allHeaderFields];
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *mycookie in [cookieJar cookies]) {
        NSLog(@"%@ cookies:",mycookie);
    }
    
    int statusCode = [httpResponse statusCode];
    switch (statusCode)
    {
        case 200:
            
            if ([[_sharedInstance delegate] respondsToSelector:@selector(httpDataLoad:didReceiveStatusCode:)])
            {
                [[_sharedInstance delegate] httpDataLoad:_sharedInstance didReceiveStatusCode:statusCode];
            }
            break;
            
        case 201:
        {
            NSString* url = [[httpResponse allHeaderFields] objectForKey:@"Location"];
            if ([[_sharedInstance delegate] respondsToSelector:@selector(httpDataLoad:didCreateResourceAtURL:)])
            {
                [[_sharedInstance delegate] httpDataLoad:_sharedInstance didCreateResourceAtURL:url];
            }
            break;
        }
            
        default:
        {
            if ([[_sharedInstance delegate] respondsToSelector:@selector(httpDataLoad:didReceiveStatusCode:)])
            {
                [[_sharedInstance delegate] httpDataLoad:_sharedInstance didReceiveStatusCode:statusCode];
            }
            break;
        }
    }
    [[_sharedInstance receivedData]  setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [[_sharedInstance receivedData] appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [_sharedInstance cancelConnection];
    if ([[_sharedInstance delegate] respondsToSelector:@selector(httpDataLoad:didFailWithError:)])
    {
        [[_sharedInstance delegate] httpDataLoad:_sharedInstance didFailWithError:error];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_sharedInstance cancelConnection];
    if ([[_sharedInstance delegate] respondsToSelector:@selector(httpDataLoad:didRetrieveData: headers:)])
    {
        [[_sharedInstance delegate] httpDataLoad:_sharedInstance didRetrieveData:[_sharedInstance receivedData] headers:self.headerFields];
    }
}

@end
