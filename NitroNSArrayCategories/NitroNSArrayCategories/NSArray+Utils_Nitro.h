//
//  NSArray+Utils_Nitro.h
//  NitroNSArrayCategories
//
//  Created by Daniel L. Alves on 5/31/12.
//  Copyright (c) 2012 nitro. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @category Utils_Nitro
 */
@interface NSArray( Utils_Nitro )

/**
 *  Returns the object located at the specified index, or nil if index
 *  is out of the array bounds
 *
 *  @param index The desired object index
 *
 *  @return The object located at index, or nil if index is out of the
 *          array bounds
 *
 *  @see nsnullOrObjectAtIndex:
 */
-( id )nilOrObjectAtIndex:( NSUInteger )index;

/**
 *  Returns the object located at the specified index, or NSNull if index
 *  is out of the array bounds
 *
 *  @param index The desired object index
 *
 *  @return The object located at index, or NSNull if index is out of the
 *          array bounds
 *
 *  @see nilOrObjectAtIndex:
 */
-( id )nsnullOrObjectAtIndex:( NSUInteger )index;

/**
 *  Returns the objects in the array that pass a test in a given block.
 *
 *  @param predicate The block to apply to elements in the array.
 *
 *  @paragraph
 *  The block takes three arguments:
 *
 *  @paragraph
 *  obj
 *
 *    The element in the array.
 *
 *  @paragraph
 *  idx
 * 
 *    The index of the element in the array.
 *
 *  @paragraph
 *  stop
 *
 *    A reference to a Boolean value. The block can set the value to YES to stop further
 *  processing of the array. The stop argument is an out-only argument. You should only
 *  ever set this Boolean to YES within the block.
 *
 *  @paragraph
 *  The block returns a Boolean value that indicates whether obj passed the test.
 *
 *  @return The objects in the array that pass the test specified by predicate. If no objects 
 *          in the array pass the test, or predicate is nil, returns an empty array.
 */
-( NSArray * )objectsPassingTest:( BOOL (^)( id obj, NSUInteger idx, BOOL *stop ))predicate;

@end
