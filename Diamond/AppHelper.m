//
//  AppHelper.m
//  Diamond
//
//  Created by Jun Lin on 6/7/13.
//
//

#import "AppHelper.h"
#import "UserModel.h"

@implementation AppHelper

+ (void)setRestMappings
{
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://ruby-china.org/api/"]];

    // User
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[UserModel class]];
    [userMapping addAttributeMappingsFromDictionary:@{ @"login": @"loginName" }];
    [manager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:userMapping
                                                                           pathPattern:nil
                                                                               keyPath:nil
                                                                           statusCodes:nil]];

    [RKObjectManager setSharedManager:manager];
}

@end
