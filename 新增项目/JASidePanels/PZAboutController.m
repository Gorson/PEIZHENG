//
//  TCAboutViewController.m
//  IpiaoSNS
//
//  Created by 朱 欣 on 13-1-28.
//  Copyright (c) 2013年 Ipiao. All rights reserved.
//

#import "PZAboutController.h"
#import "PZUserGuideViewController.h"

@interface PZAboutController ()
{
    
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
#pragma mark Init Data
- (void)initWithData
{
    
}

#pragma mark -
#pragma mark Init UI
/*
 初始化UI控件
 */
- (void)initWithUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 320.0f, IPHONE_HEIGHT-119.0f) style:UITableViewStyleGrouped];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.alpha = 0;
    [self.view addSubview:_tableView];
}


#pragma mark -
#pragma mark View lifecycle

/*
 视图加载方法
 */
- (void)viewDidLoad
{
    [super viewDidLoad];    
    [self initWithUI];
	_headerLabel.text = @"关于我们";
    _backButton.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 3;
    }
    return 0;
}


/*
 表格视图每行的内容，第一个section的行的内容为空，只有头部
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = BKColor;
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellBackground.png"]] autorelease];
    }
    if (0 == indexPath.section) {
        NSArray * textArray = [[[NSArray alloc]initWithObjects:@"版本",@"使用指引",@"检测版本更新",nil]autorelease];
        cell.textLabel.text = [textArray objectAtIndex:indexPath.row];
        if (0 == indexPath.row) {
            UILabel * version = [[UILabel alloc]initWithFrame:CGRectMake(255.0f, 10.0f, 150.0f, 30.0f)];
            version.backgroundColor = [UIColor clearColor];
            version.textColor = BKColor;
            version.font = [UIFont systemFontOfSize:16.0f];
            version.text = @"1.0.0";
            [cell.contentView addSubview:version];
            [version release];
        }
        
        if (1 == indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate


/*
 表格视图每行的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
}


/*
 选中每行后响应这个方法
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.section)
    {
        if (1 == indexPath.row)
        {
            // 进入使用指引
            PZUserGuideViewController * userGuideViewController = [[PZUserGuideViewController alloc]init];
            [self.navigationController pushViewController:userGuideViewController animated:YES];
        }
        if (2 == indexPath.row)
        {
        }
    }
}

/*
 设置tableViewHeader的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
