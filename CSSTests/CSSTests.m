//
//  CSSTests.m
//  CSSTests
//
//  Created by Daniel Strokis on 10/28/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "cssprettyprint.h"
#import "cssprettyprint-private.h"

static char *outBuffer;

@interface CSSTests : XCTestCase

@end

@implementation CSSTests

- (void)setUp {
    [super setUp];
    
    size_t bufsiz = 256 * sizeof(char);
    outBuffer = (char *)malloc(bufsiz);
    memset(outBuffer, 0, bufsiz);
}

- (void)tearDown {
    free(outBuffer);
    
    [super tearDown];
}

- (void)testNext {
    char result;
    
    NSString *source = @"body { color: red; }";
    
    const char *cSrc = [source UTF8String];
    size_t len = [source lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    result = next(0, (char *)cSrc, len);
    XCTAssertEqual('o', result);
    
    result = next((int)len, (char *)cSrc, len);
    XCTAssertEqual('\0', result);
}

- (void)testSkipSpace {
    
}

- (void)testAddNewLine {
    
}

- (void)testIndent {
    
}

- (void)testConsumeComment {
    
}

@end
