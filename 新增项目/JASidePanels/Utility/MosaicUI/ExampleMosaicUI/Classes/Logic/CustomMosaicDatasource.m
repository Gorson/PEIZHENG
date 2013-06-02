//
//  MosaicManager.m
//  MosaicUI
//
//  Created by Ezequiel Becerra on 10/23/12.
//  Copyright (c) 2012 betzerra. All rights reserved.
//

#import "CustomMosaicDatasource.h"
#import "MosaicData.h"
#import "NSString+BSJSONAdditions.h"
@implementation CustomMosaicDatasource

#pragma mark - Private

-(void)loadFromDisk{
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"mainViewData" ofType:@"json"];
    NSData *elementsData = [NSData dataWithContentsOfFile:pathString];

    NSError *anError = nil;
    NSArray *parsedElements = [NSJSONSerialization JSONObjectWithData:elementsData
                                                              options:NSJSONReadingAllowFragments
                                                                error:&anError];
    
    for (NSDictionary *aModuleDict in parsedElements){
        MosaicData *aMosaicModule = [[MosaicData alloc] initWithDictionary:aModuleDict];
        [elements addObject:aMosaicModule];
    }
}

-(void)loadFromServer{
    
    [self startRequest];
}

-(void)startRequest
{
    NSString *strURL = [[NSString alloc]initWithFormat:@"http://www.peizheng.cn/mobile/index.php?interfaceid=0101&page=1&limit=1"]; 
    NSURL *url = [NSURL URLWithString:strURL];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];                                              
    [request startSynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request                               
{
    NSData *data  = [request responseData];
    NSDictionary *resDict = [NSJSONSerialization
                             JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([[resDict valueForKey:@"hasdata"]isEqualToString:@"1"]) {
       NSArray * dataContents =[resDict valueForKey:@"newsHead"];
        for (NSDictionary *aModuleDict in dataContents){
            MosaicData *aMosaicModule = [[MosaicData alloc] initWithDictionary:aModuleDict];
            [elements addObject:aMosaicModule];
        }
        
    }
//    [self reloadView:resDict];
}
- (void)requestFailed:(ASIHTTPRequest *)request                             
{
    NSError *error = [request error];
    NSLog(@"%@", [error localizedDescription]);
}

#pragma mark - Public

-(id)init{
    self = [super init];

    if (self){
        elements = [[NSMutableArray alloc] init];
        [self loadFromDisk];
    }
    
    return self;
}

//  Singleton method proposed in WWDC 2012
+ (CustomMosaicDatasource *)sharedInstance {
	static CustomMosaicDatasource *sharedInstance;
	if (sharedInstance == nil)
		sharedInstance = [CustomMosaicDatasource new];
	return sharedInstance;
}

#pragma mark - MosaicViewDatasourceProtocol

-(NSArray *)mosaicElements{
    NSArray *retVal = elements;
    return retVal;
}

@end
