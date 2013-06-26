//
//  PZDetailOfFormData.h
//  培正梦飞翔
//
//  Created by Air on 13-6-25.
//
//

#import <Foundation/Foundation.h>

@interface PZDetailOfFormData : NSObject
@property (nonatomic, retain) NSString *area;
@property (nonatomic, retain) NSString *booktime;
@property (nonatomic, retain) NSString *computertype;
@property (nonatomic, retain) NSString *dorm;
@property (nonatomic, retain) NSString *listid;
@property (nonatomic, retain) NSString *pcnumber;
@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *remark;
@property (nonatomic, retain) NSString *reviewlevel;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *time;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *uname;

-(id)initWithDictionary:(NSMutableDictionary *)aDict;
@end
