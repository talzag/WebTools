//
//  HTMLCommand.h
//  HTML Tools
//
//  Created by Daniel Strokis on 7/16/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import <XcodeKit/XcodeKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString const *HTMLErrorDomain;

typedef NS_ENUM(NSUInteger, HTMLErrorCode) {
    HTMLErrorNotHTML
};

@interface HTMLCommand : NSObject 

/**
 Checks if a provided buffer contains HTML text.
 
 @param buffer Buffer to inspect
 @param error If the provided buffer is not HTML, this param will be populated with an error;
 @return `YES` if the provided buffer has a content type of "public.html", `NO` otherwise
 */
- (BOOL)content:(XCSourceTextBuffer *)buffer isHTML:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
