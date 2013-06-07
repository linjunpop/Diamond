//
//  TopicDetailsViewController.m
//  Diamond
//
//  Created by Jun Lin on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TopicDetailsViewController.h"

@interface TopicDetailsViewController ()
@property (strong, nonatomic) NSDictionary *topic;
- (void)displayTopic;
- (void)loadTopic;
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

    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [self loadTopic];

        dispatch_async( dispatch_get_main_queue(), ^{
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            [[self webView] loadHTMLString:self.topic[@"body_html"] baseURL:nil];
            [[self navigationItem] setTitle:self.topic[@"title"]];
            [MBProgressHUD hideHUDForView:self.webView animated:YES];
        });
    });
}

# pragma mark - Load Data

- (void) loadTopic {
    NSString* strUrl=[NSString stringWithFormat:@"http://ruby-china.org/api/topics/%@.json", self.topicID];

    NSURL *url=[NSURL URLWithString:strUrl];
    NSMutableURLRequest  *request=[[NSMutableURLRequest alloc] initWithURL:url];
    NSError *err=nil;
    NSData *jsonData=[NSURLConnection sendSynchronousRequest:request
                                           returningResponse:nil
                                                       error:&err];

    NSError *e = nil;
    self.topic = [NSJSONSerialization JSONObjectWithData: jsonData
                                                          options: NSJSONReadingMutableContainers
                                                            error: &e];
}

@end
