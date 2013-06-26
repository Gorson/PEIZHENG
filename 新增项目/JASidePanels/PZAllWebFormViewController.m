//
//  PZAllWebFormViewController.m
//  培正梦飞翔
//
//  Created by Air on 13-6-24.
//
//

#import "PZAllWebFormViewController.h"
#import "PZAllWebFormRequest.h"
#import "PZAllWebFormData.h"
#import "PZWebListTableCell.h"
#import "PZPCFormDetailViewController.h"

@interface PZAllWebFormViewController ()
{
    
}
@end

@implementation PZAllWebFormViewController
@synthesize allWebFormTableView = _allWebFormTableView;
@synthesize loadingView = _loadingView;
@synthesize itemArray = _itemArray;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initWithControl];
    [self initWithData];
}

- (void)initWithControl
{
    [_headerLabel setText:@"网上报修单"];
    _allWebFormTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 44.0f, IPHONE_WIDTH, IPHONE_HEIGHT-64) style:UITableViewStylePlain];
    _allWebFormTableView.backgroundColor = [UIColor whiteColor];
    _allWebFormTableView.backgroundView.alpha = 0;
    _allWebFormTableView.dataSource = self;
    _allWebFormTableView.delegate = self;
    _allWebFormTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_allWebFormTableView];
    
    _loadingView = [[CustomActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_loadingView setFrame:CGRectOffset(LoadingRect, 0.0f, -22.0f)];
    [_loadingView startAnimating];
    [self.view addSubview:_loadingView];
}

- (void)initWithData
{
    _itemArray = [[NSMutableArray array]retain];
    PZAllWebFormRequest *allWebFormRequest = [[PZAllWebFormRequest alloc]init];
    allWebFormRequest.allWebFormViewController = self;
    [allWebFormRequest AllWebFormRequest];
}

#pragma mark -
#pragma mark UITableViewDataSource

