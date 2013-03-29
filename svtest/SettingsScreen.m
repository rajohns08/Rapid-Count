#import "SettingsScreen.h"
#import <QuartzCore/QuartzCore.h>

@interface SettingsScreen ()

@end

@implementation SettingsScreen

// Synthesize all outlets
@synthesize sliderLabel;
@synthesize speedSlidePos;
@synthesize reset;

// Initialize the speed to 1.5
float savedSpeed = 1.5;

UISlider *slider;

-(IBAction)speedSlider:(id)sender {
    slider = (UISlider *) sender;
    
    [[NSUserDefaults standardUserDefaults] setFloat:slider.value forKey:@"savedSpeed"];
    savedSpeed = [[NSUserDefaults standardUserDefaults] floatForKey:@"savedSpeed"];
    slider.value = savedSpeed;
    
    // Set the slider label text to show the savedSpeed variable
    NSString *newLabel = [[NSString alloc]initWithFormat:@"%.02f", savedSpeed];
    sliderLabel.text = newLabel;
    
}

+(double)getSliderValue {
    return savedSpeed;
}

// Method for resetting the slider back to 1.5
-(IBAction)resetSettings:(id)sender {
    
    savedSpeed = 1.5;
    
    NSString *newLabel = [[NSString alloc]initWithFormat:@"%.02f", savedSpeed];
    sliderLabel.text = newLabel;
    
    speedSlidePos.value = savedSpeed;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Initialize the view of the slider
    NSString *newLabel = [[NSString alloc]initWithFormat:@"%.02f", savedSpeed];
    sliderLabel.text = newLabel;
    
    speedSlidePos.value = savedSpeed;
    
    // Set the gradient on the reset button
    NSArray *buttons = [NSArray arrayWithObjects: self.reset, nil];
    
    for(UIButton *btn in buttons)
    {
        // Set the button Text Color
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
        
        // Set default backgrond color
        [btn setBackgroundColor:[UIColor blackColor]];
        
        // Add Custom Font
        [[btn titleLabel] setFont:[UIFont fontWithName:@"Arial" size:20.0f]];
        
        // Draw a custom gradient
        CAGradientLayer *btnGradient = [CAGradientLayer layer];
        btnGradient.frame = btn.bounds;
        btnGradient.colors = [NSArray arrayWithObjects:
                              (id)[[UIColor colorWithRed:102.0f / 255.0f green:102.0f / 255.0f blue:102.0f / 255.0f alpha:1.0f] CGColor],
                              (id)[[UIColor colorWithRed:51.0f / 255.0f green:51.0f / 255.0f blue:51.0f / 255.0f alpha:1.0f] CGColor],
                              nil];
        [btn.layer insertSublayer:btnGradient atIndex:0];
        
        // Round button corners
        CALayer *btnLayer = [btn layer];
        [btnLayer setMasksToBounds:YES];
        [btnLayer setCornerRadius:5.0f];
        
        // Apply a 1 pixel, black border around Buy Button
        [btnLayer setBorderWidth:1.0f];
        [btnLayer setBorderColor:[[UIColor blackColor] CGColor]];
        
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blackGradient.png"]];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
