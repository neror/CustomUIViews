#import "CounterView.h"

static const CGFloat kDigitWidth = 32.f;
static const CGFloat kDigitHeight = 26.f;
static const unichar kCharacterOffset = 48;

@implementation CounterView

- (void)setupWithNumber:(double)num {
  digitLayers_ = [[NSMutableArray alloc] init];
  [self setNumber:num];
}

- (id)initWithFrame:(CGRect)theFrame {
  return [self initWithNumber:0];
}

- (id)initWithNumber:(double)num {
  self = [super initWithFrame:CGRectMake(0.f, 0.f, kDigitWidth, kDigitHeight)];
  if (self) {
    [self setupWithNumber:num];
  }
  return self;
}

- (void)awakeFromNib {
  [self setupWithNumber:0];
}

- (void)dealloc {
  [digitLayers_ release];
  [super dealloc];
}

- (double)number {
  return number_;
}

- (void)layoutSubviews {
  [digitLayers_ makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
  
  NSString *numberString = [NSString stringWithFormat:@"%.0F", self.number];
  NSUInteger count = [numberString length];
  self.bounds = CGRectMake(0.f, 0.f, (CGFloat)count * kDigitWidth, kDigitHeight);
  
  for(NSUInteger i = 0; i < count; i++) {
    CALayer *theLayer = [self layerForDigitAtIndex:i];
    int theNumber = (int)([numberString characterAtIndex:i] - kCharacterOffset);
    if(theNumber < 0) {
      theNumber = 10;
    }
    CGFloat height = 1.f/11.f;
    CGFloat width = 1.f;
    CGRect contentsRect = CGRectMake(0.f, theNumber * height, width, height);
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    theLayer.frame = CGRectMake(kDigitWidth * i, 0.f, kDigitWidth, kDigitHeight);

    [CATransaction begin];
    [CATransaction setDisableActions:(theNumber == 10)];
    theLayer.contentsRect = contentsRect;
    [CATransaction commit];
    
    [CATransaction commit];
    
    [self.layer addSublayer:theLayer];
  }  
}

- (void)setNumber:(double)num {
  number_ = num;
  [self setNeedsLayout];
}

- (CALayer *)layerForDigitAtIndex:(NSUInteger)index {
  CALayer *theLayer;
  if(index >= [digitLayers_ count] || 
     (theLayer = [digitLayers_ objectAtIndex:index]) == nil)
  {
    theLayer = [CALayer layer];
    theLayer.anchorPoint = CGPointZero;
    theLayer.masksToBounds = YES;
    theLayer.frame = CGRectMake(0.f, 0.f, kDigitWidth, kDigitHeight);
    theLayer.contentsGravity = kCAGravityCenter;
    theLayer.contents = (id)[[UIImage imageNamed:@"NumberStrip.png"] CGImage];
    
    CGFloat height = 1.f/11.f;
    //CGFloat width = kDigitWidth;
    CGFloat width = 1.f;
    theLayer.contentsRect = CGRectMake(0.f, height, width, height);
    
    [digitLayers_ insertObject:theLayer atIndex:index];
  }
  return theLayer;
}


@end
