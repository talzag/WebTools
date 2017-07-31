//
//  SourceEditorCommand.m
//  JS Tools
//
//  Created by Daniel Strokis on 7/15/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "JSTemplateCommand.h"

static NSString *ES6ClassCommandID = @"NewClassES6";
static NSString *FunctionClassCommandID = @"NewClassFunction";

@implementation JSTemplateCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation
                   completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    NSError *error;
    if (![self content:[invocation buffer] isJS:&error]) {
        completionHandler(nil);
        return;
    }
    
    NSString *es6Template =
   @"class <#ClassName#> {\n"
    "   constructor() {\n"
    "       \n"
    "   }\n"
    "}\n";
    
    NSString *funcTemplate =
   @"var <#ClassName#> = function () {\n"
    "   \n"
    "}\n"
    "\n"
    "<#ClassName#>.prototype.<#method#> = function () {\n"
    "   \n"
    "}\n";
    
    NSString *command = [[[invocation commandIdentifier] componentsSeparatedByString:@"."] lastObject];
    
    NSString *classTemplate;
    if ([command isEqualToString:ES6ClassCommandID]) {
        classTemplate = es6Template;
    } else if ([command isEqualToString:FunctionClassCommandID]) {
        classTemplate = funcTemplate;
    } else {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: @"Unrecognized command identifier." };
        error = [NSError errorWithDomain:(NSString *)JSErrorDomain
                                    code:JSErrorUnrecognizedCommand
                                userInfo:userInfo];

        completionHandler(error);
        return;
    }
    
    NSMutableArray <NSString *> *lines = [[invocation buffer] lines];
    NSMutableArray <XCSourceTextRange *> *selections = [[invocation buffer] selections];
    
    XCSourceTextPosition start = [[selections firstObject] start];
    XCSourceTextPosition end = [[selections lastObject] end];
    
    NSRange range = NSMakeRange(start.line, end.line - start.line + 1);
    [lines removeObjectsInRange:range];
    [lines insertObject:classTemplate atIndex:start.line];
    
    
    completionHandler(nil);
}

@end
