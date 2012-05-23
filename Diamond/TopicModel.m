//
//  TopicModel.m
//  Diamond
//
//  Created by Jun Lin on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel

+(NSMutableArray *) all {
    NSString* strUrl=@"http://ruby-china.org/api/topics";
    
    NSURL *url=[NSURL URLWithString:strUrl];
    NSMutableURLRequest  *request=[[NSMutableURLRequest alloc] initWithURL:url];      
    NSError *err=nil;    
    NSData *jsonData=[NSURLConnection sendSynchronousRequest:request
                                           returningResponse:nil
                                                       error:&err];
    
    NSError *e = nil;
    return [NSJSONSerialization JSONObjectWithData: jsonData
                                           options: NSJSONReadingMutableContainers
                                             error: &e];
    
}

@end
