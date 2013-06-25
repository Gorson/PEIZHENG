//
//  PZAllWebFormData.h
//  培正梦飞翔
//
//  Created by Air on 13-6-24.
//
//

#import <Foundation/Foundation.h>

@interface PZAllWebFormData : NSObject

@property (nonatomic, retain) NSString *booktime;
@property (nonatomic, retain) NSString *computertype;
@property (nonatomic, retain) NSString *listid;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *submittime;
@property (nonatomic, retain) NSString *uname;

-(id)initWithDictionary:(NSMutableDictionary *)aDict;
@end
