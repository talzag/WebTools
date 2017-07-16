//
//  HTMLCommand.m
//  HTML Tools
//
//  Created by Daniel Strokis on 7/16/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "HTMLCommand.h"

static NSString *HTMLErrorDomain = @"com.dstrokis.WebTools.HTML-Tools.Error";

@implementation HTMLCommand

- (BOOL)content:(XCSourceTextBuffer *)buffer isHTML:(NSError * _Nullable __autoreleasing *)error {
    BOOL isHTML = [[buffer contentUTI] isEqualToString:(__bridge NSString *)kUTTypeHTML];
    
    if (!isHTML) {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: @"The UTI of the buffer was not \"public.html\"." };
        *error = [NSError errorWithDomain:HTMLErrorDomain
                                     code:HTMLErrorNotHTML
                                 userInfo:userInfo];
    }
    
    return isHTML;
}

@end
