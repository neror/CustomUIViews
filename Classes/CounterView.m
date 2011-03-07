/*
 The MIT License
 
 Copyright (c) 2011 Free Time Studios and Nathan Eror
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

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
