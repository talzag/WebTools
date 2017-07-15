//
//  SourceEditorCommand.m
//  CSS Tools
//
//  Created by Daniel Strokis on 7/15/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "CSSVariableCommand.h"

@implementation CSSVariableCommand

static NSString *CSSErrorDomain = @"com.dstrokis.WebTools.CSS-Tools.Error";
static NSString *kUTTypeCSS = @"public.css";

typedef NS_ENUM(NSUInteger, CSSErrorCode) {
    CSSErrorNotCSS
};

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    BOOL isCSS = [[[invocation buffer] contentUTI] isEqualToString:kUTTypeCSS];
    
    if (!isCSS) {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: @"The UTI of the buffer was not \"public.css\"." };
        NSError *error = [NSError errorWithDomain:CSSErrorDomain
                                             code:CSSErrorNotCSS
                                         userInfo:userInfo];
        completionHandler(error);
        return;
    }
    
    NSString *cssVariableLiteral = @"--#variable : #value";
    
    [[[invocation buffer] lines] insertObject:cssVariableLiteral atIndex:0];
    
    // If user selected text, let's just put the variable at the top
//    NSArray <XCSourceTextRange *> *selections = [[invocation buffer] selections];
//    if ([selections count] > 0) {
//        XCSourceTextPosition start =  [[selections firstObject] start];
//        XCSourceTextPosition insertionPoint = XCSourceTextPositionMake(start.line - 1, 0);
//    }
    
    
    
    completionHandler(nil);
}

@end
