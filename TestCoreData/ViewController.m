//
//  ViewController.m
//  TestCoreData
//
//  Created by SangChan on 2015. 2. 16..
//  Copyright (c) 2015년 sangchan. All rights reserved.
//

#import "ViewController.h"
#import "WordDictionary.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize managedObjectContext;
@synthesize words;
@synthesize navBarItems;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"단어선택";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [words count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    WordDictionary *word = [words objectAtIndex:indexPath.row];
    cell.textLabel.text = [word word];
    cell.detailTextLabel.text = [word word_description];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f){
        return;
    }
    
    CGRect frame = self.navigationController.navigationBar.frame;
    frame.origin.y = 20;
    
    if(self.navBarItems.count > 0){
        [self setNavigationBarHidden:NO];
    }
    
    [self.navigationController.navigationBar setFrame:frame];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f){
        return;
    }
    
    CGRect frame = self.navigationController.navigationBar.frame;
    CGFloat size = frame.size.height - 21;
    
    if([scrollView.panGestureRecognizer translationInView:self.view].y < 0)
    {
        frame.origin.y = -size;
        
        if(self.navigationController.navigationBar.items.count > 0){
            self.navBarItems = [self.navigationController.navigationBar.items copy];
            [self setNavigationBarHidden:YES];
        }
    }
    else if([scrollView.panGestureRecognizer translationInView:self.view].y > 0)
    {
        frame.origin.y = 20;
        
        if(self.navBarItems.count > 0){
            [self setNavigationBarHidden:NO];
        }
    }
    
    [UIView beginAnimations:@"toggleNavBar" context:nil];
    [UIView setAnimationDuration:0.2];
    [self.navigationController.navigationBar setFrame:frame];
    [UIView commitAnimations];
}

-(void)setNavigationBarHidden:(BOOL)hidden
{
    for (UIView *view in [self.navigationController.navigationBar subviews]) {
        if (view != [self.navigationController.navigationBar.subviews objectAtIndex:0]) {
            [view setHidden:hidden];
        }
    }
}

@end
