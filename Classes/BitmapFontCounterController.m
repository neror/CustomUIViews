#import "BitmapFontCounterController.h"
#import "CounterView.h"

@implementation BitmapFontCounterController

@synthesize textEntry;
@synthesize counterView;

- (void)viewDidLoad {
  self.title = @"Bitmap Font Counter";
  self.textEntry.text = @"12345";
  [self updateText];
  [super viewDidLoad];
}

- (void)dealloc {
  self.textEntry = nil;
  self.counterView = nil;
  [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated {
  [self.textEntry becomeFirstResponder];
}

#pragma mark -
#pragma mark Event Handlers

- (void)updateText {
  [self.counterView setNumber:[self.textEntry.text doubleValue]];
}

@end
