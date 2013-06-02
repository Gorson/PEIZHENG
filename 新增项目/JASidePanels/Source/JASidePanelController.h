/*
 Copyright (c) 2012 Jesse Andersen. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 If you happen to meet one of the copyright holders in a bar you are obligated
 to buy them one pint of beer.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import <UIKit/UIKit.h>

typedef enum _JASidePanelStyle {
    JASidePanelSingleActive = 0,
    JASidePanelMultipleActive
} JASidePanelStyle;

typedef enum _JASidePanelState {
    JASidePanelCenterVisible = 1,
    JASidePanelLeftVisible,
    JASidePanelRightVisible
} JASidePanelState;

@interface JASidePanelController : UIViewController<UIGestureRecognizerDelegate>

#pragma mark - Usage

// 设置面板
@property (nonatomic, strong) UIViewController *leftPanel;   // 可选择的
@property (nonatomic, strong) UIViewController *centerPanel; // 必须的
@property (nonatomic, strong) UIViewController *rightPanel;  // 可选择的

// 显示面板（已舍弃，被下面的方法代替）
- (void)showLeftPanel:(BOOL)animated __attribute__((deprecated("Use -showLeftPanelAnimated: instead")));
- (void)showRightPanel:(BOOL)animated __attribute__((deprecated("Use -showRightPanelAnimated: instead")));
- (void)showCenterPanel:(BOOL)animated __attribute__((deprecated("Use -showCenterPanelAnimated: instead")));

// 显示面板
- (void)showLeftPanelAnimated:(BOOL)animated;
- (void)showRightPanelAnimated:(BOOL)animated;
- (void)showCenterPanelAnimated:(BOOL)animated;

// 开启/关闭开关它们
- (void)toggleLeftPanel:(id)sender;
- (void)toggleRightPanel:(id)sender;

//调用这个方法左边或者右边面板可见导致中心面板完全隐藏
- (void)setCenterPanelHidden:(BOOL)centerPanelHidden animated:(BOOL)animated duration:(NSTimeInterval) duration;

#pragma mark - Look & Feel

// 风格
@property (nonatomic) JASidePanelStyle style; // 默认是 JASidePanelSingleActive

// 左边面板占总面板的面积（百分比）
@property (nonatomic) CGFloat leftGapPercentage; 

// 左面板的大小根据这个固定的大小。覆盖leftGapPercentage
@property (nonatomic) CGFloat leftFixedWidth;

// 可见左侧面板的宽度（只读）
@property (nonatomic, readonly) CGFloat leftVisibleWidth;

// 右边面板占总面板的面积（百分比）
@property (nonatomic) CGFloat rightGapPercentage;

// 大小合适的小组基于这个固定的大小。覆盖rightGapPercentage
@property (nonatomic) CGFloat rightFixedWidth;

// 可见右侧面板的宽度（只读）
@property (nonatomic, readonly) CGFloat rightVisibleWidth;

// 默认情况下应用一个黑影子的容器。覆盖在子类那样去改变
- (void)styleContainer:(UIView *)container animate:(BOOL)animate duration:(NSTimeInterval)duration;

// 默认情况下适用于圆角的面板。覆盖在子类那样去改变
- (void)stylePanel:(UIView *)panel;

#pragma mark - Animation

// 最低百分比的总屏幕宽度的centerPanel。视图必须引进panGesture成功
@property (nonatomic) CGFloat minimumMovePercentage;

// 最大时间面板打开/关闭应该采取。实际时间可能会少,如果panGesture已经搬到视图。
@property (nonatomic) CGFloat maximumAnimationDuration;

// 反弹的动画应该持续多久
@property (nonatomic) CGFloat bounceDuration;

// 反弹的动画应该占多少比例
@property (nonatomic) CGFloat bouncePercentage;

// 当你平移打开左/右面板该中心面板反弹。
@property (nonatomic) BOOL bounceOnSidePanelOpen; // 默认为yes

// 当你平移关闭左/右面板该中心面板反弹。
@property (nonatomic) BOOL bounceOnSidePanelClose; // 默认为no

#pragma mark - Gesture Behavior

// 决定了平移仅限于顶部在UINavigationController / UITabBarController ViewController
@property (nonatomic) BOOL panningLimitedToTopViewController; // 默认为yes

// 决定是否显示面板可以控制通过平移手势,或只有通过按钮
@property (nonatomic) BOOL recognizesPanGesture; // 默认为yes

#pragma mark - Menu Buttons

// 给你一个图像用于你的菜单按钮。图像是三堆白线,类似于Path2.0或Facebook的菜单按钮。
+ (UIImage *)defaultImage;

// 默认按钮放置在顶部gestureViewControllers viewController。覆盖在子类那样改变默认按钮的外观
- (UIBarButtonItem *)leftButtonForCenterPanel;

#pragma mark - Nuts & Bolts

// 当前状态的面板。使用KVO监控状态的改变
@property (nonatomic, readonly) JASidePanelState state;

// 中心面板是否完全隐藏
@property (nonatomic, assign) BOOL centerPanelHidden;

// 当前可见的面板
@property (nonatomic, weak, readonly) UIViewController *visiblePanel;

// 如果设置为yes,“shouldAutorotateToInterfaceOrientation:“将被传递给自己。visiblePanel代替直接进行处理
@property (nonatomic, assign) BOOL shouldDelegateAutorotateToVisiblePanel; // 默认设置为yes

// 确定是否该面板的视图在第一界面。如果是的,rightPanel & leftPanel的视图是viewDidUnload资格
@property (nonatomic, assign) BOOL canUnloadRightPanel; // 默认为no
@property (nonatomic, assign) BOOL canUnloadLeftPanel;  // 默认为no

// 决定是否应该调整面板的视图当他们被显示。如果是的,视图将被调整大小以看得见的宽度
@property (nonatomic, assign) BOOL shouldResizeRightPanel; // 默认为no
@property (nonatomic, assign) BOOL shouldResizeLeftPanel;  // 默认为no

// 决定是否可以成功符合中心面板的可见区域的侧板
@property (nonatomic, assign) BOOL allowRightOverpan; // 默认为yes
@property (nonatomic, assign) BOOL allowLeftOverpan;  // 默认为yes

// 决定是否或不是左边或者右边面板可以刷卡进入视图。如果只使用方式查看一个面板有一个按钮
@property (nonatomic, assign) BOOL allowLeftSwipe;  // 默认为yes
@property (nonatomic, assign) BOOL allowRightSwipe; // 默认为yes

// 容器的面板。
@property (nonatomic, strong, readonly) UIView *leftPanelContainer;
@property (nonatomic, strong, readonly) UIView *rightPanelContainer;
@property (nonatomic, strong, readonly) UIView *centerPanelContainer;

@end
