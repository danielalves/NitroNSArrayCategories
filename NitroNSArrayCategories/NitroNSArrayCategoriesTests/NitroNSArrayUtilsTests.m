//
//  NitroNSArrayUtilsTests.m
//  NitroNSArrayCategoriesTests
//
//  Created by Daniel L. Alves on 17/7/14.
//  Copyright (c) 2014 Daniel L. Alves. All rights reserved.
//

#import <XCTest/XCTest.h>

// NitroNSArrayCategories
#import "NSArray+Utils_Nitro.h"

#pragma mark - Interface

@interface NitroNSArrayUtilsTests : XCTestCase
@end

#pragma mark - Implementation

@implementation NitroNSArrayUtilsTests

#pragma mark - nilOrObjectAtIndex:

-( void )test_nilOrObjectAtIndex_returns_object_at_index_if_index_is_valid
{
    NSArray *array = @[ @1, @2, @3 ];
    XCTAssertEqualObjects( [array nilOrObjectAtIndex: 2], @3 );
    
    array = @[ @1 ];
    XCTAssertEqualObjects( [array nilOrObjectAtIndex: 0], @1 );
}

-( void )test_nilOrObjectAtIndex_returns_object_at_index_if_index_is_out_of_bounds
{
    NSArray *array = @[ @1, @2, @3 ];
    XCTAssertNil( [array nilOrObjectAtIndex: 3] );
    
    array = @[ @1 ];
    XCTAssertNil( [array nilOrObjectAtIndex: 1] );
    
    array = @[];
    XCTAssertNil( [array nilOrObjectAtIndex: 0] );
}

#pragma mark - nsnullOrObjectAtIndex:

-( void )test_nsnullOrObjectAtIndex_returns_object_at_index_if_index_is_valid
{
    NSArray *array = @[ @1, @2, @3 ];
    XCTAssertEqualObjects( [array nsnullOrObjectAtIndex: 2], @3 );
    
    array = @[ @1 ];
    XCTAssertEqualObjects( [array nsnullOrObjectAtIndex: 0], @1 );
}

-( void )test_nsnullOrObjectAtIndex_returns_object_at_index_if_index_is_out_of_bounds
{
    NSArray *array = @[ @1, @2, @3 ];
    XCTAssertEqual( [array nsnullOrObjectAtIndex: 3], [NSNull null] );
    
    array = @[ @1 ];
    XCTAssertEqual( [array nsnullOrObjectAtIndex: 1], [NSNull null] );
    
    array = @[];
    XCTAssertEqual( [array nsnullOrObjectAtIndex: 0], [NSNull null] );
}

#pragma mark - objectsPassingTest:

-( void )test_objectsPassingTest_returns_objects_passing_test
{
    NSArray *array = @[ @0, @1, @2, @3, @4, @5, @6, @7, @8, @9 ];
    
    NSArray *oddNumbers = [array objectsPassingTest: ^BOOL( id obj, NSUInteger idx, BOOL *stop ){
        return ([( NSNumber * )obj intValue] & 1 ) != 0;
    }];
    
    XCTAssertNotEqual( array, oddNumbers );
    
    NSArray *expected = @[ @1, @3, @5, @7, @9 ];
    XCTAssertEqualObjects( oddNumbers, expected );
}

-( void )test_objectsPassingTest_stops_when_stop_is_set_to_YES
{
    NSArray *array = @[ @0, @1, @2, @3, @4, @5, @6, @7, @8, @9 ];
    
    NSArray *firstNumberGreaterThan5 = [array objectsPassingTest: ^BOOL( id obj, NSUInteger idx, BOOL *stop ){
        *stop = [( NSNumber * )obj intValue] > 5;
        return *stop;
    }];
    
    XCTAssertNotEqual( array, firstNumberGreaterThan5 );
    
    NSArray *expected = @[ @6 ];
    XCTAssertEqualObjects( firstNumberGreaterThan5, expected );
}

-( void )test_objectsPassingTest_returns_an_empty_array_when_no_object_passes_test
{
    NSArray *array = @[ @0, @1, @2, @3, @4, @5, @6, @7, @8, @9 ];
    
    NSArray *numbersGreaterThan10 = [array objectsPassingTest: ^BOOL( id obj, NSUInteger idx, BOOL *stop ){
        return [( NSNumber * )obj intValue] > 10;
    }];
    
    XCTAssertNotEqual( array, numbersGreaterThan10 );
    
    NSArray *expected = @[];
    XCTAssertEqualObjects( numbersGreaterThan10, expected );
}

-( void )test_objectsPassingTest_returns_an_empty_array_on_nil_predicate
{
    NSArray *array = @[ @0, @1, @2, @3, @4, @5, @6, @7, @8, @9 ];
    
    NSArray *nothingness = [array objectsPassingTest: nil];
    
    XCTAssertNotEqual( array, nothingness );
    
    NSArray *expected = @[];
    XCTAssertEqualObjects( nothingness, expected );
}

@end











































