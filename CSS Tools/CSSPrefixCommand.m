//
//  CSSPrefixCommand.m
//  CSS Tools
//
//  Created by Daniel Strokis on 7/15/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "CSSPrefixCommand.h"

@implementation CSSPrefixCommand

- (void)performCommandWithInvocation:(nonnull XCSourceEditorCommandInvocation *)invocation
                   completionHandler:(nonnull void (^)(NSError * _Nullable))completionHandler
{
    NSError *error;
    if (![self content:[invocation buffer] IsCSS:&error]) {
        completionHandler(error);
        return;
    }
    
    completionHandler(nil);
}

@end
