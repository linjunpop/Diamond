//
//  TopicDetailsViewController.h
//  Diamond
//
//  Created by Jun Lin on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) NSString *bodyText;

@end