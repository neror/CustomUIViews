#import <UIKit/UIKit.h>

@class CounterView;

@interface BitmapFontCounterController : UIViewController {
  
}

@property (nonatomic, retain) IBOutlet UITextField *textEntry;
@property (nonatomic, retain) IBOutlet CounterView *counterView;

- (IBAction)updateText;

@end