/*
 * 表格视图section的个数，有1个section
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


/*
 * 表格视图每个section的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return [_itemArray count];
    }
    return 0;
}


/*
 * 表格视图每行的内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section)
    {
        static NSString * CellIdentifier = @"Cell1";
        
        PZWebListTableCell * allWebFormListCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (allWebFormListCell == nil)
        {
            allWebFormListCell = [[[PZWebListTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            allWebFormListCell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }
        if ([_itemArray count]) {
            PZAllWebFormData * allWebFormData = [_itemArray objectAtIndex:indexPath.row];
            allWebFormListCell.titleLabel.text = [NSString stringWithFormat:@"电脑类型：%@",allWebFormData.computertype];
            allWebFormListCell.timeLabel.text = [NSString stringWithFormat:@"报单时间：%@",allWebFormData.submittime];
            allWebFormListCell.contentLabel.text = [NSString stringWithFormat:@"预约时间：%@",allWebFormData.booktime];
            allWebFormListCell.stateLabel.text = allWebFormData.state;
//            [allWebFormListCell.acceptBtn setTitle:allWebFormData.state forState:UIControlStateNormal];
//            if ([_catid isEqualToString:@"249" ] || [_catid isEqualToString:@"51" ]) {
//                [newsListCell.image setFrame:CGRectMake(210.0f, 3.0f, 100.0f, 140.0f)];
//                [newsListCell.headImageView setFrame:CGRectMake(210.0f, 3.0f, 100.0f, 140.0f)];
//                [newsListCell.timeLabel setFrame:CGRectMake(55.0f, 12311.0f, 130.0f, 20.0f)];
//                [newsListCell.contentLabel setFrame:CGRectMake(10.0f, 23.0f, 180.0f, 100.0f)];
//            }
//            if ([newsData.imgurl hasPrefix:@"/var"])
//            {
//                newsListCell.image.image = [self newThreadForLoadLocalImage:newsData];
//                
//            }else
//            {
//                [newsListCell.image setImageWithURL:[NSURL URLWithString:newsData.imgurl] placeholderImage:[UIImage imageNamed:@""]];
//                newsData.imgurl = [PZNewsListData adressOfImage:newsData.imgurl];
//                [PZNewsListData updateDataFromDatabase:newsData];
//            }
//            newsListCell.timeLabel.text = newsData.time;
//            if ([newsData.introduce isEqualToString:@""])
//            {
//                newsListCell.contentLabel.text = @"暂无介绍";
//            }
//            else
//            {
//                newsListCell.contentLabel.text = newsData.introduce;
//            }
        }
        
        return allWebFormListCell;
    }
    return NULL;
}
//
//- (UIImage *)newThreadForLoadLocalImage:(PZNewsListData *)newsData
//{
//    return [UIImage imageWithContentsOfFile:newsData.imgurl];
//}

/*
 * 表格视图每行的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([_catid isEqualToString:@"249"] || [_catid isEqualToString:@"51" ])
//    {
//        return 150.0f;
//    }
    return 80.0f;
    
}


/*
 * 表格视图每一部分行距加大
 */
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (0 == section) {
//        return 40.0f;
//    }
//    if (1 == section) {
//        return 40.0f;
//    }
//    return 0;
//
//}


///*
// * section 之间颜色
// */
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView * sectionView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
//    sectionView.backgroundColor = [UIColor whiteColor];
//    if (0 == section) {
//        //已在ipiao的通信录玩友列表
//        UILabel * _separatorLabel =[[UILabel alloc]initWithFrame:CGRectMake(10.0f, 8.0f, 300.0f, 30.0f)];
//        _separatorLabel.text = @"已在ipiao";
//        if ([_mobileFriendList_unFriendedArray count] == 0) {
//            UILabel * nothingStr = [[UILabel alloc]initWithFrame:CGRectMake(90, 8, 100, 30)];
//            nothingStr.text = @"(暂无)";
//            nothingStr.font = [UIFont systemFontOfSize:16];
//            nothingStr.texPZolor = HEXCOLOR(0x898989);
//            nothingStr.backgroundColor = [UIColor clearColor];
//            [sectionView addSubview:nothingStr];
//        }
//        _separatorLabel.texPZolor = HEXCOLOR(0x898989);
//        _separatorLabel.font = [UIFont systemFontOfSize:16];
//        _separatorLabel.backgroundColor = [UIColor clearColor];
//        [sectionView addSubview:_separatorLabel];
//        [_separatorLabel release];
//    }
//    if (1 == section) {
//        //已在ipiao的通信录玩友列表
//        UILabel * _separatorLabel =[[UILabel alloc]initWithFrame:CGRectMake(10.0f, 8.0f, 300.0f, 30.0f)];
//        _separatorLabel.text = @"没在ipiao";
//        _separatorLabel.texPZolor =HEXCOLOR(0x898989);
//        _separatorLabel.font = [UIFont systemFontOfSize:16];
//        _separatorLabel.backgroundColor = [UIColor clearColor];
//        [sectionView addSubview:_separatorLabel];
//        [_separatorLabel release];
//    }
//
//    return [sectionView autorelease];
//}


/*
 * 选中表格视图后触发事件
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
    PZPCFormDetailViewController *PCFormDetailViewController = [[PZPCFormDetailViewController alloc]init];
    if ([_itemArray count]) {
        PZAllWebFormData * allWebFormData = [_itemArray objectAtIndex:indexPath.row];
        PCFormDetailViewController.oid = allWebFormData.listid;
        [self.navigationController pushViewController:PCFormDetailViewController animated:YES];
    }
}


/*
 * 视图出栈时调用释放全部私有变量
 */
-(void)dealloc
{
    [_allWebFormTableView release];
    [_loadingView release];
    [super dealloc];
}


#pragma mark -
#pragma mark UITableViewDelegate

/*
 * 当cell加载绘画时调用的方法
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!_allWebFormTableView.dragging && !_allWebFormTableView.decelerating) {
        return;
    }
    if(indexPath.row == [_itemArray count] -1) {
        if([_itemArray count]) {
            
        }
    }
}
@end
