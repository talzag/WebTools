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
    
    // FIXME: parse @charset rule
    
    // FIXME: iterate through 
    const char *cBuffer = [bufferCopy UTF8String];
    size_t cBuffLen = strnlen(cBuffer, MAXBSIZE);
    size_t newBuffSize = MAX(MAXBSIZE, cBuffLen * 2);
    char *newBuffer = malloc(newBuffSize * sizeof(char));
    
    prettyprint((char *)cBuffer, newBuffer);
    
    NSString *replacementBuffer = [NSString stringWithUTF8String:newBuffer];
    [[invocation buffer] setCompleteBuffer:replacementBuffer];
    
    free(newBuffer);
    
    completionHandler(nil);
}

@end
