//
//  NSArray+Transform_Nitro.h
//  NitroNSArrayCategories
//
//  Created by Daniel L. Alves on 1/4/14.
//  Copyright (c) 2014 nitro. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @category Transform_Nitro
 */
@interface NSArray( Transform_Nitro )

/**
 *  Applies an operation sequentially to the elements of self, returning the results
 *  in a new array.
 * 
 *  Example:
 *
 *  @code
 *  NSArray *animals = @[ @"cat", @"dog", @"pig" ];
 *  NSArray *uppercasedAnimals = [animals transformWithSelector: @selector(uppercaseString)];
 *
 *  // The result is: @[ @"CAT", @"DOG", @"PIG" ];
 *  @endcode
 *
 *  @param selector The operation which must be applied to the elements of self
 *
 *  @return If the array is empty or selector is nil, returns self. Otherwise, 
 *          a new array containing the results of the operation.
 *
 *  @throws NSUndefinedKeyException on the first object to which selector is not appliable
 *
 *  @see transformWithSelector:andObject:
 *  @see transformWithBlock:
 */
-( NSArray * )transformWithSelector:( SEL )selector;

/**
 *  Applies an operation sequentially to the elements of self, returning the results
 *  in a new array. The parameter object is passed as an argument of selector in
 *  every call. Using a selector that receives more than one argument results in
 *  undefined behavior.
 * 
 *  Example:
 * 
 *  @code
 *  NSArray *animals = @[ @{ @"kind" : @"cat", @"id": @( 1 ) },
 *                        @{ @"kind" : @"dog", @"id": @( 2 ) },
 *                        @{ @"kind" : @"pig", @"id": @( 3 ) }];
 *  NSArray *animalKinds = [animals transformWithSelector: @selector(objectForKeyedSubscript:) andObject: @"kind"];
 *
 *  // The result is: @[ @"cat", @"dog", @"pig" ];
 *  @endcode
 *
 *  @param selector The operation which must be applied to the elements of self
 *
 *  @return If the array is empty or selector is nil, returns self. Otherwise,
 *          a new array containing the results of the operation.
 * 
 *  @throws NSInvalidArgumentException on the first object to which selector is not appliable or if
 *          selector receives no arguments
 *
 *  @see transformWithSelector:
 *  @see transformWithBlock:
 */
-( NSArray * )transformWithSelector:( SEL )selector andObject:( id )object;

/**
 *  Applies transformBlock sequentially to the elements of self, returning the results
 *  in a new array. The original object is passed to transformBlock in every call.
 *
 *  Example:
 *
 *  @code
 *  NSArray *animals = @[ @{ @"kind" : @"cat", @"id": @( 1 ) },
 *                        @{ @"kind" : @"dog", @"id": @( 2 ) },
 *                        @{ @"kind" : @"pig", @"id": @( 3 ) }];
 *  NSArray *animalKinds = [animals transformWithBlock: ^( NSObject *obj ){ return (( NSDictionary * )obj)[@"kind"]; }];
 *
 *  // The result is: @[ @"cat", @"dog", @"pig" ];
 *  @endcode
 *
 *  @param transformBlock The block which must be applied to the elements of self
 *
 *  @return If the array is empty or transformBlock is nil, returns self. Otherwise,
 *          a new array containing the results of transformBlock calls.
 *
 *  @see transformWithSelector:
 *  @see transformWithSelector:andObject:
 */
-( NSArray * )transformWithBlock:( NSObject* (^)( NSObject *obj ) )transformBlock;

@end
