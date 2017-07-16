//
//  CSSCommand.h
//  CSS Tools
//
//  Created by Daniel Strokis on 7/15/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//


#import <XcodeKit/XcodeKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString const *CSSErrorDomain;
static NSString const *kUTTypeCSS;

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
- (BOOL)content:(XCSourceTextBuffer *)buffer isCSS:(NSError **)error;

/**
 Determines if the a specific line in a buffer is empty and can be replaced, or is not empty
 and should be preserved.

 @param position Position where text will be inserted
 @param buffer Command invocation buffer
 @return `YES` if the line of the given position in the buffer is empty, `NO` otherwise.
 */
- (BOOL)shouldReplaceLineAtPosition:(XCSourceTextPosition)position inBuffer:(XCSourceTextBuffer *)buffer;

@end

NS_ASSUME_NONNULL_END
