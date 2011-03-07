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

#import "ProgressBarView.h"

@interface ProgressBarView() {
  CGFloat progress_;
}

@property (nonatomic, retain) CAGradientLayer *progressBar;

- (void)setupLayers;

@end

@implementation ProgressBarView

@synthesize progressBar = progressBar_;

#pragma mark - Object Lifecycle / Memory management

- (void)dealloc {
  [progressBar_ release], progressBar_ = nil;
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
  self.progressBar = [CAGradientLayer layer];
  [self.layer addSublayer:self.progressBar];
}

#pragma mark - Drawing and Layout

- (void)layoutSubviews {
  self.backgroundColor = [UIColor clearColor];
  self.layer.borderColor = [[UIColor blackColor] CGColor];
  self.layer.borderWidth = 1.f;
  self.layer.cornerRadius = 12.f;
  self.layer.masksToBounds = YES;
  
  self.progressBar.colors = [NSArray arrayWithObjects:
                             (id)[[UIColor blueColor] CGColor], 
                             (id)[[UIColor colorWithHue:.6f saturation:.8f brightness:1.f alpha:1.f] CGColor],
                             (id)[[UIColor blueColor] CGColor], nil];
  self.progressBar.locations = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:0.f],
                                [NSNumber numberWithFloat:.5f],
                                [NSNumber numberWithFloat:1.f], nil];
  self.progressBar.anchorPoint = CGPointZero;
  
  CGRect progressBounds = self.bounds;
  progressBounds.size.width *= self.progress;
  self.progressBar.bounds = progressBounds;
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
