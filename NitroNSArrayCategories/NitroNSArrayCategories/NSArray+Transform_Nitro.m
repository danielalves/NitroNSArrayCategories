//
//  NSArray+Trasform_Nitro.m
//  nitro
//
//  Created by Daniel L. Alves on 1/4/14.
//  Copyright (c) 2014 nitro. All rights reserved.
//

#import "NSArray+Trasform_Nitro.h"

// nitro
#import "NSInvocation+Utils_Nitro.h"

#pragma mark - Implementation

@implementation NSArray( Trasform_Nitro )

-( NSArray * )transformWithSelector:( SEL )selector
{
    if( !selector )
        return self;

    NSString *key = NSStringFromSelector( selector );
    return [self valueForKey: key];
}

-( NSArray * )transformWithSelector:( SEL )selector andObject:( id )object
{
    NSUInteger selfCount = self.count;
    if( !selector || !selfCount )
        return self;

    NSMutableArray *temp = [NSMutableArray arrayWithCapacity: selfCount];
    for( NSObject *arrayObj in self )
    {
        id result;
        
        // OLD : performSelector:withObject: crashes the running code (EXC_BAD_ACCESS) when we pass a selector
        // that receives no arguments as a parameter. NSInvocation, on the other hand, raises a NSInvalidArgumentException,
        // what we found a lot better since the exception object contains more information on why the code failed
//        SuppressPerformSelectorLeakWarning( result = [arrayObj performSelector: selector withObject: object] );
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature: [arrayObj methodSignatureForSelector: selector]];
        invocation.selector = selector;
        [invocation setArgument: &object atIndex: [NSInvocation firstArgumentIndex]];
        [invocation invokeWithTarget: arrayObj];
        [invocation getReturnValue: &result];
        
        [temp addObject: result ? result : [NSNull null]];
    }
    
    return temp;
}

-( NSArray * )transformWithBlock:( NSObject*(^)( NSObject *obj ) )transformBlock
{
    NSUInteger selfCount = self.count;
    if( !transformBlock || !selfCount )
        return self;
    
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity: selfCount];
    for( NSObject *arrayObj in self )
    {
        id result = transformBlock( arrayObj );
        [temp addObject: result ? result : [NSNull null]];
    }
    
    return temp;
}

@end
