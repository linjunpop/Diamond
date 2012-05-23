//
//  TopicViewController.m
//  Diamond
//
//  Created by Jun Lin on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TopicViewController.h"

@interface TopicViewController ()

- (Boolean) fetch;

@end

@implementation TopicViewController

@synthesize tableView = _tableView;
@synthesize topics = _topics;

#pragma mark View Lifecycle

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
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self topics] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:nil];
    }
    
    NSDictionary *userInfo = [self.topics objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [userInfo objectForKey:@"title"];
    
    return cell;
}

- (IBAction)refresh:(id)sender {
    if ([self fetch]) {
        [self.tableView reloadData];
    }
}

- (Boolean)fetch {
    NSString* strUrl=@"http://ruby-china.org/api/topics";
    
    NSURL *url=[NSURL URLWithString:strUrl];
	NSMutableURLRequest  *request=[[NSMutableURLRequest alloc] initWithURL:url];      
    NSError *err=nil;    
    NSData *jsonData=[NSURLConnection sendSynchronousRequest:request
                                           returningResponse:nil
                                                       error:&err];
    
    NSError *e = nil;
    [self setTopics:[NSJSONSerialization JSONObjectWithData: jsonData
                                                    options: NSJSONReadingMutableContainers
                                                      error: &e]];
    if([self topics]) {
        return true;
    } else {
        return false;
    }
}
@end
