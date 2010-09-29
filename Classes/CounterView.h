#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CounterView : UIView {
  double number_;
  NSMutableArray *digitLayers_;
}

@property(assign) double number;

- (id)initWithNumber:(double)num;
- (CALayer *)layerForDigitAtIndex:(NSUInteger)index;

@end
