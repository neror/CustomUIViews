#import <UIKit/UIKit.h>

@class LineGraphView;

@interface LineGraphViewController : UIViewController {
}

@property (nonatomic, retain) IBOutlet LineGraphView *lineGraph;

- (IBAction)updateValues;

@end
