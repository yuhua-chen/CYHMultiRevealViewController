//
//  ViewController.m
//  CYHMultiRevealViewController
//
//  Created by Mike.Chen on 2014/1/10.
//  Copyright (c) 2014年 yuhua. All rights reserved.
//

#import "ViewController.h"
#import "SampleTableViewController.h"

@interface ViewController ()
@end

@implementation ViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -
- (IBAction)showView:(id)sender
{
    if( !self.revealViewController ){
        
        
        self.revealViewController = [[CYHMultiRevealViewController alloc] initWithView:self.view
                                                                    andViewControllers:nil];
        
        UIButton *button = (UIButton *)sender;
        [button setTitle:@"Push it!" forState:UIControlStateNormal];
    } else {
        SampleTableViewController *tableViewController = [[SampleTableViewController alloc] init];
        tableViewController.view.tag = 1;
        [self.revealViewController pushViewController:tableViewController];
    }
    
}

@end
