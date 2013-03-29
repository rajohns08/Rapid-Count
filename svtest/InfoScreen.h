//
//  InfoScreen.h
//  svtest
//
//  Created by adam on 3/6/13.
//  Copyright (c) 2013 adam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoScreen : UIViewController {
    
    // Add a scrolling outlet to the info screen
    UIScrollView *infoScroll;
}

@property(nonatomic, retain) IBOutlet UIScrollView *infoScroll;

@end
