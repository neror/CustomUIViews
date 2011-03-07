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

#import "BitmapFontCounterController.h"
#import "CounterView.h"

@implementation BitmapFontCounterController

@synthesize textEntry = textEntry_;
@synthesize counterView = counterView_;

- (void)viewDidLoad {
  self.title = @"Bitmap Font Counter";
  self.textEntry.text = @"12345";
  [self updateText];
  [super viewDidLoad];
}

- (void)dealloc {
  [textEntry_ release], textEntry_ = nil;
  [counterView_ release], counterView_ = nil;
  [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated {
  [self.textEntry becomeFirstResponder];
}

#pragma mark -
#pragma mark Event Handlers

- (void)updateText {
  [self.counterView setNumber:[self.textEntry.text doubleValue]];
}

@end
