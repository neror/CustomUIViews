#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CounterView : UIView {
}

@property(assign) double number;

- (id)initWithNumber:(double)num;

@end
