//
//  NitroNSArrayTransformTests.m
//  NitroNSArrayCategoriesTests
//
//  Created by Daniel L. Alves on 17/7/14.
//  Copyright (c) 2014 Daniel L. Alves. All rights reserved.
//

#import <XCTest/XCTest.h>

// NitroNSArrayCategories
#import "NSArray+Transform_Nitro.h"

#pragma mark - Interface

@interface NitroNSArrayTransformTests : XCTestCase
@end

#pragma mark - Implementation

@implementation NitroNSArrayTransformTests

#pragma mark - transformWithSelector:

-( void )test_transformWithSelector_calls_selector_on_all_elements_of_self_and_returns_a_new_array
{
    NSArray *animals = @[ @"cat", @"dog", @"pig" ];
    NSArray *uppercasedAnimals = [animals transformWithSelector: @selector(uppercaseString)];
    
    NSArray *expected = @[ @"CAT", @"DOG", @"PIG" ];
    
    XCTAssertNotEqual( animals, uppercasedAnimals );
    XCTAssertEqualObjects( uppercasedAnimals, expected );
}

-( void )test_transformWithSelector_returns_self_on_nil_selector
{
    NSArray *animals = @[ @"cat", @"dog", @"pig" ];
    NSArray *expected = @[ @"cat", @"dog", @"pig" ];
    
    XCTAssertEqual( [animals transformWithSelector: nil], animals );
    XCTAssertEqualObjects( animals, expected );
}

-( void )test_transformWithSelector_returns_self_on_empty_arrays
{
    NSArray *animals = @[];
    NSArray *expected = @[];
    
    XCTAssertEqual( [animals transformWithSelector: @selector(uppercaseString)], animals );
    XCTAssertEqualObjects( animals, expected );
}

-( void )test_transformWithSelector_returns_self_on_nil_selector_and_empty_array
{
    NSArray *animals = @[];
    NSArray *expected = @[];
    
    XCTAssertEqual( [animals transformWithSelector: nil], animals );
    XCTAssertEqualObjects( animals, expected );
}

-( void )test_transformWithSelector_throws_NSUndefinedKeyException_on_the_first_object_which_does_not_respond_to_selector
{
    NSArray *mixed = @[ @"cat", @100, @"pig" ];
    
    XCTAssertThrowsSpecificNamed( [mixed transformWithSelector: @selector(uppercaseString)], NSException, NSUndefinedKeyException );
    XCTAssertThrowsSpecificNamed( [mixed transformWithSelector: @selector(objCType)], NSException, NSUndefinedKeyException );
}

#pragma mark - transformWithSelector:andObject:

-( void )test_transformWithSelector_andObject_calls_selector_on_all_elements_of_self_and_returns_a_new_array
{
    NSArray *animals = @[ @{ @"kind" : @"cat", @"id": @( 1 ) },
                          @{ @"kind" : @"dog", @"id": @( 2 ) },
                          @{ @"kind" : @"pig", @"id": @( 3 ) } ];
    
    NSArray *animalKinds = [animals transformWithSelector: @selector(objectForKeyedSubscript:) andObject: @"kind"];

    NSArray *expected = @[ @"cat", @"dog", @"pig" ];
    
    XCTAssertNotEqual( animals, animalKinds );
    XCTAssertEqualObjects( animalKinds, expected );
}

-( void )test_transformWithSelector_andObject_returns_self_on_nil_selector
{
    NSArray *animals = @[ @{ @"kind" : @"cat", @"id": @( 1 ) },
                          @{ @"kind" : @"dog", @"id": @( 2 ) },
                          @{ @"kind" : @"pig", @"id": @( 3 ) } ];
    
    NSArray *expected = @[ @{ @"kind" : @"cat", @"id": @( 1 ) },
                           @{ @"kind" : @"dog", @"id": @( 2 ) },
                           @{ @"kind" : @"pig", @"id": @( 3 ) } ];
    
    XCTAssertEqual( [animals transformWithSelector: nil andObject: @"kind"], animals );
    XCTAssertEqualObjects( animals, expected );
}

