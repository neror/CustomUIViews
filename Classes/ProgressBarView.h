#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ProgressBarView : UIView {
  CAGradientLayer *progressBar_;
}


@property (assign) CGFloat progress;

@end
