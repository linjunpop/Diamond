//
//  TopicModel.h
//  Diamond
//
//  Created by Jun Lin on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface TopicModel : BaseModel

@property NSNumber *id;
@property NSString *title;
@property NSString *userLoginName;
@property NSString *nodeName;
@property NSString *bodyHtml;

@end
