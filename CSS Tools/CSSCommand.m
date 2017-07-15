//
//  CSSCommand.m
//  CSS Tools
//
//  Created by Daniel Strokis on 7/15/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "CSSCommand.h"

static NSString *CSSErrorDomain = @"com.dstrokis.WebTools.CSS-Tools.Error";
static NSString *kUTTypeCSS = @"public.css";

@implementation CSSCommand

- (BOOL)content:(XCSourceTextBuffer *)buffer IsCSS:(NSError * _Nullable __autoreleasing *)error {
    BOOL isCSS = [[buffer contentUTI] isEqualToString:kUTTypeCSS];
    
    if (!isCSS) {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: @"The UTI of the buffer was not \"public.css\"." };
        *error = [NSError errorWithDomain:CSSErrorDomain
                                     code:CSSErrorNotCSS
                                 userInfo:userInfo];
    }
    
    return isCSS;
}

@end
