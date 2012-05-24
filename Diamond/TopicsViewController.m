//
//  TopicsViewController.m
//  Diamond
//
//  Created by Jun Lin on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TopicsViewController.h"
#import "TopicDetailsViewController.h"

@interface TopicsViewController ()

@property (nonatomic) NSMutableArray *topics;

- (void)reloadTopics;

@end

@implementation TopicsViewController

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
    [self reloadTopics];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:nil];
    }
    
    NSDictionary *topicInfo = [self.topics objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [topicInfo objectForKey:@"title"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"User: %@ -- Node: %@",
                                 [[topicInfo objectForKey:@"user"] objectForKey:@"login"],
                                 [topicInfo objectForKey:@"node_name"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showTopicDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showTopicDetails"]) {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        NSDictionary *topicInfo = [self.topics objectAtIndex:selectedRowIndex.row];
        TopicDetailsViewController *topicDetailViewController = [segue destinationViewController];
        [topicDetailViewController setBodyText:[topicInfo objectForKey:@"body"]];
    }
}

- (IBAction)refresh:(id)sender {
    [self reloadTopics];
}

#pragma mark - Private Methods

- (void) reloadTopics {
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self setTopics:[TopicModel all]];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            if ([self topics]) {
                [self.tableView reloadData];
            }
        });
    });
}

@end
