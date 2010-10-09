#import "ProgressBarViewController.h"
#import "ProgressBarView.h"

@implementation ProgressBarViewController

@synthesize progressBar;

- (void)updateProgress {
  self.progressBar.progress = (abs(arc4random()) % 100) / 100.f;
}

- (void)dealloc {
  self.progressBar = nil;
  [super dealloc];
}


@end
