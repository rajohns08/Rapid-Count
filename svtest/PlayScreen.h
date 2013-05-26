//
//  ViewController.h
//  svtest
//
//  Created by adam on 2/21/13.
//  Copyright (c) 2013 adam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayScreen : UIViewController {
    // outlet needed for cards to show
    UIImageView *viewCard;
    
    // outlet for the nstimer used to call a new card every x seconds
    NSTimer *displayImageTimer;
    
    // countdown label to show something before cards start 
    UILabel *countdown;
}

// properties for all outlets
@property(nonatomic, retain) IBOutlet UIImageView *viewCard;
@property(nonatomic, retain) IBOutlet UILabel *countdown;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

// method called by nstimer every x seconds. handles displaying the cards
-(void)click:(id)sender;

// this function is called by the start button, to only call the timer if the
// timer is not already started
-(IBAction)callTimer:(id)sender;

// this function is called by the stop button, as well as when the cards are finished displaying,
// and it is also called when hitting the home button from the play screen.
-(void)cancelTimer:(id)sender;

// this function is called by the show count button to display the count at any moment
-(IBAction)showCount:(id)sender;

// the second method called by the start button. it is used to display the countdown label
// to show something before the cards start
-(IBAction)startCountdown:(id)sender;

// checks to see if device is a 4 inch screen
-(BOOL)is4InchScreen;

@end
