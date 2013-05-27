//
//  ViewController.m
//  svtest
//
//  Created by adam on 2/21/13.
//  Copyright (c) 2013 adam. All rights reserved.
//

#import "PlayScreen.h"
#import "SettingsScreen.h"
#import <QuartzCore/QuartzCore.h>
#include <stdlib.h>
@class SettingsScreen;


@interface PlayScreen ()

@end

@implementation PlayScreen

// sythesize all properties
@synthesize viewCard;
@synthesize countdown;

// global variable for determining if nstimer is currently actively displaying new cards
bool timerStarted = false;

// global variable for determining how many cards have been displayed. once this number
// reaches 52, then cancelTimer is called.
int numOfCards = 0;

// global variable for keeping track of the previous card that was shown. we don't want
// to display the same card twice in a row.
int previousNum = -1;

// global variable for keeping up with the card count
int cardCount = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.stopButton.hidden = YES;
    
    self.countdown.textColor = [UIColor cyanColor];
    
    // set the background image
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"table.png"]];
    
    // Set the gradient on the start button (make sure it is a custom button in storyboard)
    NSArray *buttons = [NSArray arrayWithObjects: self.startButton, self.stopButton, nil];
    
    for(UIButton *btn in buttons)
    {
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
    
}

// method for displaying the cards randomly to the user
-(void)click:(id)sender {

    // erase any text that might be shown behind the cards
    countdown.text = nil;
    
    // create a variable for a random number to be stored
    int num;
    
    // keep finding a new random number if the current number is the same as the previous one
    do {
        num = arc4random() % 52;
    } while (num == previousNum);
    
    // set the previous number to the one we have chosen this time
    previousNum = num;
    
    // the array is arranged in a way such that any index <= 19 contains the name of a card
    // that is of value 2-6, thus we need to add one to the count.
    if (num <= 19) {
        cardCount++;
    }
    // any card with index of > 31 we should subtract one from the count
    else if (num > 31) {
        cardCount--;
    }

    // remove the previous card from view
    [self.viewCard removeFromSuperview];
    
    // make a new space for the new card
    if ([self is4InchScreen]) {
        viewCard = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 420)];
    }
    else {
        viewCard = [[UIImageView alloc]initWithFrame:CGRectMake(34, 0, 250, 350)];
    }
    
    // an array of all the card name files
    NSArray *cardNames = [NSArray arrayWithObjects:
     @"2_of_clubs.png", @"2_of_spades.png", @"2_of_diamonds.png", @"2_of_hearts.png",
     @"3_of_clubs.png", @"3_of_spades.png", @"3_of_diamonds.png", @"3_of_hearts.png",
     @"4_of_clubs.png", @"4_of_spades.png", @"4_of_diamonds.png", @"4_of_hearts.png",
     @"5_of_clubs.png", @"5_of_spades.png", @"5_of_diamonds.png", @"5_of_hearts.png",
     @"6_of_clubs.png", @"6_of_spades.png", @"6_of_diamonds.png", @"6_of_hearts.png",
     @"7_of_clubs.png", @"7_of_spades.png", @"7_of_diamonds.png", @"7_of_hearts.png",
     @"8_of_clubs.png", @"8_of_spades.png", @"8_of_diamonds.png", @"8_of_hearts.png",
     @"9_of_clubs.png", @"9_of_spades.png", @"9_of_diamonds.png", @"9_of_hearts.png",
     @"10_of_clubs.png", @"10_of_spades.png", @"10_of_diamonds.png", @"10_of_hearts.png",
     @"jack_of_clubs.png", @"jack_of_spades.png", @"jack_of_diamonds.png", @"jack_of_hearts.png",
     @"queen_of_clubs.png", @"queen_of_spades.png", @"queen_of_diamonds.png", @"queen_of_hearts.png",
     @"king_of_clubs.png", @"king_of_spades.png", @"king_of_diamonds.png", @"king_of_hearts.png",
     @"ace_of_clubs.png", @"ace_of_spades.png", @"ace_of_diamonds.png", @"ace_of_hearts.png", nil];
    
    // set the image to a random index
    viewCard.image = [UIImage imageNamed:cardNames[num]];

    // do some aesthetic housekeeping
    viewCard.layer.masksToBounds = YES;
    viewCard.layer.cornerRadius = 10.0;
    viewCard.layer.borderWidth = 1.0;
    viewCard.layer.borderColor = [[UIColor blackColor] CGColor];
    
    // show the card
    [self.view addSubview:viewCard];
    
    // increment the variable each time a card is shown
    numOfCards++;
    
    // once a full deck has been simulated, cancel the nstimer so this function is called no more
    if (numOfCards > 1) {
        [self cancelTimer:nil];
        
        // animate the finished message after 52 cards
        countdown.text = @"Finished!";
        countdown.alpha = 0.0;
        [self.view bringSubviewToFront:countdown];
        [UIView animateWithDuration:3.0 animations:^(void)
         {
             countdown.alpha = 1.0;
         }];
    }

}

// method for setting up the nstimer to call the method that shows the cards
// this method is called by the start button.
-(IBAction)callTimer:(id)sender {
    
    // determine the amount of time the user wants between each new card
    double timerInterval;
    timerInterval = [SettingsScreen getSliderValue];
    
    // don't start another nstimer if one is already going
    if (!timerStarted) {
        [self startCountdown:nil];
        
        NSDate *d = [NSDate dateWithTimeIntervalSinceNow: 3];
        
        self->displayImageTimer = [[NSTimer alloc]initWithFireDate:d interval:timerInterval target:self selector:@selector(click:) userInfo:nil repeats:YES];
        
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer:displayImageTimer forMode: NSDefaultRunLoopMode];
        
        cardCount = 0;
        
    }
    
    // show that the timer is started. it can only be stopped in the cancelTimer method
    timerStarted = true;

}

// method for ending the nstimer either by user hitting stop, the cards finishing, or user hitting home
-(void)cancelTimer:(id)sender {
    
    // stop the timer
    [displayImageTimer invalidate];
    displayImageTimer = nil;
    
    // reset variables
    timerStarted = false;
    numOfCards = 0;
}

// method for displaying an alert box for showing the user the count
-(IBAction)showCount:(id)sender {
    
    [self cancelTimer:nil];
    
    self.startButton.hidden = NO;
    self.stopButton.hidden = YES;
    
    // create the message to be shown to the user
    NSString* cardCountStr = [NSString stringWithFormat:@"%i", cardCount];
    NSString* message = [NSString stringWithFormat:@"+%@", cardCountStr];
    
    // need logic to determine if the count is positive or negative, because if the count is positive
    // we need to also make sure the '+' sign is shown before the number
    if (cardCount <= 0) {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Count:" message: cardCountStr delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Count:" message: message delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert show];
    }
}

// method called when user presses start. it shows text on the screen
-(IBAction)startCountdown:(id)sender {
    
    // remove card that was previously shown (if there was one) when user hits start
    [self.viewCard removeFromSuperview];
    countdown.text = @"Get Ready";
    self.startButton.hidden = YES;
    self.stopButton.hidden = NO;
    
    // animate the get ready message
    countdown.alpha = 0.0;
    [UIView animateWithDuration:0.5 animations:^(void)
     {
         countdown.alpha = 1.0;
     }];
}

- (BOOL)is4InchScreen {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
