//
//  CSSCommand.h
//  CSS Tools
//
//  Created by Daniel Strokis on 7/15/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//


#import <XcodeKit/XcodeKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *CSSErrorDomain;
static NSString *kUTTypeCSS;

typedef NS_ENUM(NSUInteger, CSSErrorCode) {
    CSSErrorNotCSS
};

@interface CSSCommand : NSObject

/**
 Checks if a provided buffer contains CSS text.

 @param buffer Buffer to inspect
 @param error If the provided buffer is not CSS, this param will be populated with an error;
 @return `YES` if the provided buffer has a content type of "public.css", `NO` otherwise
 */
- (BOOL)content:(XCSourceTextBuffer *)buffer IsCSS:(NSError **)error;

- (BOOL)shouldReplaceLineAtPosition:(XCSourceTextPosition)position InBuffer:(XCSourceTextBuffer *)buffer;

@end

NS_ASSUME_NONNULL_END
