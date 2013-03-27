//
//  HomeScreen.h
//  svtest
//
//  Created by adam on 3/6/13.
//  Copyright (c) 2013 adam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeScreen : UIViewController {
    
    UIButton *startCounting;
    UIButton *howToCount;
    UIButton *settings;
    UIImageView *rapidLogo;
    UIImageView *countLogo;
}

@property(nonatomic, retain) IBOutlet UIButton *startCounting;
@property(nonatomic, retain) IBOutlet UIButton *howToCount;
@property(nonatomic, retain) IBOutlet UIButton *settings;
@property(nonatomic, retain) IBOutlet UIImageView *rapidLogo;
@property(nonatomic, retain) IBOutlet UIImageView *countLogo;

@end
