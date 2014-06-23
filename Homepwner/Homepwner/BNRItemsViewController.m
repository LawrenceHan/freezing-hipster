//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by Hanguang on 14-4-27.
//  Copyright (c) 2014年 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRDetailViewController.h"

@interface BNRItemsViewController ()
@property NSMutableArray *itemOver50s;
@property NSMutableArray *itemUnder50s;
//@property (nonatomic, strong) IBOutlet UIView *headerView;


@end

@implementation BNRItemsViewController

- (instancetype)init
{
    // Call the superclass;s designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        // Create a new bar button item that will send
        // addNewItem: to BNRItemsViewController
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewItem:)];
        // Set the bar button item as the right item in the navigationItem
        navItem.rightBarButtonItem = bbi;
        
        navItem.leftBarButtonItem = self.editButtonItem;
        

    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 选择row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initForNewItem:NO];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    // Give detail view controller a pointer to the item object in row
    detailViewController.item = selectedItem;
    NSLog(@"%@",selectedItem);
    
    // push it onto the top of the navigation controller's stack
    [self.navigationController pushViewController:detailViewController animated:YES];
}

// 删除row
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // If the table view is asking for commit a delete command...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item  = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        
        // Also remove that row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// 判断移动row
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (proposedDestinationIndexPath.row == [[[BNRItemStore sharedStore] allItems] count]) {
        NSLog(@"proposedIndexPath is %@, sourceIndexPath is %@",proposedDestinationIndexPath, sourceIndexPath);
        return sourceIndexPath;
    }
    else {
        return proposedDestinationIndexPath;
    }
    
}

// 移动row
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    if (destinationIndexPath.row == [items count]) {
        NSLog(@"destination row is %i", destinationIndexPath.row);
        NSLog(@"source row is %i", sourceIndexPath.row);
        
        
    }
    else {
        [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row
                                            toIndex:destinationIndexPath.row];
    }
    
}

// 最后一行不可选择
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    if (indexPath.row == [items count]) {
        return nil;
    }
    return indexPath;
}

// 最后一行不可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    if (indexPath.row == [items count]) {
        return NO;
    }
    else{
        return YES;
    }
}

// 最后一行不可移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    if (indexPath.row == [items count]) {
        return NO;
    }
    else{
        return YES;
    }
}

// 最后一行不可删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    if (indexPath.row == [items count]) {
        return UITableViewCellEditingStyleNone;
    }
    else{
        return UITableViewCellEditingStyleDelete;
    }
}

// 删除时显示Remove
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 4) {
        return [NSString stringWithFormat:@"Delete"];
    }
    else
        return [NSString stringWithFormat:@"Remove"];
}


#pragma mark - tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count is %i", [[[BNRItemStore sharedStore] allItems] count] +1);
    return [[[BNRItemStore sharedStore] allItems] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    // Get a new or recycled cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];

    // 判断第一行为0或数组为空时 显示 No more items!
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    if (indexPath.row == [items count]) {
        NSLog(@"row = %i, items count = %i",indexPath.row, [items count]);
        cell.textLabel.text = @"No more items!";
    }
    else{
        BNRItem *item = items[indexPath.row];
        cell.textLabel.text = [item description];
    }
    return cell;
}


#pragma mark - button method
- (IBAction)addNewItem:(id)sender
{
    // Make a new index path for the 0th section, last row
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    BNRDetailViewController *detailViewController =
    [[BNRDetailViewController alloc] initForNewItem:YES];
    
    detailViewController.item = newItem;
    detailViewController.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:detailViewController];
    
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:navController animated:YES completion:nil];
    
    
//    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
//    
//    
//    NSIndexPath *indexPatch = [NSIndexPath indexPathForRow:lastRow inSection:0];
//    
//    // Insert this new row into the table
//    [self.tableView insertRowsAtIndexPaths:@[indexPatch]
//                          withRowAnimation:UITableViewRowAnimationTop];
    
}

// headerview按钮触发事件
//- (IBAction)toggleEditingMode:(id)sender
//{
//    // If you are currently in editing mode...
//    if (self.isEditing) {
//        
//        // Change the text of button to inform user of state
//        [sender setTitle:@"Edit" forState:UIControlStateNormal];
//        
//        // Turn off editing mode
//        [self setEditing:NO animated:YES];
//    } else {
//        
//        // Change the text of button to inform user of state
//        [sender setTitle:@"Done" forState:UIControlStateNormal];
//        
//        // Enter editing mode
//        [self setEditing:YES animated:YES];
//    }
//}


// headerView 显示 标题
//- (UIView *)headerView
//{
//    // If you have not loaded the headerView yet...
//    if (!_headerView) {
//        
//        // Load HeaderView.xib
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
//    }
//    return _headerView;
//}

#pragma mark - view life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    
//    UIView *header = self.headerView;
//    [self.tableView setTableHeaderView:header];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}
    
@end
