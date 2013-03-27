//
//  InfoScreen.m
//  svtest
//
//  Created by adam on 3/6/13.
//  Copyright (c) 2013 adam. All rights reserved.
//

#import "InfoScreen.h"

@interface InfoScreen ()

@end

@implementation InfoScreen

@synthesize infoScroll;

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
    
    [infoScroll setScrollEnabled:YES];
    [infoScroll setContentSize:CGSizeMake(320, 10000)];
    [infoScroll setAlwaysBounceVertical:YES];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blackGradient.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
