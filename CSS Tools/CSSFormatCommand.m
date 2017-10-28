//
//  CSSFormatCommand.m
//  WebTools
//
//  Created by Daniel Strokis on 7/28/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "CSSFormatCommand.h"
#import "cssprettyprint.h"

@implementation CSSFormatCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation
                   completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    NSError *error;
    if (![self content:[invocation buffer] isCSS:&error]) {
        completionHandler(nil);
        return;
    }
    
    NSString *bufferCopy = [[invocation buffer] completeBuffer];
    
    const char *cBuffer = [bufferCopy UTF8String];
    NSUInteger cBuffLen = [bufferCopy lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSUInteger newBuffSize = MIN(MAXBSIZE, cBuffLen * 2);
    char *newBuffer = (char *)malloc(newBuffSize * sizeof(char));
    memset(newBuffer, 0, newBuffSize);
    
    prettyprint((char *)cBuffer, newBuffer, cBuffLen);
    
    NSString *replacementBuffer = [NSString stringWithUTF8String:newBuffer];
    [[invocation buffer] setCompleteBuffer:replacementBuffer];
    
    free(newBuffer);
    
    completionHandler(nil);
}

@end
