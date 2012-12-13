//
//  SimpleDataErrorTests.m
//  JSONModelDemo
//
//  Created by Marin Todorov on 13/12/2012.
//  Copyright (c) 2012 Underplot ltd. All rights reserved.
//

#import "SimpleDataErrorTests.h"
#import "PrimitivesModel.h"
#import "NestedModel.h"

@implementation SimpleDataErrorTests

-(void)testMissingKeysError
{    
    NSString* filePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"primitivesWithErrors.json"];
    NSString* jsonContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSAssert(jsonContents, @"Can't fetch test data file contents.");
    
    NSError* err;
    PrimitivesModel* p = [[PrimitivesModel alloc] initWithString: jsonContents error:&err];
    NSAssert(!p, @"Model is not nil, when input is invalid");
    NSAssert(err, @"No error when keys are missing.");
    
    NSAssert(err.code == kJSONModelErrorInvalidData, @"Wrong error for missing keys");
}

-(void)testBrokenJSON
{
    NSString* jsonContents = @"{[1,23,4],\"123\":123,}";

    NSError* err;
    PrimitivesModel* p = [[PrimitivesModel alloc] initWithString: jsonContents error:&err];
    NSAssert(!p, @"Model is not nil, when input is invalid");
    NSAssert(err, @"No error when keys are missing.");
    
    NSAssert(err.code == kJSONModelErrorBadJSON, @"Wrong error for missing keys");
}

-(void)testErrorsInNestedModels
{
    NSString* filePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"nestedDataWithErrors.json"];
    NSString* jsonContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSAssert(jsonContents, @"Can't fetch test data file contents.");
    
    NSError* err;
    NestedModel* n = [[NestedModel alloc] initWithString: jsonContents error:&err];
    NSAssert(err, @"No error thrown when loading invalid data");
    
    NSAssert(!n, @"Model is not nil, when invalid data input");
    NSAssert(err.code == kJSONModelErrorInvalidData, @"Wrong error for missing keys");
}

@end
