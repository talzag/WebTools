//
//  SourceEditorCommand.m
//  CSS Tools
//
//  Created by Daniel Strokis on 7/15/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "CSSVariableCommand.h"

@implementation CSSVariableCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    NSError *error;
    if (![self content:[invocation buffer] IsCSS:&error]) {
        completionHandler(nil);
        return;
    }
    
    NSString *cssVariableLiteral = @"--<#variable#> : <#value#>";
    
    // If user selected text, let's just put the variable at the top of the selection
    XCSourceTextPosition start =  [[[[invocation buffer] selections] firstObject] start];
    
    //FIXME: take into account tabs vs. spaces here
    NSString *spaces = [NSString string];
    NSUInteger i;
    for (i = 0; i < start.column; i++) {
        spaces = [spaces stringByAppendingString:@" "];
    }

    cssVariableLiteral = [spaces stringByAppendingString:cssVariableLiteral];
    
    // if cursor is on an empty line, we can replace the empty line with the variable literal
    // otherwise push the line down and insert the variable above it
    if ([self shouldReplaceLineAtPosition:start InBuffer:[invocation buffer]]) {
        [[[invocation buffer] lines] replaceObjectAtIndex:start.line withObject:cssVariableLiteral];
    } else {
        [[[invocation buffer] lines] insertObject:cssVariableLiteral atIndex:start.line];
    }
    
    XCSourceTextPosition end = XCSourceTextPositionMake(start.line, start.column + cssVariableLiteral.length - 1);
    XCSourceTextRange *literalSelection = [[XCSourceTextRange alloc] initWithStart:start end:end];
    if (literalSelection) {
        [[[invocation buffer] selections] setArray:@[literalSelection]];
    }
    
    completionHandler(nil);
}

@end
