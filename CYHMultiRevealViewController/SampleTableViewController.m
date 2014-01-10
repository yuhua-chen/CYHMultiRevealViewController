//
//  SampleTableViewController.m
//  CYHMultiRevealViewController
//
//  Created by Mike.Chen on 2014/1/10.
//  Copyright (c) 2014年 yuhua. All rights reserved.
//

#import "SampleTableViewController.h"
#import "AppDelegate.h"

@interface SampleTableViewController ()

@property(nonatomic,strong) NSMutableArray *data;

@end

static NSString *CellIdentifier = @"Cell";

@implementation SampleTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
        
        self.data = [NSMutableArray new];
        
        for (int i=0; i< 20 ; i++) {
            [self.data addObject:[NSString stringWithFormat:@"群組 %i", i]];
        }
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithWhite:(float)self.view.tag/5.0f alpha:1.0f];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.data objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SampleTableViewController *tableViewController = [[SampleTableViewController alloc] init];
    tableViewController.view.tag = self.view.tag+1;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    [appDelegate.viewController.revealViewController pushViewController:tableViewController];
}

@end
