#import "CounterView.h"



static const NSInteger kDigitCount = 11;
static const CGFloat kDigitWidth = 32.f;
static const CGFloat kDigitHeight = 26.f;
static const unichar kCharacterOffset = 48;

#define kNormalizedDigitHeight (1.f / (CGFloat)kDigitCount)

@interface CounterView() {
  double number_;
  NSMutableArray *digitLayers_;
}

- (void)setupWithNumber:(double)num;
- (CALayer *)layerForDigitAtIndex:(NSUInteger)index;

@end

@implementation CounterView

#pragma mark - Object Lifecycle / Memory management

- (void)dealloc {
  [digitLayers_ release], digitLayers_ = nil;
  [super dealloc];
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

- (void)setupWithNumber:(double)num {
  digitLayers_ = [[NSMutableArray alloc] init];
  [self setNumber:num];
}

#pragma mark - View Lifecycle

- (void)awakeFromNib {
  [self setupWithNumber:0];
}

#pragma mark - Getters and Setters

- (double)number {
  return number_;
}

- (void)setNumber:(double)num {
  number_ = num;
  [self setNeedsLayout];
}

#pragma mark - Layout and Drawing

- (void)layoutSubviews {
  [digitLayers_ makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
  
  NSString *numberString = [NSString stringWithFormat:@"%.0F", self.number];
  NSUInteger count = [numberString length];
  self.bounds = CGRectMake(0.f, 0.f, (CGFloat)count * kDigitWidth, kDigitHeight);
  
  for(NSUInteger i = 0; i < count; i++) {
    CALayer *theLayer = [self layerForDigitAtIndex:i];
    int theNumber = (int)([numberString characterAtIndex:i] - kCharacterOffset);
    
    BOOL isNegativeSymbol = theNumber < 0;
    CGFloat contentOffsetY;
    if(isNegativeSymbol) {
      contentOffsetY = kNormalizedDigitHeight * 10.f;
    } else {
      contentOffsetY = kNormalizedDigitHeight * (CGFloat)theNumber;
    }

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    theLayer.frame = CGRectMake(kDigitWidth * i, 0.f, kDigitWidth, kDigitHeight);

    [CATransaction begin];
    [CATransaction setDisableActions:isNegativeSymbol];
    CGRect contentsRect = theLayer.contentsRect;
    contentsRect.origin.y = contentOffsetY;
    theLayer.contentsRect = contentsRect;
    [CATransaction commit];
    
    [CATransaction commit];
    
    [self.layer addSublayer:theLayer];
  }  
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
    
    theLayer.contentsRect = CGRectMake(0.f, kNormalizedDigitHeight, 1.f, kNormalizedDigitHeight);
    
    [digitLayers_ insertObject:theLayer atIndex:index];
  }
  return theLayer;
}


@end
