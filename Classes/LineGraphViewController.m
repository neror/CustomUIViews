#import "LineGraphViewController.h"
#import "LineGraphView.h"

@implementation LineGraphViewController

@synthesize lineGraph;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Line Graph";
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
  [self updateValues];
}


- (void)dealloc {
  self.lineGraph = nil;
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
