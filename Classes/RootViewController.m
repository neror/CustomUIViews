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

#import "RootViewController.h"
#import "BitmapFontCounterController.h"
#import "LineGraphViewController.h"
#import "ProgressBarViewController.h"
#import "SimpleDrawRectController.h"

@interface RootViewController() {
  NSArray *exampleClasses_;
  NSArray *exampleNames_;
}

@end

@implementation RootViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"Custom Views";
  exampleClasses_ = [[NSArray alloc] initWithObjects:[SimpleDrawRectController class],
                                                     [BitmapFontCounterController class], 
                                                     [ProgressBarViewController class], 
                                                     [LineGraphViewController class], 
                                                     nil];
  exampleNames_ = [[NSArray alloc] initWithObjects:@"Simple Draw Rect",
                                                   @"Bitmap Font Counter", 
                                                   @"Progress Bar",
                                                   @"Line Graph",
                                                   nil];
}

- (void)viewDidUnload {
  [exampleClasses_ release], exampleClasses_ = nil;
  [exampleNames_ release], exampleNames_ = nil;
}

- (void)dealloc {
  [super dealloc];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [exampleClasses_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  cell.textLabel.text = [exampleNames_ objectAtIndex:indexPath.row];

  return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  Class selectedExampleClass = [exampleClasses_ objectAtIndex:indexPath.row];
  id selectedController = [[selectedExampleClass alloc] initWithNibName:nil bundle:nil];
  [self.navigationController pushViewController:selectedController animated:YES];
  [selectedController release];
}

@end

