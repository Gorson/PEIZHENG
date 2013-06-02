//
//  NSObject+Additions.m
//  TicketChina
//
//  Created by liu jiada on 1/4/12.
//  Copyright (c) 2012 Wistronits. All rights reserved.
//

#import "NSObject+Additions.h"

#import <objc/runtime.h>

@implementation NSObject(Additions)

- (BOOL)hasProperty:(NSString *)property {
    BOOL isExists = NO;
    
    unsigned int numberOfIvars = 0;
    Ivar* ivars = class_copyIvarList([self class], &numberOfIvars);
    for(const Ivar* p = ivars; p < ivars+numberOfIvars; p++) {
        Ivar const ivar = *p;
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if([key isEqual:property]) {
            isExists = YES;
            break;
        }
    }
    
    return isExists;
}

@end
