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
static size_t bufsiz = 256 * sizeof(char);

@interface CSSTests : XCTestCase

@end

@implementation CSSTests

- (void)setUp {
    [super setUp];
    
    outBuffer = (char *)malloc(bufsiz);
    memset(outBuffer, 0, bufsiz);
}

- (void)tearDown {
    free(outBuffer);
    
    [super tearDown];
}

- (void)testNext {
    char result;
    
    NSString *src = @"body { color: red; }";
    
    const char *cSrc = [src UTF8String];
    size_t len = [src lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    result = next(0, (char *)cSrc, len);
    XCTAssertEqual('o', result);
    
    result = next((int)len, (char *)cSrc, len);
    XCTAssertEqual('\0', result);
}

- (void)testSkipSpace {
    NSString *src = @"    body { color: red; }"; // 4 leading spaces
    const char *cSrc = [src UTF8String];
    size_t len = [src lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    int i = 0;
    skipSpace(&i, (char *)cSrc, len);
    XCTAssertEqual(i, 3);
}

- (void)testAddNewLine {
    char first;
    
    first = outBuffer[0];
    XCTAssertEqual('\0', first);
    
    addNewLine(0, "", 0, outBuffer);
    
    first = outBuffer[0];
    XCTAssertEqual('\n', first);
}

- (void)testIndent {
    XCTAssertEqual(0, strncmp("", outBuffer, bufsiz));
    indent((char *)outBuffer, 1, 0);
    XCTAssertEqual(0, strncmp("    ", outBuffer, bufsiz));
}

- (void)testConsumeComment {
    NSString *src = @"/* comment A */ ";
    
    const char *cSrc = [src UTF8String];
    size_t len = [src lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    int i = 0;
    consumeComment(&i, outBuffer, (char *)cSrc, len);
    
    XCTAssertEqual(i, len - 1);
    XCTAssertEqual(' ', cSrc[i]);
}

- (void)testPrettyPrintComment {
    NSString *src = @"/* comment A *//* comment B */";
    const char *cSrc = [src UTF8String];
    size_t len = [src lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    
    prettyprint((char *)cSrc, outBuffer, len);
    
    NSString *expected = @"/* comment A */\n/* comment B */\n";
    int result = strncmp(outBuffer, [expected UTF8String], bufsiz);
    
    XCTAssertEqual(result, 0);
}

@end
