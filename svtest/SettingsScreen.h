#import <UIKit/UIKit.h>

@interface SettingsScreen : UIViewController {
    
    // Outlet for the number above the slider
    UILabel *sliderLabel;
    
    // Outlet for the position of the slider
    UISlider *speedSlidePos;
    
    // A button to reset the slider to the default (1.5) position
    UIButton *reset;
    
}

// Properties for outlets
@property(nonatomic, retain) IBOutlet UILabel *sliderLabel;
@property(nonatomic, retain) IBOutlet UISlider *speedSlidePos;
@property(nonatomic, retain) IBOutlet UIButton *reset;

// Method for getting the slider value
+(double)getSliderValue;

// Method for 
-(IBAction)speedSlider:(id)sender;
-(IBAction)resetSettings:(id)sender;

@end
