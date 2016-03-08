//
//  STOCommonUtility.h
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STOCommonUtility : NSObject

+(NSString *) extractFullWebPathFromInputFile:(NSString*) inputFile byAppendingParams:(NSArray*) requestParams;
+(NSDictionary *) extractJsonFromInputFile:(NSString*) inputFile;


@end
