#import "LineGraphView.h"
#import <QuartzCore/QuartzCore.h>

@interface LineGraphView() {
  NSArray *values_;
}

- (UIBezierPath *)bezierPathWithValues:(NSArray *)theValues zeroedY:(BOOL)zeroedY;
- (void)animateGraphChange;

@end

@implementation LineGraphView

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
  [values_ release], values_ = nil;
  [super dealloc];
}

#pragma mark -
#pragma mark Attribute getters and setters

- (NSArray *)values {
  return [[values_ copy] autorelease];
}

- (void)setValues:(NSArray *)newValues {
  [values_ autorelease];
  values_ = [newValues copy];
  [self animateGraphChange];
}

- (UIBezierPath *)bezierPathWithValues:(NSArray *)theValues zeroedY:(BOOL)zeroedY {
  if([theValues count]) {
    CGRect insetRect = CGRectInset(self.bounds, 10.f, 0.f);
    
    CGFloat pointXOffset = insetRect.size.width / ([theValues count] - 1);
    CGFloat height = insetRect.size.height;
    CGFloat xOrigin = insetRect.origin.x;
    CGFloat firstValue = [[theValues objectAtIndex:0] floatValue];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat nextY = zeroedY ? 0 : (height * firstValue);
    [path moveToPoint:CGPointMake(xOrigin, height - nextY)];
    
    for (int i = 1; i < [theValues count]; i++) {
      CGFloat value = [[theValues objectAtIndex:i] floatValue];
      nextY = zeroedY ? 0 : (height * value);
      [path addLineToPoint:CGPointMake(xOrigin + (i * pointXOffset), height - nextY)];
    }
    return path;
  }
  return nil;
}


- (void)animateGraphChange {
  CAShapeLayer *theLayer = (CAShapeLayer *)self.layer;
  
  UIBezierPath *thePath = [self bezierPathWithValues:self.values zeroedY:NO];
  
  CABasicAnimation *animatePath = [CABasicAnimation animationWithKeyPath:@"path"];
  
  if(!theLayer.path) {
    UIBezierPath *zeroedPath = [self bezierPathWithValues:self.values zeroedY:YES];  
    animatePath.fromValue = (id)[zeroedPath CGPath];
  } else {
    animatePath.fromValue = (id)[[theLayer presentationLayer] path];
  }
  
  animatePath.toValue = (id)[thePath CGPath];
  animatePath.duration = .5f;
  animatePath.fillMode = kCAFillModeForwards;
  animatePath.removedOnCompletion = NO;
  animatePath.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  
  theLayer.path = [thePath CGPath];
  [theLayer addAnimation:animatePath forKey:@"path"];
}

@end
