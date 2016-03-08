//
//  STOCommonUtility.m
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import "STOCommonUtility.h"

@implementation STOCommonUtility

+(NSString *) extractFullWebPathFromInputFile:(NSString*) inputFile byAppendingParams:(NSArray*) requestParams {
    // Pull in our JSON file that describes this request
    NSString            *inputFilePath      = [ [NSBundle mainBundle] pathForResource: inputFile
                                                                               ofType: @"in"];
    NSString            *inputString        = [ [NSString alloc] initWithContentsOfFile: inputFilePath
                                                                               encoding: NSUTF8StringEncoding
                                                                                  error: NULL];
    // Turn it into a dictionary that we can work with
    NSData              *inputData          = [inputString dataUsingEncoding:NSUTF8StringEncoding];
    NSError             *parsingError       = nil;
    NSDictionary        *inputDictionary    = [NSJSONSerialization JSONObjectWithData: inputData
                                                                              options: 0
                                                                                error: &parsingError];
    // Construct the URL to send the request to
    NSString            *host               = [NSString stringWithString: [inputDictionary objectForKey: @"host"] ];
    NSString            *requestUrl         = [NSString stringWithString: [inputDictionary objectForKey: @"request-url"] ];
    
    for (NSString* param in requestParams) {
        requestUrl = [requestUrl stringByAppendingFormat:@"/%@", param];
    }
    
    NSString            *finalPath          = [host stringByAppendingString: requestUrl];
    //    NSLog (@"finalWebURL: %@", finalPath);
    
    return finalPath;
}

+(NSDictionary *) extractJsonFromInputFile:(NSString*) inputFile {
    // Pull in our JSON file that describes this request
    NSString            *inputFilePath      = [ [NSBundle mainBundle] pathForResource: inputFile
                                                                               ofType: @"in"];
    NSString            *inputString        = [ [NSString alloc] initWithContentsOfFile: inputFilePath
                                                                               encoding: NSUTF8StringEncoding
                                                                                  error: NULL];
    // Turn it into a dictionary that we extract a valid response from
    NSData              *inputData          = [inputString dataUsingEncoding:NSUTF8StringEncoding];
    NSError             *parsingError       = nil;
    NSDictionary        *inputDictionary    = [NSJSONSerialization JSONObjectWithData: inputData
                                                                              options: 0
                                                                                error: &parsingError];
    if (parsingError != nil) {
        return nil;
    } else {
        return inputDictionary;
    }
}



@end
