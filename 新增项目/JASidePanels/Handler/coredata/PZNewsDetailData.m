//
//  PZNewsDetailData.m
//  培正梦飞翔
//
//  Created by 朱 欣 on 13-5-14.
//
//

#import "PZNewsDetailData.h"
#import "TFHpple.h"


@implementation PZNewsDetailData

@dynamic info;
@dynamic title;
@dynamic titleintact;
@dynamic subheading;
@dynamic keywords;
@dynamic author;
@dynamic copyfrom;
@dynamic content;
@dynamic introduce;
@dynamic time;
@dynamic imgurl;
@dynamic numOfNews;
@dynamic mark;

#pragma mark
#pragma mark - coredata

-(id)initWithDictionary:(NSMutableDictionary *)aDict withNewsId:(NSString *)newsId{

	NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"PZNewsDetailData"
														 inManagedObjectContext:theApp.managedObjectContext];
	self = [super initWithEntity:entityDescription insertIntoManagedObjectContext:theApp.managedObjectContext];
    if (self){
        self.content = [[aDict objectForKey:@"content"]copy];
        self.info = [[aDict objectForKey:@"info"]copy];
        self.title = [[aDict objectForKey:@"title"] copy];
        self.time = [[aDict objectForKey:@"time"] copy];
        self.imgurl = [[aDict objectForKey:@"imgurl"] copy];
        self.titleintact = [[aDict objectForKey:@"titleintact"] copy];
        self.subheading = [[aDict objectForKey:@"subheading"] copy];
        self.keywords = [[aDict objectForKey:@"keywords"] copy];
        self.author = [[aDict objectForKey:@"author"] copy];
        self.copyfrom = [[aDict objectForKey:@"copyfrom"] copy];
        self.introduce = [[aDict objectForKey:@"introduce"] copy];
        self.numOfNews = newsId;
        
        NSError *error;
        if (![theApp.managedObjectContext save:&error]) {
            NSLog(@"保存不了,原因是: %@", [error localizedDescription]);
        }
    }
    return self;
}

/*
 从数据库中保存一条数据
 */
+ (void)insertADataInDatabase:(PZNewsDetailData *)detailData withNewsid:(NSString *)newsid
{
    PZNewsDetailData *newsDetailData = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"PZNewsDetailData"
                                    inManagedObjectContext:theApp.managedObjectContext];
    newsDetailData = detailData;
    newsDetailData.numOfNews = newsid;
    
    NSError *error;
    if (![theApp.managedObjectContext save:&error]) {
        NSLog(@"保存不了,原因是: %@", [error localizedDescription]);
    }
}

/*
 从数据库中保存一条数据
 */
+ (void)insertDataDicInDatabase:(NSDictionary *)dataDictonary withNewsid:(NSString *)newsid
{
    PZNewsDetailData *newsDetailData = [NSEntityDescription
                                    insertNewObjectForEntityForName:@"PZNewsDetailData"
                                    inManagedObjectContext:theApp.managedObjectContext];
    newsDetailData.numOfNews = newsid;
    
    if ([dataDictonary objectForKey:@"imgurl"]!= NULL) {
        if ([[dataDictonary objectForKey:@"imgurl"] hasPrefix:@"http"])
        {
            newsDetailData.imgurl = [dataDictonary objectForKey:@"imgurl"];
        }
        else if([[dataDictonary objectForKey:@"imgurl"] hasPrefix:@"uploadfile"])
        {
            newsDetailData.imgurl = [NSString stringWithFormat:@"http://www.peizheng.cn/%@",[dataDictonary objectForKey:@"imgurl"]];
        }else
        {
            newsDetailData.imgurl = [NSString stringWithFormat:@"http://news.vrhr.com/node_137/node_140/img/2009/06/17/124520698535082_1.jpg"];
        }
    }
    else
    {
        newsDetailData.imgurl = [NSString stringWithFormat:@"http://news.vrhr.com/node_137/node_140/img/2009/06/17/124520698535082_1.jpg"];
    }
    
    newsDetailData.title = [dataDictonary objectForKey:@"title"];
    newsDetailData.time = [dataDictonary objectForKey:@"time"];
    newsDetailData.introduce = [dataDictonary objectForKey:@"introduce"];
    newsDetailData.info = [dataDictonary objectForKey:@"info"];
    newsDetailData.titleintact = [dataDictonary objectForKey:@"titleintact"];
    newsDetailData.subheading = [dataDictonary objectForKey:@"subheading"];
    newsDetailData.keywords = [dataDictonary objectForKey:@"keywords"];
    newsDetailData.author = [dataDictonary objectForKey:@"author"];
    newsDetailData.copyfrom = [dataDictonary objectForKey:@"copyfrom"];
    newsDetailData.content = [dataDictonary objectForKey:@"content"];
    
    NSError *error;
    if (![theApp.managedObjectContext save:&error]) {
        NSLog(@"保存不了,原因是: %@", [error localizedDescription]);
    }
}

/*
 从数据库中获取所有数据
 */
+ (NSArray *)loadADataInDatabase
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PZNewsDetailData"
                                              inManagedObjectContext:theApp.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [theApp.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
}

/*
 从数据库中获取一条数据
 */
