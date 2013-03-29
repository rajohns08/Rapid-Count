#import <UIKit/UIKit.h>

@interface HomeScreen : UIViewController {
    
    UIButton *startCounting;                                                // 3 Buttons to navigate to different screens
    UIButton *howToCount;
    UIButton *settings;
}

@property(nonatomic, retain) IBOutlet UIButton *startCounting;
@property(nonatomic, retain) IBOutlet UIButton *howToCount;
@property(nonatomic, retain) IBOutlet UIButton *settings;

@end
