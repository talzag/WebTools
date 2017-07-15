//
//  SourceEditorCommand.m
//  HTML Tools
//
//  Created by Daniel Strokis on 7/15/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "HTMLTemplateCommand.h"

static NSString *HTMLErrorDomain = @"com.dstrokis.WebTools.HTML-Tools.Error";

typedef NS_ENUM(NSUInteger, HTMLErrorCode) {
    HTMLErrorNotHTML
};

@implementation HTMLTemplateCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation
                   completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    BOOL isHTML = [[[invocation buffer] contentUTI] isEqualToString:(__bridge NSString *)kUTTypeHTML];
    
    if (!isHTML) {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: @"The UTI of the buffer was not \"public.html\"." };
        NSError *error = [NSError errorWithDomain:HTMLErrorDomain
                                             code:HTMLErrorNotHTML
                                         userInfo:userInfo];
        completionHandler(error);
        return;
    }
    
    NSString *htmlDocTemplate =
   @"<!DOCTYPE html>\n"
    "<html>\n"
    "   <head>\n"
    "       <title><#title#></title>\n"
    "   </head>\n"
    "   <body>\n"
    "       \n"
    "   </body>\n"
    "</html>\n";
    
    [[[invocation buffer] lines] insertObject:htmlDocTemplate atIndex:0];
    
    completionHandler(nil);
}

@end
