#import "RootViewController.h"
#import "BitmapFontCounterController.h"
#import "LineGraphViewController.h"
#import "ProgressBarViewController.h"
#import "SimpleDrawRectController.h"

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

