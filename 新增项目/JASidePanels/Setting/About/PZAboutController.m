//
//  TCSetController.m
//  IpiaoSNS
//
//  Created by liujiada on 12-12-27.
//  Copyright (c) 2012年 Ipiao. All rights reserved.
//

#import "PZAboutController.h"
#import "UIImageView+WebCache.h"

@interface PZAboutController ()
{
    NSArray *array;
}

@end

@implementation PZAboutController

#pragma mark -
#pragma mark Memory management

/*
 内存释放
 */
- (void)dealloc {
    [_tableView setDataSource:nil];
    [_tableView setDelegate:nil];
    [_tableView release];
    
    [super dealloc];
}


#pragma mark -
#pragma mark Init UI
/*
 初始化UI控件
 */
- (void)initWithUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, IPHONE_HEIGHT-64.0f) style:UITableViewStyleGrouped];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.alpha = 0;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

#pragma mark -
#pragma mark Init Data
- (void)initWithData
{
    array = [[NSArray alloc]initWithObjects:@"1",@"2", nil];
}

#pragma mark -
#pragma mark View lifecycle

/*
 视图加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [_confirmButton setHidden:YES];
    [_backButton setHidden:YES];
	[_headerLabel setText:@"关于"];
    [self initWithUI];
    [self initWithData];
}

/*
 * 视图出现时调用
 */
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidDisappear:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [_tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

/*
 表格视图section的个数
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/*
 表格视图每个section的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

/*
 表格视图每行的内容，第一个section的行的内容为空，只有头部
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundColor = HEXCOLOR(0xFBFBFB);
        cell.textLabel.textColor = BKColor;
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    return cell;
}

/*
 表格视图每行的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

/*
 选中每行后响应这个方法
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
 设置tableViewHeader的高度
 */
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 30.0f;
//}

@end