-( void )test_transformWithSelector_andObject_returns_self_on_empty_arrays
{
    NSArray *animals = @[];
    NSArray *expected = @[];
    
    XCTAssertEqual( [animals transformWithSelector: @selector(objectForKeyedSubscript:) andObject: @"kind"], animals );
    XCTAssertEqualObjects( animals, expected );
}

-( void )test_transformWithSelector_andObject_returns_self_on_nil_selector_and_empty_array
{
    NSArray *animals = @[];
    NSArray *expected = @[];
    
    XCTAssertEqual( [animals transformWithSelector: nil andObject:  @"kind"], animals );
    XCTAssertEqualObjects( animals, expected );
}

-( void )test_transformWithSelector_andObject_throws_NSInvalidArgumentException_on_the_first_object_which_does_not_respond_to_selector
{
    NSArray *mixed = @[ @{ @"kind" : @"cat", @"id": @( 1 ) },
                        @100,
                        @{ @"kind" : @"pig", @"id": @( 3 ) } ];
    
    XCTAssertThrowsSpecificNamed( [mixed transformWithSelector: @selector(objectForKeyedSubscript:) andObject: @"kind"], NSException, NSInvalidArgumentException );
}

-( void )test_transformWithSelector_andObject_throws_NSInvalidArgumentException_on_selector_that_do_not_receive_parameters
{
    NSArray *animals = @[ @{ @"kind" : @"cat", @"id": @( 1 ) },
                          @{ @"kind" : @"dog", @"id": @( 2 ) },
                          @{ @"kind" : @"pig", @"id": @( 3 ) } ];
    
    XCTAssertThrowsSpecificNamed( [animals transformWithSelector: @selector(count) andObject: @"kind"], NSException, NSInvalidArgumentException );
}

#pragma mark - transformWithBlock:

-( void )test_transformWithBlock_calls_block_on_all_elements_of_self_and_returns_a_new_array
{
    NSArray *animals = @[ @{ @"kind" : @"cat", @"id": @( 1 ) },
                          @{ @"kind" : @"dog", @"id": @( 2 ) },
                          @{ @"kind" : @"pig", @"id": @( 3 ) } ];
    
    NSArray *animalIds = [animals transformWithBlock:^NSObject *(NSObject *obj) {
        return (( NSDictionary * )obj)[ @"id"];
    }];
    
    NSArray *expected = @[ @1, @2, @3 ];
    
    XCTAssertNotEqual( animals, animalIds );
    XCTAssertEqualObjects( animalIds, expected );
}

-( void )test_transformWithBlock_returns_self_on_nil_block
{
    NSArray *animals = @[ @{ @"kind" : @"cat", @"id": @( 1 ) },
                          @{ @"kind" : @"dog", @"id": @( 2 ) },
                          @{ @"kind" : @"pig", @"id": @( 3 ) } ];
    
    NSArray *expected = @[ @{ @"kind" : @"cat", @"id": @( 1 ) },
                           @{ @"kind" : @"dog", @"id": @( 2 ) },
                           @{ @"kind" : @"pig", @"id": @( 3 ) } ];
    
    XCTAssertEqual( [animals transformWithBlock: nil], animals );
    XCTAssertEqualObjects( animals, expected );
}

-( void )test_transformWithBlock_returns_self_on_empty_arrays
{
    NSArray *animals = @[];
    NSArray *expected = @[];
    
    XCTAssertEqual( [animals transformWithBlock:^NSObject *( NSObject *obj ) {
        return obj;
    }], animals );
    
    XCTAssertEqualObjects( animals, expected );
}

-( void )test_transformWithBlock_returns_self_on_empty_arrays_and_nil_block
{
    NSArray *animals = @[];
    NSArray *expected = @[];
    
    XCTAssertEqual( [animals transformWithBlock: nil], animals );
    XCTAssertEqualObjects( animals, expected );
}

@end


















































