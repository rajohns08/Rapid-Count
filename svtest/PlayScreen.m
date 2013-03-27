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
@synthesize displayImageTimer;
@synthesize home;
@synthesize showCount;
@synthesize stop;
@synthesize start;

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

// method for displaying the cards randomly to the user
-(IBAction)click:(id)sender {

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
    viewCard = [[UIImageView alloc]initWithFrame:CGRectMake(34, 27, 250, 350)];
    
    // an array of all the card name files
    NSArray *cardNames = [NSArray arrayWithObjects:
     @"2-club.png", @"2-spade.png", @"2-diamond.png", @"2-heart.png",
     @"3-club.png", @"3-spade.png", @"3-diamond.png", @"3-heart.png",
     @"4-club.png", @"4-spade.png", @"4-diamond.png", @"4-heart.png",
     @"5-club.png", @"5-spade.png", @"5-diamond.png", @"5-heart.png",
     @"6-club.png", @"6-spade.png", @"6-diamond.png", @"6-heart.png",
     @"7-club.png", @"7-spade.png", @"7-diamond.png", @"7-heart.png",
     @"8-club.png", @"8-spade.png", @"8-diamond.png", @"8-heart.png",
     @"9-club.png", @"9-spade.png", @"9-diamond.png", @"9-heart.png",
     @"10-club.png", @"10-spade.png", @"10-diamond.png", @"10-heart.png",
     @"jack-clubs.png", @"jack-spades.png", @"jack-diamonds.png", @"jack-hearts.png",
     @"queen-clubs.png", @"queen-spades.png", @"queen-diamonds.png", @"queen-hearts.png",
     @"king-clubs.png", @"king-spades.png", @"king-diamonds.png", @"king-hearts.png",
     @"ace-clubs.jpg", @"ace-spades.jpg", @"ace-diamonds.jpg", @"ace-hearts.jpg", nil];
    
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
    if (numOfCards > 52) {
        [self cancelTimer:nil];
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
        
        self.displayImageTimer = [[NSTimer alloc]initWithFireDate:d interval:timerInterval target:self selector:@selector(click:) userInfo:nil repeats:YES];
        
        NSRunLoop *runner = [NSRunLoop currentRunLoop];
        [runner addTimer:displayImageTimer forMode: NSDefaultRunLoopMode];
        
//        self.displayImageTimer = [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(click:) userInfo:nil repeats:YES];
        
        cardCount = 0;
        
    }
    
    // show that the timer is started. it can only be stopped in the cancelTimer method
    timerStarted = true;

}

// method for ending the nstimer either by user hitting stop, the cards finishing, or user hitting home
-(IBAction)cancelTimer:(id)sender {
    
    // stop the timer
    [displayImageTimer invalidate];
    displayImageTimer = nil;
    
    // reset variables
    timerStarted = false;
    numOfCards = 0;
    
    // remove the last card from view
    [self.viewCard removeFromSuperview];
    
    // clear any text
    countdown.text = nil;
    
}

// method for displaying an alert box for showing the user the count
-(IBAction)showCount:(id)sender {
    
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
    
    countdown.text = @"Get Ready";
}

// method called when user presses home button
-(IBAction)goToHomeScreen:(id)sender {
    
    // first cancel the timer and reset everything
    [self cancelTimer:nil];
    
    // next call the segue for swapping screens back to the home screen. normally segues attached to
    // buttons don't perform any user defined action, so since I needed cancelTimer to be called, I
    // had to create a segue from one viewcontroller to the other instead of from a button. This allowed
    // me to create an identifier for the segue and call it here after cancelTimer has been called.
    [self performSegueWithIdentifier:@"playToHome" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // set the background image
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"table.png"]];
    
    // set the button attributes on the bottom toolbar
    [home setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12], UITextAttributeFont,nil] forState:UIControlStateNormal];
    
    [showCount setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12], UITextAttributeFont,nil] forState:UIControlStateNormal];

    [stop setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12], UITextAttributeFont,nil] forState:UIControlStateNormal];
    
    [start setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12], UITextAttributeFont,nil] forState:UIControlStateNormal];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
