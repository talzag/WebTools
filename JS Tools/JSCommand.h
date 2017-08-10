//
//  JSCommand.h
//  WebTools
//
//  Created by Daniel Strokis on 7/17/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import <XcodeKit/XcodeKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString const *JSErrorDomain;

typedef NS_ENUM(NSUInteger, JSErrorCode) {
    JSErrorNotJS,
    JSErrorUnrecognizedCommand
};

@interface JSCommand : NSObject

/**
 Checks if a provided buffer contains JS source code.
 
 @param buffer Buffer to inspect
 @param error If the provided buffer is not JS, this param will be populated with an error;
 @return `YES` if the provided buffer has a content type of "public.js", `NO` otherwise
 */
- (BOOL)content:(XCSourceTextBuffer *)buffer isJS:(NSError **)error;

- (void)insertTemplate:(nonnull NSString *)template intoBuffer:(nonnull XCSourceTextBuffer *)buffer;

@end

NS_ASSUME_NONNULL_END
