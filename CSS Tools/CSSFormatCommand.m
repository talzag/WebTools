//
//  CSSFormatCommand.m
//  WebTools
//
//  Created by Daniel Strokis on 7/28/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "CSSFormatCommand.h"

@implementation CSSFormatCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation
                   completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    NSError *error;
    if (![self content:[invocation buffer] isCSS:&error]) {
        completionHandler(nil);
        return;
    }
    
    
    
    completionHandler(nil);
}

@end
