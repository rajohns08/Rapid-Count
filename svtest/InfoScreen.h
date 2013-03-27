//
//  InfoScreen.h
//  svtest
//
//  Created by adam on 3/6/13.
//  Copyright (c) 2013 adam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoScreen : UIViewController {
    UIScrollView *infoScroll;
}

@property(nonatomic, retain) IBOutlet UIScrollView *infoScroll;

@end
