//
//  TopicDetailsViewController.m
//  Diamond
//
//  Created by Jun Lin on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TopicDetailsViewController.h"

@interface TopicDetailsViewController ()
- (void)displayTopic;
@end

@implementation TopicDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self displayTopic];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)displayTopic {
    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    [TopicModel findOneById:self.topicID usingBlock:^(TopicModel *topic, NSError *error) {
        if (!error) {
            [[self webView] loadHTMLString:topic.bodyHtml baseURL:nil];
            [[self navigationItem] setTitle:topic.title];
        }
        [MBProgressHUD hideHUDForView:self.webView animated:YES];
    }];
}

@end
