//
//  BaseModel.m
//  Diamond
//
//  Created by Jun Lin on 6/7/13.
//
//

#import "BaseModel.h"
#import "NSString+InflectorKit.h"

@implementation BaseModel

+ (NSString *) resourceName {
    return [[NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"Model" withString:@""] lowercaseString];
}

+ (void)findAllUsingBlock:(void (^)(NSArray *objects, NSError *error))block {
    [[RKObjectManager sharedManager] getObjectsAtPath:[NSString stringWithFormat:@"%@.json", [self.resourceName pluralizedString]]
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  NSArray *result = [mappingResult array];
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      block(result, nil);
                                                  });
                                              }

                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      block(nil, error);
                                                  });
                                              }];
}

+ (void)findOneById:(NSNumber *)id usingBlock:(void (^)(id, NSError *))block {
    [[RKObjectManager sharedManager] getObjectsAtPath:[NSString stringWithFormat:@"%@/%@.json", [self.resourceName pluralizedString], id] parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  BaseModel *result = [mappingResult firstObject];
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      block(result, nil);
                                                  });
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      block(nil, error);
                                                  });
                                              }];
}

@end
