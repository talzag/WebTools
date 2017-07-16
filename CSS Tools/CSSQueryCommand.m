//
//  CSSQueryCommand.m
//  CSS Tools
//
//  Created by Daniel Strokis on 7/16/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "CSSQueryCommand.h"

@implementation CSSQueryCommand

- (void)performCommandWithInvocation:(nonnull XCSourceEditorCommandInvocation *)invocation
                   completionHandler:(nonnull void (^)(NSError * _Nullable))completionHandler
{
    NSError *error;
    if (![self content:[invocation buffer] IsCSS:&error]) {
        completionHandler(nil);
        return;
    }
    
    NSString *iPhone7QueryLiteral =
   @"@media <#screen#> and (<#min-width: 375px#>) and (<#max-height: 667px#>) {\n"
    "   \n"
    "}\n";
    
    XCSourceTextPosition start = [[[[invocation buffer] selections] firstObject] start];
    [[[invocation buffer] lines] insertObject:iPhone7QueryLiteral atIndex:start.line];
    
    completionHandler(nil);
}

@end
