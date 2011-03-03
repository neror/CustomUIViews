#import "ProgressBarView.h"

@interface ProgressBarView() {
  CAGradientLayer *progressBar_;
  CGFloat progress_;
}

- (void)setupLayers;

@end

@implementation ProgressBarView

#pragma mark - Object Lifecycle / Memory management

- (void)dealloc {
  [progressBar_ release];
  [super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    [self setupLayers];
  }
  return self;
}

- (void)awakeFromNib {
  [self setupLayers];
}

- (void)setupLayers {
  self.progress = 1.f;
  progressBar_ = [[CAGradientLayer alloc] init];
  [self.layer addSublayer:progressBar_];
}

#pragma mark - Drawing and Layout

- (void)layoutSubviews {
  self.backgroundColor = [UIColor clearColor];
  self.layer.borderColor = [[UIColor blackColor] CGColor];
  self.layer.borderWidth = 1.f;
  self.layer.cornerRadius = 12.f;
  self.layer.masksToBounds = YES;
  
  progressBar_.colors = [NSArray arrayWithObjects:
                         (id)[[UIColor blueColor] CGColor], 
                         (id)[[UIColor colorWithHue:.6f saturation:.8f brightness:1.f alpha:1.f] CGColor],
                         (id)[[UIColor blueColor] CGColor], nil];
  progressBar_.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.f],
                            [NSNumber numberWithFloat:.5f],
                            [NSNumber numberWithFloat:1.f], nil];
  progressBar_.anchorPoint = CGPointZero;
  
  CGRect progressBounds = self.bounds;
  progressBounds.size.width *= self.progress;
  progressBar_.bounds = progressBounds;
}

#pragma mark - Getters and Setters

- (CGFloat)progress {
  return progress_;
}

- (void)setProgress:(CGFloat)progress {
  progress_ = progress;
  [self setNeedsLayout];
}

@end
