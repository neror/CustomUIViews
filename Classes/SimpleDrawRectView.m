#import "SimpleDrawRectView.h"


@implementation SimpleDrawRectView

- (void)drawRect:(CGRect)rect {
  UIRectFrame(self.bounds);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGMutablePathRef path = CGPathCreateMutable();
  CGPathAddEllipseInRect(path, NULL, self.bounds);
  CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
  CGContextSetLineWidth(context, 5.f);
  CGContextAddPath(context, path);
  CGContextDrawPath(context, kCGPathStroke);
  
  CGPathRelease(path);
}

- (void)dealloc {
    [super dealloc];
}


@end
