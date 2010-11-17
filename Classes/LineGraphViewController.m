#import "LineGraphViewController.h"
#import "LineGraphView.h"

@implementation LineGraphViewController

@synthesize lineGraph;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Line Graph";
}

- (void)viewDidAppear:(BOOL)animated {
  [self updateValues];
}

- (void)dealloc {
  [lineGraph release];
  [super dealloc];
}

- (void)updateValues {
  self.lineGraph.values = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:(CGFloat)(abs(arc4random()) % 100) / 100.f], 
                           [NSNumber numberWithFloat:(CGFloat)(abs(arc4random()) % 100) / 100.f], 
                           [NSNumber numberWithFloat:(CGFloat)(abs(arc4random()) % 100) / 100.f], 
                           [NSNumber numberWithFloat:(CGFloat)(abs(arc4random()) % 100) / 100.f], 
                           [NSNumber numberWithFloat:(CGFloat)(abs(arc4random()) % 100) / 100.f], nil];
}


@end
