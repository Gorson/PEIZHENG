//
//  ComboBoxView.h
//  comboBox
//
//  Created by duansong on 10-7-28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PZMainViewController;

@interface ComboBoxView : UIView < UITableViewDelegate, UITableViewDataSource > {
	UILabel			*_selectContentLabel;
	UIButton		*_pulldownButton;
	UIButton		*_hiddenButton;
	UITableView		*_comboBoxTableView;
	NSMutableArray			*_comboBoxDatasource;
	BOOL			_showComboBox;
}

@property (nonatomic, retain) NSMutableArray *comboBoxDatasource;
@property (nonatomic, retain) PZMainViewController *mainViewController;
@property (nonatomic, retain) UITableView *comboBoxTableView;

- (void)initVariables;
- (void)initCompentWithFrame:(CGRect)frame;
- (void)setContent:(NSString *)content;
- (void)show;
- (void)hidden;
- (void)drawListFrameWithFrame:(CGRect)frame withContext:(CGContextRef)context;

@end