+ (PZNewsDetailData *)loadADataInDatabaseWithNewsId:(NSString *)newsID
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PZNewsDetailData"
                                              inManagedObjectContext:theApp.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [theApp.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (PZNewsDetailData *newsDetailData in fetchedObjects) {
        if ([newsDetailData.numOfNews isEqualToString:newsID]) {
            return newsDetailData;
        }
    }
    return NULL;
}

/*
 从数据库中更新一条数据
 */
+ (void)updateDataFromDatabase:(PZNewsDetailData *)newsDetailData
{
    [theApp.managedObjectContext refreshObject:newsDetailData mergeChanges:YES];
    NSError *error;
    if (![theApp.managedObjectContext save:&error]) {
        NSLog(@"Error while deleting from database: %@", [error userInfo]);
    }
}


+ (NSString *)adressOfImage:(NSString *)urlText
{
    urlText = [urlText stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    urlText = [urlText stringByReplacingOccurrencesOfString:@":" withString:@""];
    urlText = [urlText stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:@"photo"];
    NSString *filename = [NSString stringWithFormat:@"%@/%@", filepath, urlText];
    //    NSURL * imageUrl = [NSURL URLWithString:filename];
    
    return filename;
}

#pragma image
-(NSMutableArray *)AnalyticalImage:(NSString *)htmlString;{
    
    //    NSString *imageStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    //
    //    NSRange rang1=[imageStr rangeOfString:@"<div class=\"content\">"];
    //    NSMutableString *imageStr2=[[NSMutableString alloc]initWithString:[imageStr substringFromIndex:rang1.location+rang1.length]];
    //
    //    NSRange rang2=[imageStr2 rangeOfString:@"<div class=\"clear\">"];
    NSMutableString *imageStr3=[[NSMutableString alloc]initWithString:@"        本部讯：（摄影：何加劼 郑洁蕾 记者：曾惠君）2013年5月21日，由花都区文明办以及共青团花都区委员会主办，我校承办的首届花都区大学生&ldquo;健康从心开始，生活因你绽放&rdquo;心理话剧比赛(决赛)于我校礼堂隆重举行。出席本次决赛的嘉宾主要有花都区委宣传部副部长，文明办主任冯钰梅等政府领导，校长张蕾及各级校领导，花都区七大参赛高校的领导等。<br><br><img height='900' alt='' width='600' src='http://www.peizheng.cn/uploadfile/Article/UploadFiles/201305/20130521101617479.jpg' /><br>我校张蕾校长为本次决赛致辞<br><br>        在我校张蕾校长一番言简意赅的致辞后，紧张的决赛便拉开了帷幕。各高校参赛单位通过独特创新的表演方式，围绕大学生在现实生活中所遇到的关于亲情﹑友情﹑毕业﹑梦想的心理问题，向观众们展现了当今大学生丰富多彩而又复杂矛盾的内心精神世界。决赛过程中，各参赛单位的同学们倾情演绎不同的精彩故事，博得了观众们的阵阵掌声，同时引发我们对大学生心理问题的种种思考，给我们带来了心灵上的洗礼。<br><br><img height='427' alt='' width='640' src='http://www.peizheng.cn/uploadfile/Article/UploadFiles/201305/20130521102112932.jpg' /><br>我校参赛话剧----《迷途拾爱》<br><br>        随后，在宣布比赛结果前，我校大学生艺术团合唱队和外国语学院分别献上《风吹麦浪》和啦啦操的表演，缓和了现场紧张的气氛。经过激烈的角逐后，我校选送的参赛话剧《迷途拾爱》获得了网络最佳人气奖。而最佳创作奖则由广东交通职业技术学院的《最初的梦想》获得，优秀组织奖则由广东行政学院和我校广东培正学院获得。三等奖获奖单位为广东第二师范学院﹑广州工商职业技术学院﹑广州大学市政学院，二等奖获奖单位为华南理工大学广州学院﹑广州交通职业技术学院。而一等奖则由我校广东培正学院夺得。<br><br><img height='427' alt='' width='640' src='http://www.peizheng.cn/uploadfile/Article/UploadFiles/201305/20130521102551670.jpg' /><br>我校大学生艺术团合唱队表演节目----《风吹麦浪》<br><br><img height='427' alt='' width='640' src='http://www.peizheng.cn/uploadfile/Article/UploadFiles/201305/20130521104012778.jpg' /><br>领导嘉宾以及评委和各参赛队伍合影留念<br>        最后，花都区委宣传部副部长，花都区文明办主任冯钰梅的发言为本次决赛划上圆满的句号。她点明了创建精神文明和青年学生的人文关怀心理疏导的重要性，指出了良好的心理素质是成功的关键，并寄语各高校大学生要培养健康心理，健全人格，为中国梦的实现绽放青春之花。<br><br><br>"];
    
    //NSLog(@"%@",imageStr3);
    
    NSData *dataTitle=[imageStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:dataTitle];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//img"];
    
    
    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
    
    
    for (TFHppleElement *element in elements) {
        
        NSDictionary *elementContent =[element attributes];
        
        // NSLog(@"%@",[elementContent objectForKey:@"src"]);
        
        [imageArray addObject:[elementContent objectForKey:@"src"]];
    }
    
    return imageArray;
    
}
@end
