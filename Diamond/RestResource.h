//
//  Finder.h
//  Diamond
//
//  Created by Jun Lin on 6/7/13.
//
//

#import <Foundation/Foundation.h>

@protocol RestResource <NSObject>
@required
+ (void)findAllUsingBlock:(void (^)(NSArray *objects, NSError *error))block;
+ (void)findOneById:(NSNumber *)id usingBlock:(void (^)(id object, NSError *error))block;
@end
