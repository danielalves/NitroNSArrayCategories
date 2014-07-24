//
//  NSArray+Utils_Nitro.m
//  nitro
//
//  Created by Daniel L. Alves on 5/31/12.
//  Copyright (c) 2012 nitro. All rights reserved.
//

#import "NSArray+Utils_Nitro.h"

#pragma mark - Implementation

@implementation NSArray( Utils_Nitro )

-( id )nilOrObjectAtIndex:( NSUInteger )index
{
	if( index >= [self count] )
		return nil;
	
	return [self objectAtIndex: index];
}

-( id )nsnullOrObjectAtIndex:( NSUInteger )index
{
	id temp = [self nilOrObjectAtIndex: index];
	return  temp ? temp : [NSNull null];
}

-( NSArray * )objectsPassingTest:(BOOL (^)( id obj, NSUInteger idx, BOOL *stop ))predicate
{
    NSIndexSet *indexes = [self indexesOfObjectsPassingTest: predicate];
    return [self objectsAtIndexes: indexes];
}

@end
