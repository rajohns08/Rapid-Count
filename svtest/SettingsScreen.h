//
//  SettingsScreen.h
//  svtest
//
//  Created by adam on 3/6/13.
//  Copyright (c) 2013 adam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsScreen : UIViewController {
    UILabel *sliderLabel;
    UISlider *speedSlidePos;
    UIButton *reset;
    
}

@property(nonatomic, retain) IBOutlet UILabel *sliderLabel;
@property(nonatomic, retain) IBOutlet UISlider *speedSlidePos;
@property(nonatomic, retain) IBOutlet UIButton *reset;

+(double)getSliderValue;

-(IBAction)speedSlider:(id)sender;
-(IBAction)resetSettings:(id)sender;

@end
