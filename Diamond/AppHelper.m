//
//  AppHelper.m
//  Diamond
//
//  Created by Jun Lin on 6/7/13.
//
//

#import "AppHelper.h"
#import "UserModel.h"
#import "TopicModel.h"
#import "NodeModel.h"

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
    // Topic
    RKObjectMapping *topicMapping = [ RKObjectMapping mappingForClass:[TopicModel class]];
    [topicMapping addAttributeMappingsFromDictionary:@{
        @"id": @"id",
        @"title": @"title",
        @"user.login": @"userLoginName",
        @"node_name": @"nodeName",
        @"body_html": @"bodyHtml",
     }];
    [manager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:topicMapping
                                                                           pathPattern:nil
                                                                               keyPath:nil
                                                                           statusCodes:nil]];

    // Node
    RKObjectMapping *nodeMapping = [ RKObjectMapping mappingForClass:[NodeModel class]];
    [nodeMapping addAttributeMappingsFromDictionary:@{
        @"name": @"name"
     }];
    [manager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:nodeMapping
                                                                           pathPattern:nil
                                                                               keyPath:nil
                                                                           statusCodes:nil]];

    [RKObjectManager setSharedManager:manager];
}

@end