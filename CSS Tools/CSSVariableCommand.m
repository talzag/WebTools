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
        completionHandler(error);
        return;
    }
    
    NSString *cssVariableLiteral = @"--<#variable#> : <#value#>";
    NSInteger insertionIndex = 0;
    
    BOOL replacesLine = NO;
    
    // If user selected text, let's just put the variable at the top
    NSArray <XCSourceTextRange *> *selections = [[invocation buffer] selections];
    if ([selections count] > 0) {
        XCSourceTextPosition start =  [[selections firstObject] start];
        
        NSString *cursorLine = [[[invocation buffer] lines] objectAtIndex:start.line];
        NSString *trimmedLine = [cursorLine stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (![trimmedLine length]) {
            replacesLine = YES;
        }
        
        insertionIndex = start.line;
        
        //FIXME: take into account tabs vs. spaces here
        NSString *spaces = [NSString string];
        NSUInteger i;
        for (i = 0; i < start.column; i++) {
            spaces = [spaces stringByAppendingString:@" "];
        }
        
        cssVariableLiteral = [spaces stringByAppendingString:cssVariableLiteral];
    }
    
    if (replacesLine) {
        [[[invocation buffer] lines] replaceObjectAtIndex:insertionIndex
                                               withObject:cssVariableLiteral];
    } else {
        [[[invocation buffer] lines] insertObject:cssVariableLiteral
                                          atIndex:insertionIndex];
    }
    
    completionHandler(nil);
}

@end
