//
//  JSCommand.m
//  WebTools
//
//  Created by Daniel Strokis on 7/17/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "JSCommand.h"

static NSString *JSErrorDomain = @"com.dstrokis.WebTools.JS-Tools.Error";

@implementation JSCommand

- (BOOL)content:(XCSourceTextBuffer *)buffer isJS:(NSError * _Nullable __autoreleasing *)error {
    BOOL isJS = [[buffer contentUTI] isEqualToString:@"com.netscape.javascript-source"];
    
    if (!isJS) {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: @"The UTI of the buffer was not \"public.js\"." };
        *error = [NSError errorWithDomain:JSErrorDomain
                                     code:JSErrorNotJS
                                 userInfo:userInfo];
    }
    
    return isJS;
}

- (void)insertTemplate:(nonnull NSString *)template intoBuffer:(nonnull XCSourceTextBuffer *)buffer {
    NSMutableArray <NSString *> *lines = [buffer lines];
    NSMutableArray <XCSourceTextRange *> *selections = [buffer selections];
    
    XCSourceTextPosition start = [[selections firstObject] start];
    XCSourceTextPosition end = [[selections lastObject] end];
    
    NSRange range = NSMakeRange(start.line, end.line - start.line + 1);
    
    if (range.length > 1) {
        [lines removeObjectsInRange:range];
    }
    
    [lines insertObject:template atIndex:start.line];
}

@end
