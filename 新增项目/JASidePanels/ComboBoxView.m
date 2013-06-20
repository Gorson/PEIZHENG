//
//  ComboBoxView.m
//  comboBox
//
//  Created by duansong on 10-7-28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ComboBoxView.h"
#import "PZNewsMainList.h"
#import "PZNewsDetailViewController.h"
#import "PZMainViewController.h"

@implementation ComboBoxView

@synthesize comboBoxDatasource = _comboBoxDatasource;
@synthesize mainViewController;
@synthesize comboBoxTableView = _comboBoxTableView;
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		[self initVariables];
		[self initCompentWithFrame:frame];
    }
    return self;
}

#pragma mark -
#pragma mark custom methods

- (void)initVariables {
	_showComboBox = NO;
}

- (void)initCompentWithFrame:(CGRect)frame {
	_selectContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 10.0f, 39)];
	_selectContentLabel.font = [UIFont boldSystemFontOfSize:16.0f];
	_selectContentLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:_selectContentLabel];
	[_selectContentLabel release];
	
	_pulldownButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_pulldownButton setFrame:CGRectMake(frame.size.width - 25, 0, 25, 39)];
	[_pulldownButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"list_ico_d" ofType:@"png"]]
							   forState:UIControlStateNormal];
	[_pulldownButton addTarget:self action:@selector(pulldownButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_pulldownButton];
	
	_hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[_hiddenButton setFrame:CGRectMake(0, 0, frame.size.width - 25, 39)];
	_hiddenButton.backgroundColor = [UIColor clearColor];
	[_hiddenButton addTarget:self action:@selector(pulldownButtonWasClicked:) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:_hiddenButton];
	
	_comboBoxTableView = [[UITableView alloc] initWithFrame:CGRectMake(1, 39, frame.size.width - 2, frame.size.height - 40.0f)];
	_comboBoxTableView.dataSource = self;
	_comboBoxTableView.delegate = self;
	_comboBoxTableView.backgroundColor = [UIColor whiteColor];
	_comboBoxTableView.separatorColor = [UIColor lightGrayColor];
	_comboBoxTableView.hidden = YES;

	[self addSubview:_comboBoxTableView];
	[_comboBoxTableView release];
}

- (void)setContent:(NSString *)content {
	_selectContentLabel.text = content;
}

- (void)show {
	_comboBoxTableView.hidden = NO;
	_showComboBox = YES;
	[self setNeedsDisplay];
}

- (void)hidden {
	_comboBoxTableView.hidden = YES;
	_showComboBox = NO;
	[self setNeedsDisplay];
}

#pragma mark -
#pragma mark custom event methods

- (void)pulldownButtonWasClicked:(id)sender {
	if (_showComboBox == YES) {
		[self hidden];
	}else {
		[self show];
	}
}

#pragma mark -
#pragma mark UITableViewDelegate and UITableViewDatasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_comboBoxDatasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"ListCellIdentifier";
	UITableViewCell *cell = [_comboBoxTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
    PZNewsMainList * newsMainList = [[PZNewsMainList alloc]init];
    newsMainList = [_comboBoxDatasource objectAtIndex:indexPath.row];
	cell.textLabel.text = newsMainList.title;
	cell.textLabel.font = [UIFont boldSystemFontOfSize:16.0f];
	cell.accessoryType = UITableViewCellAccessoryNone;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 39.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self hidden];
    PZNewsMainList * newsMainList = [[PZNewsMainList alloc]init];
    newsMainList = [_comboBoxDatasource objectAtIndex:indexPath.row];
	_selectContentLabel.text = newsMainList.title;
    PZNewsDetailViewController * newsDetailView = [[PZNewsDetailViewController alloc]init];
    newsDetailView.newsid = newsMainList.newsId;
    [mainViewController.navigationController pushViewController:newsDetailView animated:YES];
    
}

#pragma mark -
#pragma mark UITableViewDelegate

/*
 * 当cell加载绘画时调用的方法
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!tableView.dragging && !tableView.decelerating) {
        return;
    }
    if(indexPath.row == [_comboBoxDatasource count] - 3.0f) {
        if([_comboBoxDatasource count])
        {
            [mainViewController sendRequest:mainViewController.catId];
        }
    }
}


- (void)drawListFrameWithFrame:(CGRect)frame withContext:(CGContextRef)context {
	CGContextSetLineWidth(context, 1.0f);
	CGContextSetRGBStrokeColor(context, 0.0f, 0.0f, 0.0f, 1.0f);
	if (_showComboBox == YES) {
		CGContextAddRect(context, CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height));
		
	}else {
		CGContextAddRect(context, CGRectMake(0.0f, 0.0f, frame.size.width, 0.0f));
	}
	CGContextDrawPath(context, kCGPathStroke);	
	CGContextMoveToPoint(context, 0.0f, 39.0f);
	CGContextAddLineToPoint(context, frame.size.width, 39.0f);
	CGContextMoveToPoint(context, frame.size.width - 39, 0);
	CGContextAddLineToPoint(context, frame.size.width - 39, 0.0f);
	
	CGContextStrokePath(context);
}


#pragma mark -
#pragma mark drawRect methods

- (void)drawRect:(CGRect)rect {
	[self drawListFrameWithFrame:self.frame withContext:UIGraphicsGetCurrentContext()];
}


#pragma mark -
#pragma mark dealloc memery methods

- (void)dealloc {
	_comboBoxTableView.delegate		= nil;
	_comboBoxTableView.dataSource	= nil;
	
//	[_comboBoxDatasource			release];
//	_comboBoxDatasource				= nil;
	
    [super dealloc];
}


@end
