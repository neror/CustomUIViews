#import "ProgressBarView.h"

@implementation ProgressBarView

@synthesize progress;

- (void)setupLayers {
  self.progress = 1.f;
  progressBar_ = [[CAGradientLayer alloc] init];
  [self.layer addSublayer:progressBar_];
  [self addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:nil];
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

- (void)dealloc {
  [progressBar_ release];
  [self removeObserver:self forKeyPath:@"progress"];
  [super dealloc];
}

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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if([keyPath isEqualToString:@"progress"]) {
    [self setNeedsLayout];
  }
}

@end
