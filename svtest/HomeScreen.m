//
//  HomeScreen.m
//  svtest
//
//  Created by adam on 3/6/13.
//  Copyright (c) 2013 adam. All rights reserved.
//

#import "HomeScreen.h"
#import <QuartzCore/QuartzCore.h>


@interface HomeScreen ()

@end

@implementation HomeScreen

@synthesize startCounting;
@synthesize howToCount;
@synthesize settings;
@synthesize rapidLogo;
@synthesize countLogo;

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
    
    NSArray *buttons = [NSArray arrayWithObjects: self.startCounting, self.howToCount, self.settings, nil];
    
    for(UIButton *btn in buttons)
    {
        
        // BEGIN WORKING FROM TUTORIAL HERE
        
        // Set the button Text Color
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
        
        // Set default backgrond color
        [btn setBackgroundColor:[UIColor blackColor]];
        
        // Add Custom Font
        [[btn titleLabel] setFont:[UIFont fontWithName:@"Arial" size:20.0f]];
        
        // Draw a custom gradient
        CAGradientLayer *btnGradient = [CAGradientLayer layer];
        btnGradient.frame = btn.bounds;
        btnGradient.colors = [NSArray arrayWithObjects:
                              (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                              (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                              nil];
        [btn.layer insertSublayer:btnGradient atIndex:0];
        
        // Round button corners
        CALayer *btnLayer = [btn layer];
        [btnLayer setMasksToBounds:YES];
        [btnLayer setCornerRadius:5.0f];
        
        // Apply a 1 pixel, black border around Buy Button
        [btnLayer setBorderWidth:1.0f];
        [btnLayer setBorderColor:[[UIColor blackColor] CGColor]];
        
    }
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blackGradient.png"]];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"table.png"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
