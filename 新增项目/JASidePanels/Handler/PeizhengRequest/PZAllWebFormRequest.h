//
//  PZAllWebFormRequest.h
//  培正梦飞翔
//
//  Created by Air on 13-6-24.
//
//

#import <Foundation/Foundation.h>
@class PZAllWebFormViewController;

@interface PZAllWebFormRequest : NSObject
{
    PZAllWebFormViewController * _allWebFormViewController;
}
@property (nonatomic , retain)PZAllWebFormViewController * allWebFormViewController;
- (void)AllWebFormRequest;

@end
