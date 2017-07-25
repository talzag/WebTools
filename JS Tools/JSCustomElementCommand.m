//
//  JSCustomElementCommand.m
//  WebTools
//
//  Created by Daniel Strokis on 7/25/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "JSCustomElementCommand.h"

@implementation JSCustomElementCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation
                   completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    NSError *error;
    if (![self content:[invocation buffer] isJS:&error]) {
        completionHandler(nil);
        return;
    }
    
    NSString *customElementTemplate =
    @"class <#ElementName > extends HTMLElement {\n"
    ""
    "}\n"
    "\n";
    
    // TODO: Check selections. Overwrite selected lines, or insert at cursor
    XCSourceTextRange *cursor = [[[invocation buffer] selections] firstObject];
    XCSourceTextPosition insertionPoint = [cursor start];
    
    [[[invocation buffer] lines] insertObject:customElementTemplate atIndex:insertionPoint.line];
    
    completionHandler(nil);
}

@end
