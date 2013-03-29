#import <UIKit/UIKit.h>

@interface HomeScreen : UIViewController {
    
    // 3 buttons to navigate to different screens
    UIButton *startCounting;
    UIButton *howToCount;
    UIButton *settings;
}

// Properties for 3 buttons
@property(nonatomic, retain) IBOutlet UIButton *startCounting;
@property(nonatomic, retain) IBOutlet UIButton *howToCount;
@property(nonatomic, retain) IBOutlet UIButton *settings;

@end
