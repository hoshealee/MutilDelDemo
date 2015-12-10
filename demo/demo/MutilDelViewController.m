//
//  MutilDelViewController.m
//  demo
//
//  Created by qingyun on 15/12/10.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "MutilDelViewController.h"

@interface MutilDelViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *indexPaths;
@property (nonatomic) bool userIsEditing;

@end

@implementation MutilDelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    _datas = [NSMutableArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",nil];
    [self addUIBarButtonItem];
    [self addToolBar];
    _indexPaths = [NSMutableArray array];
}

#pragma mark - 添加toolBar
- (void)addToolBar
{
    self.navigationController.toolbarHidden = NO;
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStyleDone target:self action:@selector(deleteItemEvent:)];
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    fixedItem.width = 20;
    NSArray *items = @[flexibleItem,deleteItem,fixedItem];
    [self setToolbarItems:items animated:YES];
}

- (void)deleteItemEvent:(UIBarButtonItem *)item
{
    //item.enabled = _userIsEditing?YES:NO;
    if (_indexPaths) {
#if 0
        int i =0;
        for (NSIndexPath *indexPath in _indexPaths) {
            if (indexPath.row < _datas.count) {
                [_datas removeObjectAtIndex:indexPath.row];
                i++;
            }else{
                [_datas removeObjectAtIndex:indexPath.row - i];
                i++;
            }
            //[_indexPaths removeObject:_indexPaths.firstObject];
        }
#else
        NSMutableArray *deleteArray = [NSMutableArray array];
        for (NSIndexPath *indexPath in _indexPaths) {
            [deleteArray addObject:_datas[indexPath.row]];
        }
        [_datas removeObjectsInArray:deleteArray];
#endif
        //NSArray *array = nil;
        [_indexPaths removeAllObjects];
        [_tableView reloadData];
    }
}

#pragma mark -  设置编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
#if 0
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_datas removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
#endif
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_userIsEditing) {
        //[_datas removeObjectAtIndex:indexPath.row];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        //[tableView reloadData];
        [_indexPaths addObject:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[_indexPaths removeAllObjects];
    if ([_indexPaths containsObject:indexPath]) {
        [_indexPaths removeObject:indexPath];
    }
}

#pragma mark - 添加UIBarButtonItem
- (void)addUIBarButtonItem
{
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemEvents:)];
    self.navigationItem.rightBarButtonItem = editItem;
}

- (void)rightItemEvents:(UIBarButtonItem *)item
{
    if ([item.title isEqualToString:@"Done"]) {
        [_indexPaths removeAllObjects];
    }
    item.title = [item.title isEqualToString:@"Edit"]? @"Done": @"Edit";
    _tableView.editing = !_tableView.editing;
    _userIsEditing = !_userIsEditing;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"HLTestcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _datas[indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
