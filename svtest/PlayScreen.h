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
    
    // bar button item outlets created so their size can be adjustable
    // these are the buttons displayed on the bottom toolbar of the play screen
    UIBarButtonItem *home;
    UIBarButtonItem *showCount;
    UIBarButtonItem *stop;
    UIBarButtonItem *start;
}

// properties for all outlets
@property(nonatomic, retain) IBOutlet UIImageView *viewCard;
@property(nonatomic, retain) IBOutlet NSTimer *displayImageTimer;
@property(nonatomic, retain) IBOutlet UILabel *countdown;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *home;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *showCount;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *stop;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *start;

// method called by nstimer every x seconds. hanldes displaying the cards
-(IBAction)click:(id)sender;

// this function is called by the start button, to only call the timer if the
// timer is not already started
-(IBAction)callTimer:(id)sender;

// this function is called by the stop button, as well as when the cards are finished displaying,
// and it is also called when hitting the home button from the play screen.
-(IBAction)cancelTimer:(id)sender;

// this function is called by the show count button to display the count at any moment
-(IBAction)showCount:(id)sender;

// the second method called by the start button. it is used to display the countdown label
// to show something before the cards start
-(IBAction)startCountdown:(id)sender;

// calls cancelTimer and then performs screen swapping segue
-(IBAction)goToHomeScreen:(id)sender;

@end
