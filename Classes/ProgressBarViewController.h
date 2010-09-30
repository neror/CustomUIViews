#import <UIKit/UIKit.h>

@class ProgressBarView;

@interface ProgressBarViewController : UIViewController {

}

@property (nonatomic,retain) IBOutlet ProgressBarView *progressBar;

- (IBAction)updateProgress;

@end
