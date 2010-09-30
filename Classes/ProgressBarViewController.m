#import "ProgressBarViewController.h"
#import "ProgressBarView.h"

@implementation ProgressBarViewController

@synthesize progressBar;

- (void)updateProgress {
  self.progressBar.progress = .75f;
}

- (void)dealloc {
  self.progressBar = nil;
  [super dealloc];
}


@end
