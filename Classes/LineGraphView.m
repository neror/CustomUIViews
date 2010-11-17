#import "LineGraphView.h"
#import <QuartzCore/QuartzCore.h>

@interface LineGraphView (Private)

- (CGPathRef)newPathFromValues:(NSArray *)theValues withZeroedY:(BOOL)zeroedY;
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
  [values release];
  [super dealloc];
}

#pragma mark -
#pragma mark Attribute getters and setters

- (NSArray *)values {
  return [[values copy] autorelease];
}

- (void)setValues:(NSArray *)newValues {
  [values autorelease];
  values = [newValues copy];
  [self animateGraphChange];
}

- (CGPathRef)newPathFromValues:(NSArray *)theValues withZeroedY:(BOOL)zeroedY {
  if([theValues count]) {
    CGRect insetRect = CGRectInset(self.bounds, 10.f, 0.f);
    
    CGFloat pointXOffset = insetRect.size.width / ([theValues count] - 1);
    CGFloat height = insetRect.size.height;
    CGFloat xOrigin = insetRect.origin.x;
    CGFloat firstValue = [[theValues objectAtIndex:0] floatValue];
    
    CGMutablePathRef line = CGPathCreateMutable();
    CGFloat nextY = zeroedY ? 0 : (height * firstValue);
    CGPathMoveToPoint(line, NULL, xOrigin, height - nextY);
    for (int i = 1; i < [theValues count]; i++) {
      CGFloat value = [[theValues objectAtIndex:i] floatValue];
      nextY = zeroedY ? 0 : (height * value);
      CGPathAddLineToPoint(line, NULL, xOrigin + (i * pointXOffset), height - nextY);
    }
    return line;
  }
  return nil;
}


- (void)animateGraphChange {
  CAShapeLayer *theLayer = (CAShapeLayer *)self.layer;
  
  CGPathRef thePath = [self newPathFromValues:self.values withZeroedY:NO];
  
  CABasicAnimation *animatePath = [CABasicAnimation animationWithKeyPath:@"path"];
  
  if(!theLayer.path) {
    CGPathRef zeroedPath = [self newPathFromValues:self.values withZeroedY:YES];  
    animatePath.fromValue = (id)zeroedPath;
    CGPathRelease(zeroedPath);
  } else {
    animatePath.fromValue = (id)[[theLayer presentationLayer] path];
  }
  
  animatePath.toValue = (id)thePath;
  animatePath.duration = .5f;
  animatePath.fillMode = kCAFillModeForwards;
  animatePath.removedOnCompletion = NO;
  animatePath.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  
  theLayer.path = thePath;
  [theLayer addAnimation:animatePath forKey:@"path"];
  CGPathRelease(thePath);
}

@end
