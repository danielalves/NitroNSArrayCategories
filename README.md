NitroNSArrayCategories
======================

[![CocoaPods](https://cocoapod-badges.herokuapp.com/v/NitroNSArrayCategories/badge.png)](http://cocoapods.org/?q=NitroNSArrayCategories)
[![Platform](http://cocoapod-badges.herokuapp.com/p/NitroNSArrayCategories/badge.png)](http://cocoadocs.org/docsets/NitroNSArrayCategories)
[![TravisCI](https://travis-ci.org/danielalves/NitroNSArrayCategories.svg?branch=master)](https://travis-ci.org/danielalves/NitroNSArrayCategories)

**NitroNSArrayCategories** offers some `NSArray` missing features and utilities. You will find:
- Transform methods
- Safe indexing methods
- Filtering methods

Examples
--------

**1) Transform methods**

Apply an operation on every array object returning the results in a new array.

```objc
NSArray *incredibles = @[ @"Mr. Incredible", @"Elastigirl", @"Violet", @"Dash", @"Jack-Jack" ];

// With selectors that receive no arguments:
// uppercasedIncredibles will be @[ @"MR. INCREDIBLE", @"ELASTIGIRL", @"VIOLET", @"DASH", @"JACK-JACK"];
NSArray *uppercasedIncredibles = [incredibles transformWithSelector: @selector(uppercaseString)];

// ...

NSArray *animals = @[ @{ @"kind" : @"cat", @"id": @( 1 ) },
                      @{ @"kind" : @"dog", @"id": @( 2 ) },
                      @{ @"kind" : @"pig", @"id": @( 3 ) } ];

// With selectors that receive one argument:
// animalKinds will be @[ @"cat", @"dog", @"pig" ]
NSArray *animalKinds = [animals transformWithSelector: @selector(objectForKeyedSubscript:) 
                                            andObject: @"kind"];

// With blocks:
// animalsIds will be @[ @1, @2, @3 ]
NSArray *animalIds = [animals transformWithBlock: ^NSObject * ( NSObject *obj ){
    return (( NSDictionary * )obj)[ @"id"];
}];
```

**2) Safe indexing methods**

Return `nil` (or `NSNull`) if an index is out of bounds:

```objc
NSArray *array = @[ @1, @2, @3 ];

[array nilOrObjectAtIndex: 2]; // Returns @3
[array nilOrObjectAtIndex: 3]; // Returns nil
[array nsnullOrObjectAtIndex: 90]; // Returns [NSNull null]
```

**3) Filtering methods**

Tired of calling `indexesOfObjectsPassingTest:` and then `objectsAtIndexes:`? There you go:

```objc
NSArray *array = @[ @0, @1, @2, @3, @4, @5, @6, @7, @8, @9 ];
    
// oddNumbers will be @[ @1, @3, @5, @7, @9 ];
NSArray *oddNumbers = [array objectsPassingTest: ^BOOL( id obj, NSUInteger idx, BOOL *stop ){
    return ([( NSNumber * )obj intValue] & 1 ) != 0;
}];
```

Requirements
------------

iOS 4.3 or higher, ARC only

Installation
------------

**NitroNSArrayCategories** is available through [CocoaPods](http://cocoapods.org), to install it simply add the following line to your Podfile:

```ruby
pod "NitroNSArrayCategories"
```

**NitroNSArrayCategories** adds the `-ObjC` linker flag to targets using it. Without it, categories code would be stripped out, resulting in linker errors. For more info about categories inside static libraries, see: [Building Objective-C static libraries with categories](https://developer.apple.com/library/mac/qa/qa1490/_index.html)

Author
------

- [Daniel L. Alves](http://github.com/danielalves) ([@alveslopesdan](https://twitter.com/alveslopesdan))

License
-------

**NitroNSArrayCategories** is available under the MIT license. See the LICENSE file for more info.
