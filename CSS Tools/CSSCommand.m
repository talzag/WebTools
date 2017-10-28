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

- (BOOL)content:(XCSourceTextBuffer *)buffer isCSS:(NSError * _Nullable __autoreleasing *)error {
    BOOL isCSS = [[buffer contentUTI] isEqualToString:kUTTypeCSS];
    
    if (!isCSS && error) {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: @"The file isn't a CSS file." };
        *error = [NSError errorWithDomain:CSSErrorDomain
                                     code:CSSErrorNotCSS
                                 userInfo:userInfo];
    }
    
    return isCSS;
}

- (BOOL)shouldReplaceLineAtPosition:(XCSourceTextPosition)position inBuffer:(XCSourceTextBuffer *)buffer {
    NSString *cursorLine = [[buffer lines] objectAtIndex:position.line];
    NSString *trimmedLine = [cursorLine stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [trimmedLine length] == 0;
}

@end
