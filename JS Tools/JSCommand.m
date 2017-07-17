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

@end
