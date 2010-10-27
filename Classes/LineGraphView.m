#import "LineGraphView.h"
#import <QuartzCore/QuartzCore.h>

@implementation LineGraphView

@synthesize values;

+ (Class)layerClass {
  return [CAShapeLayer class];
}

- (void)setupView {
  CAShapeLayer *theLayer = (CAShapeLayer *)self.layer;
  theLayer.needsDisplayOnBoundsChange = YES;
  theLayer.lineWidth = 8.f;
  theLayer.lineCap = kCALineCapRound;
  theLayer.lineJoin = kCALineJoinRound;
  theLayer.strokeColor = [[UIColor blueColor] CGColor];
  theLayer.fillColor = nil;
  [self addObserver:self forKeyPath:@"values" options:NSKeyValueObservingOptionNew context:nil];
}

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    [self setupView];
  }
  return self;
}

- (void)awakeFromNib {
  [self setupView];  
}

- (void)dealloc {
  [self removeObserver:self forKeyPath:@"values"];
  [values release];
  [super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if([keyPath isEqualToString:@"values"] && object == self) {
    [self setNeedsLayout];
  }
}

- (CGPathRef)newPathFromValuesWithZeroedY:(BOOL)zeroedY {
  if([self.values count]) {
    CGRect insetRect = CGRectInset(self.bounds, 10.f, 0.f);
    
    CGFloat pointXOffset = insetRect.size.width / ([self.values count] - 1);
    CGFloat height = insetRect.size.height;
    CGFloat xOrigin = insetRect.origin.x;
    CGFloat firstValue = [[self.values objectAtIndex:0] floatValue];
    
    CGMutablePathRef line = CGPathCreateMutable();
    CGFloat nextY = zeroedY ? 0 : (height * firstValue);
    CGPathMoveToPoint(line, NULL, xOrigin, height - nextY);
    for (int i = 1; i < [self.values count]; i++) {
      CGFloat value = [[self.values objectAtIndex:i] floatValue];
      nextY = zeroedY ? 0 : (height * value);
      CGPathAddLineToPoint(line, NULL, xOrigin + (i * pointXOffset), height - nextY);
    }
    return line;
  }
  return nil;
}

- (void)layoutSubviews {
  CAShapeLayer *theLayer = (CAShapeLayer *)self.layer;
  
  CGPathRef thePath = [self newPathFromValuesWithZeroedY:NO];
  
  [CATransaction begin];
  [CATransaction setCompletionBlock:^{
    theLayer.path = thePath;
    CGPathRelease(thePath);
  }];
  [CATransaction setDisableActions:YES];
  CABasicAnimation *animatePath = [CABasicAnimation animationWithKeyPath:@"path"];

  if(!theLayer.path) {
    CGPathRef zeroedPath = [self newPathFromValuesWithZeroedY:YES];  
    animatePath.fromValue = (id)zeroedPath;
    CGPathRelease(zeroedPath);
  }
  
  animatePath.toValue = (id)thePath;
  animatePath.duration = .5f;
  animatePath.fillMode = kCAFillModeForwards;
  animatePath.removedOnCompletion = NO;
  animatePath.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  [self.layer addAnimation:animatePath forKey:@"lineAnimation"];
  [CATransaction commit];
}  


@end
