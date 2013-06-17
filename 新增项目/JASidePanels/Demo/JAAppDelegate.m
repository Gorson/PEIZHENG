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


#import "JAAppDelegate.h"

#import "Quare4MenuViewController.h"
#import "JASidePanelController.h"
#import "PZMainViewController.h"
#import "JALeftViewController.h"
#import "JARightViewController.h"
#import "PZNewsListTableViewController.h"

#import "ViewController.h"
#import "SinaWeibo.h"
#import "GuideInterfaceVC.h"

@interface JAAppDelegate()
{
    SinaWeibo *_sinaweibo; // 私有微博用户对象
}

@end

@implementation JAAppDelegate

@synthesize viewController = _viewController;
@synthesize sinaweibo = _sinaweibo;
@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize guideinterface;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    
    PZNewsListTableViewController * vc1 = [[PZNewsListTableViewController alloc]init];
    vc1.catid = CommunitysStyle;
    vc1.headTitle = @"社团风采";
    PZNewsListTableViewController * vc2 = [[PZNewsListTableViewController alloc]init];
    vc2.catid = StudentOrganizations;
    vc2.headTitle = @"学生组织";
    PZNewsListTableViewController * vc3 = [[PZNewsListTableViewController alloc]init];
    vc3.catid = PeiZhengToday;
    vc3.headTitle = @"今日培正";
    PZNewsListTableViewController * vc4 = [[PZNewsListTableViewController alloc]init];
    vc4.catid = CampusAgent;
    vc4.headTitle = @"校园探报";
    
	_viewController = [[JASidePanelController alloc] init];
    _viewController.shouldDelegateAutorotateToVisiblePanel = NO;
    _viewController.leftPanel = [[JALeftViewController alloc] init];
    _viewController.centerPanel = [[Quare4MenuViewController alloc]initWithTopLeft:vc1 TopRight:vc2 bottomLeft:vc3 bottomRight:vc4];

    _viewController.rightPanel = [[JARightViewController alloc] init];
    self.window.rootViewController = _viewController;
    [self.window makeKeyAndVisible];
//    [self weiboUserInformationCreatWithDelegateObject:_viewController];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    //判断是否第一次启动界面
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        //第一次启动进入用户引导界面
        [NSThread detachNewThreadSelector:@selector(newTheardForGuideinterface) toTarget:self withObject:nil];
    }
    else
    {
        //如果不是第一次则直接进入首页
    }
    
    //    [self.window addSubview:q4mc.view];
    return YES;
}

- (void)newTheardForGuideinterface
{
    guideinterface = [[GuideInterfaceVC alloc] init];
    [self.window addSubview:guideinterface.view];
}

/*
 TCAppDelegate的单例对象
 */
+ (JAAppDelegate *)sharedAppDelegate {
    return (JAAppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark -
#pragma mark Sina
/*
 微博的用户的登陆信息创建持续化（用户名4小时过期）
 */

-(void)weiboUserInformationCreatWithDelegateObject:(UIViewController *)viewController1
{
    _sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:_viewController];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if (!url) {
        return NO;
    }
    NSString * URLString = [url absoluteString];
    [[NSUserDefaults standardUserDefaults]setObject:URLString forKey:@"url"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    //    [self.sinaweibo handleOpenURL:url];
    //    [self parseURL:url application:application];
    return  YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [_sinaweibo handleOpenURL:url];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    __managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    // 冇表你就会崩噶啦
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PeiZhengDataBase.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
